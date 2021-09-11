import 'package:brew_crew/models/crew.dart';
import 'package:brew_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Crew? _crewFromUser(User? user) => user != null ? Crew(uid: user.uid) : null;

  Stream<Crew?> get crew {
    return _auth.authStateChanges().map(_crewFromUser);
  }

  Future signInAnon() async {
    try {
      UserCredential receiver = await _auth.signInAnonymously();
      User user = receiver.user!;
      return _crewFromUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential receiver = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = receiver.user!;
      return _crewFromUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential receiver = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      User user = receiver.user!;

      await DatabaseService(uid: user.uid)
          .updateCrewData('0', 'new Crew Member', 100);
      return _crewFromUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e);
      return null;
    }
  }
}
