import 'package:flutter/material.dart';
import 'package:models/models.dart';


class OrderBottomSheet extends StatefulWidget {
  final Order order;
  final VoidCallback orderPageRebuild;

  OrderBottomSheet(this.order , this.orderPageRebuild) :super();
  @override
  _OrderBottomSheetState createState() => _OrderBottomSheetState();
}

class _OrderBottomSheetState extends State<OrderBottomSheet> {
  List<Widget> buildFoodOrderItems(Order order) {
    List<Widget> retVal = [];
    order.items.forEach((key, value) {
      retVal.add(Card(
        child: Row(
          children: [
            Container(
              child: Container(
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              )),
            ),
            Spacer(flex: 1,),
            Container(
                child: Container(
                  child: Text(key.name),
              ),

            ),
            Spacer(flex: 2,),
            Container(
                child: Container(
                  child: Text(order.items[key].toString()),
                ),
            ),
            Spacer(flex: 1,),
            Container(
               child: Container(
                child: Text((key.price.toInt()*order.items[key]!).toString()),
              )
            )
          ],
        ),
      ));
    });
    return retVal;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                initialValue: (widget.order.customer.firstName + ' '+widget.order.customer.lastName),
                decoration: InputDecoration(
                  icon: Icon(Icons.person),
                ),
                enabled: false,
              )
          ),
          Padding(
              padding: EdgeInsets.all(10),
              child:TextFormField(
                initialValue: widget.order.time.toString(),
                decoration: InputDecoration(
                  icon: Icon(Icons.timer)
                ),
                enabled: false,
              ),
          ),
          ...buildFoodOrderItems(widget.order),
          Text(Strings.get('order-bottom-sheet-is-ready')!),
          Padding(
            padding: EdgeInsets.all(5),
            child: Switch(
              value: widget.order.isDelivered,
              onChanged: (value) {
                setState(() {
                  widget.order.isDelivered = value;
                  widget.orderPageRebuild();
                });
              },
              activeColor: CommonColors.green,
              inactiveTrackColor: CommonColors.red,
            ),
          )
        ],
      ));
    }
}
