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
        buildHeader(Strings.get('edit-menu-categories-header')!, Colors.white, goodColor, 18),
        SliverPadding(
          padding: EdgeInsets.all(10),
          sliver: SliverGrid.count(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 1,
            children: [
              for (var category in menu!.categories)
                buildCategoryGridItem(context, category)
            ],
          ),
        ),
        for (var category in menu!.categories)
          ...buildFoodsGridView(context, category)
      ],
    );
  }

  Widget buildCategoryGridItem(BuildContext context, FoodCategory category) {
    return GestureDetector(
      child: Container(
        child: Stack(
          children: [
            Positioned(
              left: 6,
              bottom: 0,
              child: Text(Strings.get(category.toString())!, style: TextStyle(color: CommonColors.black, fontSize: 20),),
            )
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Theme.of(context).primaryColor, width: 1.0),
        ),
      ),
      onTap: jumpToCategory(category),
    );
  }

  Widget buildHeader(String title, Color textColor, Color backgroundColor, double fontSize) {
    return SliverPadding(
      padding: EdgeInsets.all(10),
      sliver: SliverToBoxAdapter(
        child: DecoratedBox(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(title, style: TextStyle(color: textColor, fontSize: fontSize),),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: backgroundColor,
            boxShadow: [defaultBoxShadow]
          ),
        ),
      ),
    );
  }

  List<Widget> buildFoodsGridView(BuildContext context, FoodCategory category) {
    return <Widget>[
      buildHeader(Strings.get(category.toString())!, Colors.white, goodColor, 18.0),
      SliverPadding(
        padding: EdgeInsets.all(10),
        sliver: SliverGrid.count(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 1,
          children: [
            for (var food in menu!.getFoods(category)!)
              buildFoodGridItem(food, context)
          ],
        ),
      ),
    ];
  }

  buildFoodGridItem(Food food, BuildContext context) {
    return GestureDetector(
      child: Container(
        child: Stack(
          children: [
            // Image.asset(name),
            Positioned(
              child: Text(food.name),
              left: 6,
              bottom: 3,
            ),
            Positioned(
              child: buildAvailableIcon(food.isAvailable),
              right: 6,
              bottom: 3,
            ),
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Theme.of(context).primaryColor, width: 1.0),
        ),
      ),
      onTap: showFoodBottomSheet(food, context),
    );
  }

  Icon buildAvailableIcon(bool isAvailable) {
    if (isAvailable) {
      return Icon(Icons.check_circle, color: Colors.green,);
    }
    return Icon(Icons.highlight_remove_rounded, color: Colors.red,);
  }

  showFoodBottomSheet(Food food, BuildContext context) {}

  jumpToCategory(FoodCategory category) {}

}
