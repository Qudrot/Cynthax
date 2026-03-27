class VehicleModel {
  final String id;
  final String driverId;
  final String make;
  final String model;
  final int year;
  final String licensePlate;
  final String? color;
  final int seatCapacity;
  final int comfortRating;

  VehicleModel({
    required this.id,
    required this.driverId,
    required this.make,
    required this.model,
    required this.year,
    required this.licensePlate,
    this.color,
    this.seatCapacity = 4,
    this.comfortRating = 3,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      id: json['id'],
      driverId: json['driver_id'],
      make: json['make'],
      model: json['model'],
      year: json['year'],
      licensePlate: json['license_plate'],
      color: json['color'],
      seatCapacity: json['seat_capacity'] ?? 4,
      comfortRating: json['comfort_rating'] ?? 3,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'driver_id': driverId,
      'make': make,
      'model': model,
      'year': year,
      'license_plate': licensePlate,
      'color': color,
      'seat_capacity': seatCapacity,
      'comfort_rating': comfortRating,
    };
  }
}
