import 'package:fetch_data_card/user.dart';
import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  Detail({Key key, @required this.userId}) : super(key: key);

  final User userId;

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Page ID: ${widget.userId.id}'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Image.network('${widget.userId.image}'),
            ),
            Container(
              child: Image.network('${widget.userId.profile}'),
            ),
            Container(
              child: Text('${widget.userId.title}'),
            ),
          ],
        ),
      ),
    );
  }
}
