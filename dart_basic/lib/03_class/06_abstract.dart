void main() {
  // Unit u = Unit("unit");
  Marine m1 = Marine();
}

abstract class Unit {
  final String name;
  final String tribe;
  void move(){print("이동하였습니다.");}
  void stop(){print("멈췄습니다.");}
  void attack();
  Unit(this.name, this.tribe);
  @override
  String toString() {return this.tribe+"종족 "+this.name;}
}

class Marine extends Unit {
  Marine() :super("마린", "Terran"){
    print(name + toString()+" 나타났습니다.");
  }
  @override
  void attack() {
    print("bang");
  }
}
