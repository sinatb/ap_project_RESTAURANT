import 'package:flutter/material.dart';
import 'package:models/models.dart';
import 'settings.dart';

class StatsPanel extends StatefulWidget {

  @override
  _StatsPanelState createState() => _StatsPanelState();
}

class _StatsPanelState extends State<StatsPanel> {

  int selectedChip = 0;
  final chips = [Strings.get('all'), Strings.get('today')];
  late DateTime now;
  var shadows;

  @override
  Widget build(BuildContext context) {

    now = DateTime.now();
    shadows = [BoxShadow(blurRadius: 5, spreadRadius: 1, color: Theme.of(context).shadowColor.withOpacity(0.2))];

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text(Strings.get('stats-title')! , style: Theme.of(context).textTheme.headline1,),
          centerTitle: true,
          actions: [
            IconButton(icon: Icon(Icons.settings_rounded),color: Theme.of(context).iconTheme.color,
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPanel())))
          ],
        ),
        SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 6.0),
            width: MediaQuery.of(context).size.width,
            child: buildHeading(),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              boxShadow: shadows,
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(8.0),
          sliver: SliverToBoxAdapter(
            child: Wrap(
              spacing: 10,
              children: List<Widget>.generate(
                chips.length,
                  (index) => ChoiceChip(
                    label: Text(chips[index]!),
                    selected: index == selectedChip,
                    onSelected: (value) {
                      setState(() {
                        selectedChip = value ? index : selectedChip;
                      });
                    },
                  ),
              ),
            ),
          ),
        ),
        buildRecordCard(),
      ],
    );
  }

 Widget buildHeading() {
    return Wrap(
      spacing: 10,
      children: [
        Icon(Icons.today, color: Theme.of(context).primaryColorDark,),
        Text('${Strings.get('today')}: ${Strings.formatDay(now)}',
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  Widget buildRecordCard() {
    var countPrice =
    (Head.of(context).server.account as OwnerAccount)
        .calculateCountPrice(selectedChip == 0 ? null : now, true);
    int count = countPrice[0];
    Price total = Price(countPrice[1]);

    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius:BorderRadius.circular(10),
          color: Theme.of(context).cardColor,
          boxShadow: shadows,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Record of Sale:', style: Theme.of(context).textTheme.headline6,),
            ),
            Table(
              children: [
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Title'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Count'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Price'),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Total sale'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(count.toString()),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('${total.toString()} ${Strings.get('toman')}'),
                    ),
                  ]
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

}
