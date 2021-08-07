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

    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.get('comments-panel-title')!, style: Theme.of(context).textTheme.headline5,),
      ),
      body: loaded ? (comments.isEmpty ? Center(child: Text(Strings.get('restaurant-no-comments')!),) : ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: CommentTile(comment: comments[index], isForOwner: true),
          );
        },
        itemCount: comments.length,
      )) : Center(child: Text('loading...')),
    );
  }
}
