import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/constants.dart';

class SignIn extends StatefulWidget {
  final VoidCallback changeView;
  const SignIn({Key? key, required this.changeView}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthServices _auth = AuthServices();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[50],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              title: Text('Log In to Brew Crew'),
              elevation: 0.0,
              actions: [
                TextButton.icon(
                  onPressed: widget.changeView,
                  icon: Icon(Icons.person),
                  label: Text('Register'),
                  style: TextButton.styleFrom(primary: Colors.white),
                )
              ],
            ),
            body: Container(
                padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Email'),
                        validator: (value) {
                          return value!.isEmpty ? 'Enter an Email' : null;
                        },
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Password'),
                        validator: (value) {
                          return value!.isEmpty ? 'Enter an Password' : null;
                        },
                        obscureText: true,
                        onChanged: (value) {
                          password = value;
                        },
                      ),
                      SizedBox(height: 20.0),
                      Center(
                          child: Text(error,
                              style: TextStyle(
                                  color: Colors.red, fontSize: 14.0))),
                      SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              loading = true;
                            });
                            dynamic receiver = await _auth
                                .signInWithEmailAndPassword(email, password);
                            if (receiver == null) {
                              setState(() {
                                loading = false;
                                error =
                                    'Could Not Log In With Those Credentals';
                              });
                            }
                          }
                        },
                        child: Text(
                          'Log In',
                          style: TextStyle(color: Colors.brown),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white, elevation: 0.0),
                      ),
                      SizedBox(height: 10.0),
                      TextButton(
                        onPressed: () async {
                          dynamic receiver = await _auth.signInAnon();
                          if (receiver == null) {
                            print('error occur');
                          } else {
                            loading = true;
                          }
                        },
                        child: Text(
                          'Sign In Anonymously',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: TextButton.styleFrom(
                            primary: Colors.brown[200],
                            backgroundColor: Colors.brown[300]),
                      ),
                    ],
                  ),
                )));
  }
}
