


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

class Hospital {

  final String image;
  final String address;
  final int star;
  final String operatingTime;
  final List service;
  final String information;
  final List knowledges;
  final String hospitalName;

  Hospital({
    required this.image,
    required this.address,
    required this.star,
    required this.hospitalName,
    required this.information,
    required this.knowledges,
    required this.operatingTime,
    required this.service
  });

  factory Hospital.fromJson(Map<String,dynamic> json) {

    return Hospital(
        image: json['image'],
        address: json['address'],
        star: json['star'],
        hospitalName: json['hospital_name'],
        information: json['information'],
        knowledges: json['knowledges'],
        operatingTime: json['operating_time'],
        service: json['service']
    );

  }

  Map<String,dynamic> toJson() => {
    'image'  : image,
    'address'  : address,
    'star'      : star,
    'hospital_name' : hospitalName,
    'information' : information,
    'knowledges' : knowledges,
    'operating_time' : operatingTime,
    'service' : service
  };

}