

class Student {

  final String id;
  final String fullName;
  final String address;

  Student({required this.id,required this.fullName,required this.address});


  Map<String,dynamic> toJson() => {
    'id'       : id,
    'fullName' : fullName,
    'address'  : address
  };

  factory Student.fromJson(Map<dynamic, dynamic> json) {
    return Student(
      id: json['id'],
      fullName: json['fullName'],
      address: json['address'],
    );
  }



}