import 'package:flutter/material.dart';
import 'package:models/models.dart';
import 'order_card.dart';
import 'reused_ui.dart';

class OrdersPanel extends StatefulWidget {
  @override
  _OrdersPanelState createState() => _OrdersPanelState();
}

class _OrdersPanelState extends State<OrdersPanel>
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
            orders.map((order) => OrderCard(order)).toList(),
          ),
        ),
      );
  }

}

