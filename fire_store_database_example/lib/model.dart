


class Student {
  
  final String fullName;
  final Delivery delivery;
  
  Student({required this.fullName,required this.delivery});

  Map<String,dynamic> toJson() => {
    'fullName' : fullName,
    'delivery'  : delivery.toJson()
  };

  factory Student.fromJson(Map<String,dynamic> json) {
    return Student(
        fullName: json['fullName'],
        delivery: Delivery.fromJson(json['delivery'])
    );
  }
  
}

class Delivery {
  
  final String province;
  final String district;
  final String ward;
  
  Delivery({required this.province,required this.district,required this.ward});

  Map<String,dynamic> toJson() => {
    'province'  : province,
    'district'  : district,
    'ward'      : ward
  };

  factory Delivery.fromJson(Map<String,dynamic> json) {
    return Delivery(
        province: json['province'],
        district: json['district'],
        ward: json['ward']
    );
  }
  
}