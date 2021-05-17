import 'package:flutter/material.dart';
import 'package:models/models.dart';

class OrderCard extends StatefulWidget {

  final Order order;

  OrderCard(this.order);

  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {

  static const bold = TextStyle(fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {

    var order = widget.order;
    var tableRows = <TableRow>[];
    order.items.forEach((key, value) => tableRows.add(buildItemTableRow(key, value)));

    return Card(
      child: ExpansionTile(
        leading: buildIsDelivered(order.isDelivered),
        title: Text('${order.customer.firstName} ${order.customer.lastName}'),
        subtitle: Text('${order.totalCost} ${Strings.get('toman')}', style: bold,),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Table(
              children: [
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('Food name', style: bold,),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('Unit price', style: bold,),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('Count', style: bold,),
                    ),
                  ]
                ),
                ...tableRows,
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top : 20.0, left: 8.0),
            child: Text(order.id ?? 'null'),
          ),
          Padding(
            padding: const EdgeInsets.only(top : 20.0, left: 8.0),
            child: Text(Strings.formatDate(order.time)),
          ),
          Padding(
            padding: const EdgeInsets.only(top : 20.0, left: 8.0),
            child: Text(order.customer.address.toString()),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0, left: 8.0),
            child: Row(
              children: [
                Text(Strings.get('order-bottom-sheet-is-ready')!),
                Switch(
                  value: order.isDelivered,
                  onChanged: (newValue) {
                    setState(() {
                      order.isDelivered = newValue;
                    }
                    );
                    if (newValue)
                      ScaffoldMessenger.of(context).showSnackBar(showBar(Strings.get('food-delivered-successful')!, Duration(milliseconds: 2000)));
                  }
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildIsDelivered(bool isDelivered) {
    return LimitedBox(
      child: ColoredBox(
        child: Icon(Icons.delivery_dining, color: Colors.white,),
        color: isDelivered ? Colors.green : Colors.amber,
      ),
    );
  }

  TableRow buildItemTableRow(FoodData foodData, int count) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(foodData.name),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 4.0),
          child: Text(foodData.price.toString()),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 4.0),
          child: Text((count).toString()),
        ),
      ]
    );
  }

}
