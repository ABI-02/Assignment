class Vehicle {
  final String? id;
  final String? number;
  final String? brandName;
  final String? vehicleType;
  final String? fuelType;

  Vehicle({
    this.id = '',
    this.number = '',
    this.brandName = '',
    this.vehicleType = '',
    this.fuelType = '',
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'],
      number: json['number'],
      brandName: json['brandName'],
      vehicleType: json['vehicleType'],
      fuelType: json['fuelType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'number': number,
      'brandName': brandName,
      'vehicleType': vehicleType,
      'fuelType': fuelType,
    };
  }

  Vehicle copyWith({
    String? id,
    String? brandName,
    String? vehicleType,
    String? fuelType,
    String? number,
  }) {
    return Vehicle(
      id: id ?? this.id,
      brandName: brandName ?? this.brandName,
      vehicleType: vehicleType ?? this.vehicleType,
      fuelType: fuelType ?? this.fuelType,
      number: number ?? this.number,
    );
  }
}
