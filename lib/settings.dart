import 'package:flutter/material.dart';
import 'package:models/models.dart';
import 'comments_panel.dart';
import 'map_page.dart';

class SettingsPanel extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    var restaurant = (Head.of(context).server.account! as OwnerAccount).restaurant;
    Account account = Head.of(context).server.account!;

    const bigHeading = TextStyle(fontSize: 28, fontWeight: FontWeight.bold);
    const smallHeading = TextStyle(fontSize: 22, fontWeight: FontWeight.bold);
    const regular = TextStyle(fontSize: 18);
    const regularBold = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
    const verticalPadding = 12.0;

    return Scaffold(
        appBar: AppBar(
          title: Text(Strings.get('settings-appbar-title')!),
          elevation: 1.0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Strings.get('restaurant-info-label')!,
                  style: bigHeading,
                ),
                Divider(
                  thickness: 2,
                ),
                Text(
                  Strings.get('restaurant-name-label')!,
                  style: smallHeading,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: verticalPadding),
                  child: Text(
                    restaurant.name,
                    style: regular,
                  ),
                ),
                Text(
                  Strings.get('restaurant-address-label')!,
                  style: smallHeading,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: verticalPadding),
                  child: Text(
                    restaurant.address.text,
                    style: regular,
                  ),
                ),
                Text(
                  Strings.get('owner-phone-number-label')!,
                  style: smallHeading,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: verticalPadding),
                  child: Text(
                    Strings.censorPhoneNumber(account.phoneNumber),
                    style: regular,
                  ),
                ),
                Wrap(
                  spacing: 5,
                  children: [
                    Text(
                      Strings.get('restaurant-score-label')!,
                      style: smallHeading,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.orange,
                    ),
                    Text(
                      restaurant.score.toStringAsPrecision(2),
                      style: regularBold,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: verticalPadding + 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(
                        child: buildModelButton(Strings.get('comment-button')!,
                            Theme.of(context).primaryColor, () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CommentsPanel()));
                        }),
                      ),
                      Center(
                        child: buildModelButton(Strings.get('map-button')!,
                            Theme.of(context).buttonColor, () async {
                          var coordinates = await Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => MapPage()));
                          if (coordinates == null) return;
                          restaurant.address.latitude = coordinates['lat'];
                          restaurant.address.longitude = coordinates['lng'];
                          restaurant.areaOfDispatch = coordinates['radius'];
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
