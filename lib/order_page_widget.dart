import 'package:flutter/material.dart';
import 'package:models/models.dart';
import 'package:restaurant/order_buttom_sheet.dart';
import 'reused_ui.dart';

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
        buildHeader(Strings.get('order-page-active-orders')!, CommonColors.cyan, 24),
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

  void showDetailsModalSheet(Order order)  {
     showModalBottomSheet(
        context: context,
        builder: (context) => OrderBottomSheet(order, ()=>setState(() {})),
    );
  }
}

