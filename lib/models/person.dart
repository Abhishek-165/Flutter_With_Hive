class Person {
  String? name;
  int? age;

  Person(this.name, this.age);
  Map<String, dynamic> toJson() => {"name": name ?? "", "age": age};
}

class Data {
  bool? isInitialise;
  List<dynamic>? value;

  Data({this.isInitialise, this.value});
}
