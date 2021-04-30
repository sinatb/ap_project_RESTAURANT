import 'package:flutter/material.dart';
import 'package:models/models.dart';

class OrderPagePanel extends StatefulWidget {
  @override
  _OrderPagePanelState createState() => _OrderPagePanelState();
}

class _OrderPagePanelState extends State<OrderPagePanel>
{
  List<Order> _ordersActive=[];
  List<Order> _previousOrders=[];
  @override
  Widget build(BuildContext context) {

    _ordersActive = (Head.of(context).server.account as OwnerAccount).activeOrders;
    _previousOrders = (Head.of(context).server.account as OwnerAccount).previousOrders;


    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          centerTitle: true,
          title: Text(Strings.get('orders-menu-header')!,),
        ),
        ...buildListOfOrders(context, _ordersActive),
        ...buildListOfOrders(context, _previousOrders),

      ],
    );

  }

  List<Widget> buildListOfOrders(BuildContext context, List<Order> orders) {
    return <Widget>[
      SliverPadding(
        padding: EdgeInsets.all(15),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              buildListElements(context, orders.elementAt(index));
            },
            childCount: orders.length,
          ),
        ),
      )
    ];
  }

  Widget buildListElements(BuildContext context , Order order)
  {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: buildAvailableIcon(order.isDelivered),
            title:Text(order.customer.firstName),
            subtitle: Text(order.time.toString()),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              buildModelButton('Details', CommonColors.green as Color, (){
                showDetailsModalSheet(order);
              })
            ],
          )
        ],
      ),
    );
  }

  void showDetailsModalSheet(Order order)
  {

  }

  Icon buildAvailableIcon(bool isAvailable) {
    if (isAvailable) {
      return Icon(Icons.check_circle, color: Colors.green,);
    }
    return Icon(Icons.highlight_remove_rounded, color: Colors.red,);
  }
}

