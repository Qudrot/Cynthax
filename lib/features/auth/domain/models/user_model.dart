enum UserRole { passenger, driver, admin }

class UserModel {
  final String id;
  final String phone;
  final String email;
  final String fullName;
  final String? avatarUrl;
  final UserRole role;

  // Professional Profile
  final String? jobTitle;
  final String? company;
  final String? industry;
  final String? linkedinUrl;
  final String? bio;

  // Verification & Safety
  final String? nin;
  final bool ninVerified;
  final bool isVerified;
  final bool womenOnlyPref;

  UserModel({
    required this.id,
    required this.phone,
    required this.email,
    required this.fullName,
    this.avatarUrl,
    required this.role,
    this.jobTitle,
    this.company,
    this.industry,
    this.linkedinUrl,
    this.bio,
    this.nin,
    this.ninVerified = false,
    this.isVerified = false,
    this.womenOnlyPref = false,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      phone: json['phone'] ?? '',
      email: json['email'],
      fullName: json['full_name'],
      avatarUrl: json['avatar_url'],
      role: UserRole.values.firstWhere(
        (e) => e.name.toUpperCase() == json['role'],
        orElse: () => UserRole.passenger,
      ),
      jobTitle: json['job_title'],
      company: json['company'],
      industry: json['industry'],
      linkedinUrl: json['linkedin_url'],
      bio: json['bio'],
      nin: json['nin'],
      ninVerified: json['nin_verified'] ?? false,
      isVerified: json['is_verified'] ?? false,
      womenOnlyPref: json['women_only_pref'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phone': phone,
      'email': email,
      'full_name': fullName,
      'avatar_url': avatarUrl,
      'role': role.name.toUpperCase(),
      'job_title': jobTitle,
      'company': company,
      'industry': industry,
      'linkedin_url': linkedinUrl,
      'bio': bio,
      'nin': nin,
      'nin_verified': ninVerified,
      'is_verified': isVerified,
      'women_only_pref': womenOnlyPref,
    };
  }
}
