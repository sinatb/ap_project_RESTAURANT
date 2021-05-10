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

    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemBuilder: (context, index) {
          var comment = Head.of(context).server.getObjectByID(commentIDs[index]) as Comment;
          return CommentTile(comment: comment, isForOwner: true);
        },
        itemCount: commentIDs.length,
      ),
    );
  }
}
