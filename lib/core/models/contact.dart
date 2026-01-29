/// Contact model for Protectra - Safety Device Companion
/// Represents a trusted contact (parent, guardian, or close friend)
class Contact {
  final String id;
  final String name;
  final String? phoneNumber;
  final String? email;
  final ContactType type;
  final bool isEmergencyContact;
  final DateTime createdAt;

  Contact({
    required this.id,
    required this.name,
    this.phoneNumber,
    this.email,
    required this.type,
    this.isEmergencyContact = false,
    required this.createdAt,
  });

  /// Get contact type label
  String get typeLabel {
    switch (type) {
      case ContactType.parent:
        return 'Parent';
      case ContactType.guardian:
        return 'Guardian';
      case ContactType.friend:
        return 'Friend';
      case ContactType.relative:
        return 'Relative';
    }
  }

  /// Get formatted phone number
  String? get formattedPhoneNumber {
    if (phoneNumber == null || phoneNumber!.isEmpty) return null;
    // Simple formatting for demo - can be enhanced
    final clean = phoneNumber!.replaceAll(RegExp(r'[^0-9+]'), '');
    if (clean.startsWith('+')) {
      if (clean.length == 13) {
        return '${clean.substring(0, 3)} ${clean.substring(3, 6)} ${clean.substring(6, 9)} ${clean.substring(9)}';
      }
    }
    return clean;
  }

  /// Get initials for avatar
  String get initials {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.substring(0, 1).toUpperCase();
  }

  /// Copy with method
  Contact copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    String? email,
    ContactType? type,
    bool? isEmergencyContact,
    DateTime? createdAt,
  }) {
    return Contact(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      type: type ?? this.type,
      isEmergencyContact: isEmergencyContact ?? this.isEmergencyContact,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'type': type.name,
      'isEmergencyContact': isEmergencyContact,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  /// Create from JSON
  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'] as String,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      email: json['email'] as String?,
      type: ContactType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => ContactType.friend,
      ),
      isEmergencyContact: json['isEmergencyContact'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  /// Create a mock contact for demo purposes
  factory Contact.mock({
    String? id,
    String? name,
    String? phoneNumber,
    ContactType? type,
    bool? isEmergencyContact,
  }) {
    return Contact(
      id: id ?? 'contact_${DateTime.now().millisecondsSinceEpoch}',
      name: name ?? 'John Doe',
      phoneNumber: phoneNumber ?? '+639123456789',
      email: 'john.doe@example.com',
      type: type ?? ContactType.parent,
      isEmergencyContact: isEmergencyContact ?? true,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
    );
  }
}

/// Contact type enum
enum ContactType { parent, guardian, friend, relative }
