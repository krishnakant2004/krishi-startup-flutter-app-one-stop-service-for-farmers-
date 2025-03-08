class Machinery {
  final String id;
  final String name;
  final String type;
  final String description;
  final double hourlyRate;
  final double dailyRate;
  final List<String> images;
  final Map<String, String> specifications;
  final Map<String, dynamic> owner;
  final Map<String, dynamic> location;
  final bool operatorAvailable;
  final double operatorCharges;
  final bool availability;

  Machinery({
    required this.id,
    required this.name,
    required this.type,
    required this.description,
    required this.hourlyRate,
    required this.dailyRate,
    required this.images,
    required this.specifications,
    required this.owner,
    required this.location,
    required this.operatorAvailable,
    required this.operatorCharges,
    required this.availability,
  });

  factory Machinery.fromJson(Map<String, dynamic> json) {
    return Machinery(
      id: json['_id'],
      name: json['name'],
      type: json['type'],
      description: json['description'],
      hourlyRate: json['hourlyRate'].toDouble(),
      dailyRate: json['dailyRate'].toDouble(),
      images: List<String>.from(json['images'] ?? []),
      specifications: Map<String, String>.from(json['specifications'] ?? {}),
      owner: json['owner'] ?? {},
      location: json['location'] ?? {},
      operatorAvailable: json['operatorAvailable'] ?? false,
      operatorCharges: (json['operatorCharges'] ?? 0).toDouble(),
      availability: json['availability'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'type': type,
      'description': description,
      'hourlyRate': hourlyRate,
      'dailyRate': dailyRate,
      'images': images,
      'specifications': specifications,
      'owner': owner,
      'location': location,
      'operatorAvailable': operatorAvailable,
      'operatorCharges': operatorCharges,
      'availability': availability,
    };
  }
}
