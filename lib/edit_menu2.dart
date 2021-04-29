import 'package:flutter/material.dart';
import 'package:models/models.dart';

class EditMenuPanel extends StatefulWidget {
  @override
  _EditMenuPanelState createState() => _EditMenuPanelState();
}

class _EditMenuPanelState extends State<EditMenuPanel> {

  FoodMenu? menu;
  var goodColor = Color(0xff05a8aa);
  var defaultBoxShadow = BoxShadow(spreadRadius: 0.4, blurRadius: 3, color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    menu = (Head.of(context).server.account as OwnerAccount).restaurant.menu;
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          title: Text(Strings.get('bottom-nav-label-edit')!,),
          actions: [
            IconButton(icon: Icon(Icons.settings), onPressed: (){}),
            IconButton(icon: Icon(Icons.search), onPressed: (){}),
          ],
        ),
        buildHeader(Strings.get('edit-menu-categories-header')!, goodColor, 24),
        SliverPadding(
          padding: EdgeInsets.all(10),
          sliver: SliverGrid.count(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 1,
            children: [
              for (var category in menu!.categories)
                buildCategoryGridItem(category)
            ],
          ),
        ),
        for (var category in menu!.categories)
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

  Widget buildHeader(String title, Color textColor, double fontSize) {
    return SliverPadding(
      padding: EdgeInsets.all(10),
      sliver: SliverToBoxAdapter(child: Text(title, style: TextStyle(color: textColor, fontSize: fontSize,),)),
    );
  }

  List<Widget> buildFoodsGridView(BuildContext context, FoodCategory category) {
    return <Widget>[
      buildHeader(Strings.get(category.toString())!, goodColor, 24.0),
      SliverPadding(
        padding: EdgeInsets.all(10),
        sliver: SliverGrid.count(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 0.7,
          children: [
            for (var food in menu!.getFoods(category)!)
              buildFoodGridItem(food, context)
          ],
        ),
      ),
    ];
  }

  buildFoodGridItem(Food food, BuildContext context) {
    return Card(
      child: Column(
        children: [
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
            ),
            flex: 5,
            fit: FlexFit.tight,
          ),
          Flexible(
            child: ListTile(
              title: Text(food.name),
              trailing: buildAvailableIcon(food.isAvailable),
              subtitle: Text('${food.price} Toman'),
            ),
            flex: 2,
            fit: FlexFit.tight,
          ),
          Flexible(
            child: TextButton(
              onPressed: () => showFoodBottomSheet(food),
              child: Text('Edit'),
            ),
            flex: 1,
            fit: FlexFit.tight,
          )
        ],
      ),
    );
  }

  Icon buildAvailableIcon(bool isAvailable) {
    if (isAvailable) {
      return Icon(Icons.check_circle, color: Colors.green,);
    }
    return Icon(Icons.highlight_remove_rounded, color: Colors.red,);
  }

  void showFoodBottomSheet(Food food) {
  }

  jumpToCategory(FoodCategory category) {}

}
