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
        children: [
          ListTile(
            leading: buildIsDelivered(order.isDelivered),
            title: Text('${order.customer.firstName} ${order.customer.lastName}'),
            subtitle: Text('${order.totalCost} ${Strings.get('toman')}'),
            trailing: TextButton(
              onPressed: () => showDetailsModalSheet(order),
              child: Text(Strings.get('order-details-button')!),
            ),
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

  Widget buildIsDelivered(bool isDelivered) {

    if (isDelivered) {
      return Icon(Icons.done_rounded, color: Colors.green,);
    }
    return Icon(Icons.close, color: Colors.red,);
  }

}
