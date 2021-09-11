import 'package:flutter/material.dart';
import 'package:brew_crew/models/brew.dart';

class BrewTile extends StatelessWidget {
  final Brew? brew;
  BrewTile({Key? key, this.brew}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
            margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
            child: ListTile(
              leading: CircleAvatar(
                radius: 25.0,
                backgroundColor: Colors.brown[brew!.strength],
                backgroundImage: NetworkImage(
                    'https://github.com/iamshaunjp/flutter-firebase/blob/lesson-27/brew_crew/assets/coffee_icon.png?raw=true'),
              ),
              title: Text('${brew!.name}'),
              subtitle: Text('Take ${brew!.sugars} sugar(s)'),
            )));
  }
}
