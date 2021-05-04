import 'package:flutter/material.dart';
import 'package:models/models.dart';
import 'reused_ui.dart';
import 'order_bottom_sheet.dart';

class OrderCard extends StatefulWidget {

  final Order order;

  OrderCard(this.order);

  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {

  @override
  Widget build(BuildContext context) {

    var order = widget.order;

    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: buildAvailableIcon(order.isDelivered),
            title: Text(order.customer.firstName),
            subtitle: Text(order.time.toString()),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              buildModelButton('Details', CommonColors.green as Color, () {
                showDetailsModalSheet(order);
              })
            ],
          ),
        ],
      ),
    );
  }

  void showDetailsModalSheet(Order order)  {
    showModalBottomSheet(
      context: context,
      builder: (context) => OrderBottomSheet(order, () => setState(() {})),
    );
  }

}
