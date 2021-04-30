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
        buildListOfOrders(context, _ordersActive),
        //buildListOfOrders(context, _previousOrders),
      ],
    );

  }

  Widget buildListOfOrders(BuildContext context, List<Order> orders) {
    return SliverPadding(
        padding: EdgeInsets.all(10),
        sliver: SliverList(
          delegate: SliverChildListDelegate(
            sliverChildListDelegateWidgetBuilder(context,orders)
          ),
        ),
      );
  }
  List<Widget> sliverChildListDelegateWidgetBuilder(BuildContext context,List<Order> orders)
  {
   return List<Widget>.generate(orders.length, (index) => buildListElements(context, orders.elementAt(index)));
  }
  Widget buildListElements(BuildContext context, Order order) {
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

  void showDetailsModalSheet(Order order)
  {
    //to be implemented
  }

  Icon buildAvailableIcon(bool isAvailable) {
    if (isAvailable) {
      return Icon(Icons.check_circle, color: Colors.green,);
    }
    return Icon(Icons.highlight_remove_rounded, color: Colors.red,);
  }
}

