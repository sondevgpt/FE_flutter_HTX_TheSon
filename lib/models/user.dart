class User {
  final String id;
  final String email;
  final String phone;
  final String name;
  final String role;
  final bool isActive;
  final String? otp;
  final String accountType;
  final String address;
  final List<String> activityFields;
  final List<String> operationAreas;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? userImageAvatar;

  User({
    required this.id,
    required this.email,
    required this.phone,
    required this.name,
    required this.role,
    required this.isActive,
    this.otp,
    required this.accountType,
    required this.address,
    required this.activityFields,
    required this.operationAreas,
    required this.createdAt,
    required this.updatedAt,
    this.userImageAvatar,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      name: json['name'] as String,
      role: json['role'] as String,
      isActive: json['isActive'] as bool,
      otp: json['otp'] as String?,
      accountType: json['accountType'] as String,
      address: json['address'] as String,
      activityFields: List<String>.from(json['activityFields'] ?? []),
      operationAreas: List<String>.from(json['operationAreas'] ?? []),
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
      userImageAvatar: json['userImageAvatar'] as String?,
    );
  }
}
