import 'package:flutter/material.dart';
import 'package:models/models.dart';

class CommentsPanel extends StatefulWidget {

  @override
  _CommentsPanelState createState() => _CommentsPanelState();
}

class _CommentsPanelState extends State<CommentsPanel> {

  @override
  Widget build(BuildContext context) {

    var commentIDs = (Head.of(context).server.account as OwnerAccount).restaurant.commentIDs;
    final shadows = [BoxShadow(blurRadius: 5, spreadRadius: 1, color: Theme.of(context).shadowColor.withOpacity(0.2))];

    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.get('comments-panel-title')!),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          var comment;
          getComment(comment, commentIDs[index]);
          return Container(
            margin: EdgeInsets.all(10),
            child: CommentTile(comment: comment, isForOwner: true),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).cardColor,
              boxShadow: shadows,
            ),
          );
        },
        itemCount: commentIDs.length,
      ),
    );
  }
  Future getComment(var comment , String commentID) async{
    comment = await Head.of(context).server.getObjectByID(commentID);
  }
}
