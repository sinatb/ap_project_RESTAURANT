import 'package:flutter/material.dart';
import 'package:models/models.dart';
import 'package:restaurant/add_food.dart';
import 'edit_food_card.dart';
import 'menu_search_bottom_sheet.dart';

class EditMenuPanel extends StatefulWidget {
  @override
  _EditMenuPanelState createState() => _EditMenuPanelState();
}

class _EditMenuPanelState extends State<EditMenuPanel> {

  late FoodMenu menu;
  var defaultBoxShadow = BoxShadow(spreadRadius: 0.4, blurRadius: 3, color: Colors.grey);
  bool inSearchMode = false;
  late TextStyle headerStyle;

  @override
  Widget build(BuildContext context) {
    headerStyle = TextStyle(color: Theme.of(context).accentColor, fontSize: 24);
    if (!inSearchMode) {
      menu = (Head.of(context).server.account as OwnerAccount).restaurant.menu!;
    }
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          centerTitle: true,
          leading: inSearchMode ? null : IconButton(icon: Icon(Icons.add), tooltip: Strings.get('add-food-tooltip'),
            onPressed:() async {
              var newFood = await showModalBottomSheet(context: context,
                  builder:(context)=>AddFood(),
              );
              if (newFood != null) {
                setState(() {
                  menu.addFood(newFood);
                });
              }
            },
          ),
          title: Text(Strings.get('bottom-nav-label-edit')!,),
          actions: [
            IconButton(icon: Icon(inSearchMode ? Icons.close : Icons.search), tooltip: Strings.get('search-menu-tooltip'), onPressed: () async {
              if (inSearchMode) {
                setState(() {
                  inSearchMode = false;
                });
                return;
              }
              var predicate = await showModalBottomSheet(context: context, builder: (context) => SearchBottomSheet());
              if (predicate == null) return;
              setState(() {
                menu = menu.toSubMenu(predicate);
                inSearchMode = true;
              });
            }),
          ],
        ),
        if (!inSearchMode)
          buildHeader(Strings.get('edit-menu-categories-header')!, headerStyle),
        if (!inSearchMode)
          SliverPadding(
            padding: EdgeInsets.all(10),
            sliver: SliverGrid.count(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: 1,
              children: menu.categories.map((e) => buildCategoryGridItem(e)).toList(),
            ),
          ),
        for (var category in menu.categories)
          ...buildFoodsGridView(context, category)
      ],
    );
  }

  Widget buildCategoryGridItem(FoodCategory category) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor
              ),
            ),
            flex: 3,
            fit: FlexFit.tight,
          ),
          Flexible(
            child: Container(
              color: Theme.of(context).cardColor,
              child: Center(
                child: Text(Strings.get(category.toString())!,
                  style: TextStyle(color: CommonColors.black, fontSize: 20),
                ),
              ),
            ),
            flex: 1,
            fit: FlexFit.tight,
          )
        ],
      ),
    );
  }

  List<Widget> buildFoodsGridView(BuildContext context, FoodCategory category) {
    return <Widget>[
      buildHeader(Strings.get(category.toString())!, headerStyle),
      SliverPadding(
        padding: EdgeInsets.all(10),
        sliver: SliverGrid.count(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 0.7,
          children: [
            for (var food in menu.getFoods(category)!)
              EditFoodCard(food, () => setState((){}))
          ],
        ),
      ),
    ];
  }
  jumpToCategory(FoodCategory category) {}
}
