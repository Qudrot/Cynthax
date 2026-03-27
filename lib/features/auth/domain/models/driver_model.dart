enum DriverStatus { offline, online, on_ride }
enum ApprovalStatus { pending, approved, suspended }

class DriverModel {
  final String id;
  final String userId;
  final DriverStatus status;
  final ApprovalStatus approvalStatus;
  final double totalEarnings;
  final double rating;
  final int totalTrips;

  DriverModel({
    required this.id,
    required this.userId,
    this.status = DriverStatus.offline,
    this.approvalStatus = ApprovalStatus.pending,
    this.totalEarnings = 0.0,
    this.rating = 5.0,
    this.totalTrips = 0,
  });

  factory DriverModel.fromJson(Map<String, dynamic> json) {
    return DriverModel(
      id: json['id'],
      userId: json['user_id'],
      status: DriverStatus.values.firstWhere(
        (e) => e.name.toUpperCase() == json['status'],
        orElse: () => DriverStatus.offline,
      ),
      approvalStatus: ApprovalStatus.values.firstWhere(
        (e) => e.name.toUpperCase() == json['approval_status'],
        orElse: () => ApprovalStatus.pending,
      ),
      totalEarnings: (json['total_earnings'] as num?)?.toDouble() ?? 0.0,
      rating: (json['rating'] as num?)?.toDouble() ?? 5.0,
      totalTrips: json['total_trips'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'status': status.name.toUpperCase(),
      'approval_status': approvalStatus.name.toUpperCase(),
      'total_earnings': totalEarnings,
      'rating': rating,
      'total_trips': totalTrips,
    };
  }
}
