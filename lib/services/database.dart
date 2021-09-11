import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/models/crew.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;

  // collection reference
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  DatabaseService({required this.uid});

  Future updateCrewData(String sugars, String name, int strength) async {
    return await brewCollection
        .doc(uid)
        .set({'sugars': sugars, 'name': name, 'strength': strength});
  }

  List<Brew?> _brewListFromSnapshots(QuerySnapshot? snpashots) {
    return snpashots!.docs.map((doc) {
      return Brew(
          name: doc.get('name') ?? '',
          sugars: doc.get('sugars') ?? '',
          strength: doc.get('strength') ?? 0);
    }).toList();
  }

  CrewData _crewDataFromSnapshot(DocumentSnapshot snapshot) {
    return CrewData(
        uid: uid,
        name: snapshot.get('name'),
        sugars: snapshot.get('sugars'),
        strength: snapshot.get('strength'));
  }

  // get brew streams
  Stream<List<Brew?>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshots);
  }

  Stream<CrewData> get userData {
    return brewCollection.doc(uid).snapshots().map(_crewDataFromSnapshot);
  }
}
