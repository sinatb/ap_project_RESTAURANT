import 'package:flutter/material.dart';
import 'package:models/models.dart';

class CommentsPanel extends StatefulWidget {

  @override
  _CommentsPanelState createState() => _CommentsPanelState();
}

class _CommentsPanelState extends State<CommentsPanel> {

  bool loaded = false;
  var commentIDs = <String>[];
  var comments = <Comment>[];

  @override
  Widget build(BuildContext context) {
    var server = Head.of(context).ownerServer;
    if (!loaded) {
      server.getObjectByID<Restaurant>(server.restaurant.id!).then((value) async {
        var menu = server.restaurant.menu;
        server.account.restaurant = value as Restaurant;
        server.restaurant.menu = menu;
        commentIDs = server.restaurant.commentIDs;
        for (var id in commentIDs) {
          comments.add(await server.getObjectByID<Comment>(id) as Comment);
        }
        setState(() {
          loaded = true;
        });
      });
    }
    final shadows = [BoxShadow(blurRadius: 5, spreadRadius: 1, color: Theme.of(context).shadowColor.withOpacity(0.2))];

    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.get('comments-panel-title')!),
      ),
      body: loaded ? ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(10),
            child: CommentTile(comment: comments[index], isForOwner: true),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).cardColor,
              boxShadow: shadows,
            ),
          );
        },
        itemCount: comments.length,
      ) : Center(child: Text('loading...')),
    );
  }
}
