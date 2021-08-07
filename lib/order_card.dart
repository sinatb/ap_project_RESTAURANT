import 'package:flutter/material.dart';
import 'package:models/models.dart';

class OrderCard extends StatefulWidget {

  final Order order;

  OrderCard(this.order);

  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {

  TextStyle? textStyle;
  TextStyle? textStyleBold;

  @override
  Widget build(BuildContext context) {

    textStyle = Theme.of(context).textTheme.bodyText1;
    textStyleBold = Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w600);
    var order = widget.order;
    var tableRows = <TableRow>[];
    order.items.forEach((key, value) => tableRows.add(buildItemTableRow(key, value)));

    return Card(
      child: ExpansionTile(
        leading: buildIsDelivered(order.isDelivered),
        title: Text('${order.customer.firstName} ${order.customer.lastName}', style: TextStyle(fontWeight: FontWeight.w600),),
        subtitle: Text('${order.totalCost} ${Strings.get('toman')}'),
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
                      child: Text(Strings.get('order-card-food-name')!, style: textStyleBold,),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(Strings.get('order-card-unit-price')!, style: textStyleBold,),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(Strings.get('order-card-count')!, style: textStyleBold,),
                    ),
                  ]
                ),
                ...tableRows,
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top : 20.0, left: 8.0),
            child: Wrap(children: [Icon(Icons.code), Text(order.code, style: textStyle,)], spacing: 5, crossAxisAlignment: WrapCrossAlignment.center,),
          ),
          Padding(
            padding: const EdgeInsets.only(top : 20.0, left: 8.0),
            child: Wrap(children: [Icon(Icons.access_time_rounded), Text(Strings.formatDate(order.time), style: textStyle,)], spacing: 5, crossAxisAlignment: WrapCrossAlignment.center,),
          ),
          Padding(
            padding: const EdgeInsets.only(top : 20.0, left: 8.0),
            child: Wrap(children: [Icon(Icons.location_on_outlined), Text(order.customer.address.toString(), style: textStyle,)], spacing: 5, crossAxisAlignment: WrapCrossAlignment.center,),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0, left: 8.0),
            child: Row(
              children: [
                Text(Strings.get('order-bottom-sheet-is-ready')!, style: textStyle,),
                Switch(
                  value: order.isDelivered,
                  onChanged: (newValue) {
                    if (newValue == false) return;
                    setState(() {
                      order.isDelivered = newValue;
                    }
                    );
                    if (newValue)
                      ScaffoldMessenger.of(context).showSnackBar(showBar(Strings.get('food-delivered-successful')!, Duration(milliseconds: 2000)));
                  },
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
        color: isDelivered ? CommonColors.themeColorGreen : Theme.of(context).accentColor,
      ),
    );
  }

  TableRow buildItemTableRow(FoodData foodData, int count) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(foodData.name, style: textStyle,),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 4.0),
          child: Text(foodData.price.toString(), style: textStyle,),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 4.0),
          child: Text((count).toString(), style: textStyle,),
        ),
      ]
    );
  }

}
