import 'package:flutter/material.dart';
import 'package:models/models.dart';
import 'order_card.dart';

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

    var account = Head.of(context).ownerServer.account;
    _activeOrders = account.activeOrders;
    _previousOrders = account.previousOrders;

    TextStyle headerStyle = Theme.of(context).textTheme.headline1!.copyWith(color: Theme.of(context).colorScheme.secondaryVariant);

    return RefreshIndicator(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            centerTitle: true,
            title: Text(Strings.get('orders-menu-header')!,style: Theme.of(context).textTheme.headline1,),
          ),
            buildHeader(Strings.get('order-page-active-orders')!, headerStyle),
          if (_activeOrders.isNotEmpty)
            buildListOfOrders(context, _activeOrders)
          else
            SliverToBoxAdapter(
              child: Center(
                child: Text(Strings.get('orders-no-active-orders')!),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 15,),),
            buildHeader(Strings.get('order-page-inactive-orders')!, headerStyle),
          if (_previousOrders.isNotEmpty)
            buildListOfOrders(context, _previousOrders)
          else
            SliverToBoxAdapter(
              child: Center(
                child: Text(Strings.get('orders-no-previous-orders')!),
              ),
            ),
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
    await Head.of(context).ownerServer.refreshActiveOrders();
    return Future.delayed(Duration(milliseconds: 300), () => setState((){}));
  }
}

