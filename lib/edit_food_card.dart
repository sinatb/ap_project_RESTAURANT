import 'package:flutter/material.dart';
import 'package:models/models.dart';
import 'edit_food_bottom_sheet.dart';

class EditFoodCard extends StatefulWidget {
  final Food food;
  final VoidCallback rebuildMenu;

  EditFoodCard(this.food, this.rebuildMenu)  : super();

  @override
  _EditFoodCardState createState() => _EditFoodCardState();
}

class _EditFoodCardState extends State<EditFoodCard> {

  @override
  build(BuildContext context) {
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
              title: Text(widget.food.name),
              trailing: buildAvailableIcon(widget.food.isAvailable),
              subtitle: Text('${widget.food.price} ${Strings.get('toman')}'),
            ),
            flex: 2,
            fit: FlexFit.tight,
          ),
          Flexible(
            child: TextButton(
              onPressed: () => showFoodBottomSheet(widget.food),
              child: Text(Strings.get('food-item-edit-button')!),
            ),
            flex: 1,
            fit: FlexFit.tight,
          )
        ],
      ),
    );
  }

  Widget buildAvailableIcon(isAvailable) {
    if (isAvailable) {
      return Icon(Icons.check_circle, color: Colors.green,);
    }
    return Icon(Icons.highlight_remove_rounded, color: Colors.red,);
  }

  void showFoodBottomSheet(Food food) async {
    await showModalBottomSheet(
      context: context,
      builder: (context) => EditBottomSheet(food, widget.rebuildMenu),
      isDismissible: false,
    );
    setState(() {
    });
  }
}
