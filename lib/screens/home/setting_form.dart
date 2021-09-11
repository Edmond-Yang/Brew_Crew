import 'package:brew_crew/models/crew.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingForm extends StatefulWidget {
  const SettingForm({Key? key}) : super(key: key);

  @override
  _SettingFormState createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CrewData>(
        stream: DatabaseService(uid: Provider.of<Crew?>(context)!.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            CrewData crewData = snapshot.data!;

            return Form(
              key: _formKey,
              child: Column(
                children: [
                  Center(
                      child: Text('Update Your Brew Setting',
                          style: TextStyle(fontSize: 18.0))),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    initialValue: crewData.name,
                    validator: (value) {
                      return value!.isEmpty ? 'Please Enter a Name' : null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _currentName = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  DropdownButtonFormField(
                      elevation: 0,
                      value: _currentSugars ?? crewData.sugars,
                      onChanged: (value) {
                        setState(() {
                          _currentSugars = value.toString();
                        });
                      },
                      items: sugars.map((sugar) {
                        return DropdownMenuItem(
                            value: sugar, child: Text('$sugar sugars'));
                      }).toList()),
                  SizedBox(
                    height: 20.0,
                  ),
                  Slider(
                      activeColor:
                          Colors.brown[_currentStrength ?? crewData.strength],
                      inactiveColor:
                          Colors.brown[_currentStrength ?? crewData.strength],
                      value: (_currentStrength ?? 100).toDouble(),
                      min: 100.0,
                      max: 900.0,
                      divisions: 8,
                      onChanged: (value) {
                        setState(() {
                          _currentStrength = value.round();
                        });
                      }),
                  SizedBox(
                    height: 20.0,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await DatabaseService(
                                uid: Provider.of<Crew?>(context, listen: false)!
                                    .uid)
                            .updateCrewData(
                                _currentSugars ?? crewData.sugars,
                                _currentName ?? crewData.name,
                                _currentStrength ?? crewData.strength);
                      }
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                        elevation: 0.0, primary: Colors.brown[400]),
                  )
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
