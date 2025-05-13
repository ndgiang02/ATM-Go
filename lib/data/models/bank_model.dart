class Bank {
  Bank({
    required this.id,
    required this.name,
    required this.logoUrl,
    this.distance,
  });
  final String id;
  final String name;
  final String logoUrl;
  final double? distance;
}
