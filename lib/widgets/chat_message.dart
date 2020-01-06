import 'package:flutter/material.dart';

const String name = 'Xeon';

class ChatMessage extends StatelessWidget {
  final String text;
  final AnimationController animationController;

  ChatMessage({this.text, this.animationController});

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
      axisAlignment: 0.0,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 16.0),
              child: CircleAvatar(
                child: Text(name[0]),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name,
                    style: Theme.of(context).textTheme.subhead,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5.0),
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(color: Colors.cyan[100], borderRadius: BorderRadius.circular(15.0)),
                    child: Text(text),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
