import 'package:flutter/material.dart';
import 'package:models/models.dart';
import 'order_card.dart';
import 'settings.dart';

class OrdersPanel extends StatefulWidget {
  @override
  _OrdersPanelState createState() => _OrdersPanelState();
}

class _OrdersPanelState extends State<OrdersPanel>
{
  late List<Order> _activeOrders;
  late List<Order> _previousOrders;
  @override
  Widget build(BuildContext context) {

    _activeOrders = (Head.of(context).server.account as OwnerAccount).activeOrders;
    _previousOrders = (Head.of(context).server.account as OwnerAccount).previousOrders;

    TextStyle headerStyle = Theme.of(context).textTheme.headline1!;

    return RefreshIndicator(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            centerTitle: true,
            title: Text(Strings.get('orders-menu-header')!,style: headerStyle,),
          ),
          if (_activeOrders.isNotEmpty)
            buildHeader(Strings.get('order-page-active-orders')!, headerStyle),
          if (_activeOrders.isNotEmpty)
            buildListOfOrders(context, _activeOrders),
          if (_previousOrders.isNotEmpty)
            buildHeader(Strings.get('order-page-inactive-orders')!, headerStyle),
          if (_previousOrders.isNotEmpty)
            buildListOfOrders(context, _previousOrders),
          if (_activeOrders.isEmpty && _previousOrders.isEmpty)
            SliverToBoxAdapter(
              child: Center(
                child: Text(Strings.get('no-order-message')!),
              ),
            )
        ],
      ),
      onRefresh: refreshList,
    );
  }

  Widget buildListOfOrders(BuildContext context, List<Order> orders) {
    return SliverPadding(
        padding: EdgeInsets.all(10),
        sliver: SliverList(
          delegate: SliverChildListDelegate(
            orders.map((e) => OrderCard(e)).toList(),
          ),
        ),
      );
  }


  Future<void> refreshList() async {
    await Head.of(context).server.refreshActiveOrders();
    return Future.delayed(Duration(milliseconds: 300), () => setState((){}));
  }
}

