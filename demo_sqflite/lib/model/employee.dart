class Employee {
  int? id;
  String? name;

  Employee({required this.id, required this.name});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'name': name,
    };
    return map;
  }

  Employee.fromMap(Map<dynamic, dynamic> map) {
    id = map['id'];
    name = map['name'];
  }
}
