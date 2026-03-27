enum RideStatus {
  requested,
  negotiating,
  accepted,
  arrived,
  in_progress,
  completed,
  cancelled
}

enum RideType { solo, rideshare }

class TripModel {
  final String id;
  final String initiatorId;
  final String? driverId;
  final String? vehicleId;

  final String pickupAddress;
  final double pickupLat;
  final double pickupLng;
  final String dropoffAddress;
  final double dropoffLat;
  final double dropoffLng;

  final RideType rideType;
  final int maxJoiners;
  final bool womenOnly;

  final double baseFare;
  final RideStatus status;

  TripModel({
    required this.id,
    required this.initiatorId,
    this.driverId,
    this.vehicleId,
    required this.pickupAddress,
    required this.pickupLat,
    required this.pickupLng,
    required this.dropoffAddress,
    required this.dropoffLat,
    required this.dropoffLng,
    required this.baseFare,
    this.rideType = RideType.solo,
    this.maxJoiners = 0,
    this.womenOnly = false,
    this.status = RideStatus.requested,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) {
    return TripModel(
      id: json['id'],
      initiatorId: json['initiator_id'],
      driverId: json['driver_id'],
      vehicleId: json['vehicle_id'],
      pickupAddress: json['pickup_address'],
      pickupLat: (json['pickup_lat'] as num).toDouble(),
      pickupLng: (json['pickup_lng'] as num).toDouble(),
      dropoffAddress: json['dropoff_address'],
      dropoffLat: (json['dropoff_lat'] as num).toDouble(),
      dropoffLng: (json['dropoff_lng'] as num).toDouble(),
      baseFare: (json['base_fare'] as num).toDouble(),
      rideType: json['ride_type'] == 'RIDESHARE' ? RideType.rideshare : RideType.solo,
      maxJoiners: json['max_joiners'] ?? 0,
      womenOnly: json['women_only'] ?? false,
      status: RideStatus.values.firstWhere(
        (e) => e.name.toUpperCase() == json['status'],
        orElse: () => RideStatus.requested,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'initiator_id': initiatorId,
      'driver_id': driverId,
      'vehicle_id': vehicleId,
      'pickup_address': pickupAddress,
      'pickup_lat': pickupLat,
      'pickup_lng': pickupLng,
      'dropoff_address': dropoffAddress,
      'dropoff_lat': dropoffLat,
      'dropoff_lng': dropoffLng,
      'base_fare': baseFare,
      'ride_type': rideType.name.toUpperCase(),
      'max_joiners': maxJoiners,
      'women_only': womenOnly,
      'status': status.name.toUpperCase(),
    };
  }
}
