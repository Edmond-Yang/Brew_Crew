import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/models/crew.dart';
import 'package:brew_crew/screens/home/brewList.dart';
import 'package:brew_crew/screens/home/setting_form.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final AuthServices _auth = AuthServices();
  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _showSettingPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
                child: SettingForm());
          });
    }

    return StreamProvider<List<Brew?>?>.value(
        value: DatabaseService(uid: Provider.of<Crew?>(context)!.uid).brews,
        initialData: null,
        child: Scaffold(
          backgroundColor: Colors.brown[50],
          appBar: AppBar(
            title: Text('Brew Crew'),
            backgroundColor: Colors.brown[400],
            elevation: 0.0,
            actions: [
              TextButton.icon(
                onPressed: () async {
                  await _auth.signOut();
                },
                icon: Icon(Icons.person),
                label: Text('Log Out'),
                style: TextButton.styleFrom(primary: Colors.white),
              ),
              TextButton.icon(
                onPressed: () {
                  _showSettingPanel();
                },
                icon: Icon(Icons.settings),
                label: Text('Setting '),
                style: TextButton.styleFrom(primary: Colors.white),
              ),
            ],
          ),
          body: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://github.com/iamshaunjp/flutter-firebase/blob/lesson-27/brew_crew/assets/coffee_bg.png?raw=true'),
                      fit: BoxFit.cover)),
              child: BrewList()),
        ));
  }
}
