class Booking {
  final String id;
  final Map<String, dynamic> machinery;
  final Map<String, dynamic> user;
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  final bool withOperator;
  final Map<String, dynamic>? location;
  final String? notes;
  final double totalAmount;

  Booking({
    required this.id,
    required this.machinery,
    required this.user,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.withOperator,
    this.location,
    this.notes,
    required this.totalAmount,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['_id'] ?? '',
      machinery: json['machinery'] ?? {},
      user: json['user'] ?? {},
      startDate: json['startDate'] != null
          ? DateTime.parse(json['startDate'])
          : DateTime.now(),
      endDate: json['endDate'] != null
          ? DateTime.parse(json['endDate'])
          : DateTime.now(),
      status: json['status'] ?? 'pending',
      withOperator: json['withOperator'] ?? false,
      location: json['location'],
      notes: json['notes'],
      totalAmount: (json['totalAmount'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'machinery': machinery,
      'user': user,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'status': status,
      'withOperator': withOperator,
      'location': location,
      'notes': notes,
      'totalAmount': totalAmount,
    };
  }
}
