import 'package:flutter/material.dart';
import 'package:models/models.dart';
import 'edit_food_bottom_sheet.dart';
import 'reused_ui.dart';

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
              child : Head.of(context).depot[widget.food] ?? Image.asset('assets/default_food.jpg' , package: 'models',),
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

  void showFoodBottomSheet(Food food) async {
    var pressedSave = await showModalBottomSheet(
      context: context,
      builder: (context) => EditBottomSheet(food, widget.rebuildMenu),
    );
    if (pressedSave == true) {
      setState(() {
      });
    }
  }
}
