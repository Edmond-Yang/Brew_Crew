class Crew {
  final String uid;
  Crew({required this.uid});
}

class CrewData {
  final String uid;
  final String name;
  final String sugars;
  final int strength;

  CrewData(
      {required this.name,
      required this.sugars,
      required this.strength,
      required this.uid});
}
