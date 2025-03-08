class User {
  final String sId;
  final String name;
  final String email;
  final String phone;
  final List<String> roles;
  final Map<String, dynamic>? address;
  final Map<String, dynamic>? documents;
  final Map<String, dynamic>? shopDetails;
  final Map<String, dynamic>? providerDetails;
  final Map<String, dynamic>? farmerDetails;
  final Map<String, dynamic>? operatorDetails;
  final Map<String, dynamic>? labourDetails;
  final bool isVerified;
  final String verificationStatus;

  User({
    required this.sId,
    required this.name,
    required this.email,
    required this.phone,
    required this.roles,
    this.address,
    this.documents,
    this.shopDetails,
    this.providerDetails,
    this.farmerDetails,
    this.operatorDetails,
    this.labourDetails,
    required this.isVerified,
    required this.verificationStatus,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      sId: json['_id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      roles: List<String>.from(json['roles']),
      address: json['address'],
      documents: json['documents'],
      shopDetails: json['shopDetails'],
      providerDetails: json['providerDetails'],
      farmerDetails: json['farmerDetails'],
      operatorDetails: json['operatorDetails'],
      labourDetails: json['labourDetails'],
      isVerified: json['isVerified'] ?? false,
      verificationStatus: json['verificationStatus'] ?? 'pending',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': sId,
      'name': name,
      'email': email,
      'phone': phone,
      'roles': roles,
      'address': address,
      'documents': documents,
      'shopDetails': shopDetails,
      'providerDetails': providerDetails,
      'farmerDetails': farmerDetails,
      'operatorDetails': operatorDetails,
      'labourDetails': labourDetails,
      'isVerified': isVerified,
      'verificationStatus': verificationStatus,
    };
  }

  bool hasRole(String role) => roles.contains(role);
}
