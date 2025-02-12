class Contact {
  final String id;
  final String displayName;
  final String? phoneNumber;
  final String? email;
  final bool isFavorite;

  Contact({
    required this.id,
    required this.displayName,
    this.phoneNumber,
    this.email,
    this.isFavorite = false,
  });
}
