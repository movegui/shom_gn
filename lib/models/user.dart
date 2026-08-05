class User {
  final String id;
  final String email;
  final String? password; // Only for internal use, never send over API
  final String firstName;
  final String lastName;
  final String? phoneNumber;
  final String? profileImage;
  final DateTime createdAt;
  final DateTime lastLogin;
  final bool emailVerified;
  final bool phoneVerified;
  final String? preferredLanguage;
  final String? currency;
  final List<String> savedPaymentMethods;
  final List<String> savedAddresses;
  final bool newsSubscribed;

  User({
    required this.id,
    required this.email,
    this.password,
    required this.firstName,
    required this.lastName,
    this.phoneNumber,
    this.profileImage,
    required this.createdAt,
    required this.lastLogin,
    this.emailVerified = false,
    this.phoneVerified = false,
    this.preferredLanguage = 'en',
    this.currency = 'USD',
    this.savedPaymentMethods = const [],
    this.savedAddresses = const [],
    this.newsSubscribed = false,
  });

  String get fullName => '$firstName $lastName';

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      phoneNumber: json['phoneNumber'],
      profileImage: json['profileImage'],
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      lastLogin: DateTime.parse(json['lastLogin'] ?? DateTime.now().toIso8601String()),
      emailVerified: json['emailVerified'] ?? false,
      phoneVerified: json['phoneVerified'] ?? false,
      preferredLanguage: json['preferredLanguage'] ?? 'en',
      currency: json['currency'] ?? 'USD',
      savedPaymentMethods: List<String>.from(json['savedPaymentMethods'] ?? []),
      savedAddresses: List<String>.from(json['savedAddresses'] ?? []),
      newsSubscribed: json['newsSubscribed'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'profileImage': profileImage,
      'createdAt': createdAt.toIso8601String(),
      'lastLogin': lastLogin.toIso8601String(),
      'emailVerified': emailVerified,
      'phoneVerified': phoneVerified,
      'preferredLanguage': preferredLanguage,
      'currency': currency,
      'savedPaymentMethods': savedPaymentMethods,
      'savedAddresses': savedAddresses,
      'newsSubscribed': newsSubscribed,
    };
  }

  @override
  String toString() => fullName;
}

class UserPreferences {
  final String userId;
  final bool emailNotifications;
  final bool smsNotifications;
  final bool pushNotifications;
  final bool twoFactorEnabled;
  final List<String> blockedUsers;
  final Map<String, dynamic> customSettings;

  UserPreferences({
    required this.userId,
    this.emailNotifications = true,
    this.smsNotifications = false,
    this.pushNotifications = true,
    this.twoFactorEnabled = false,
    this.blockedUsers = const [],
    this.customSettings = const {},
  });

  factory UserPreferences.fromJson(Map<String, dynamic> json) {
    return UserPreferences(
      userId: json['userId'] ?? '',
      emailNotifications: json['emailNotifications'] ?? true,
      smsNotifications: json['smsNotifications'] ?? false,
      pushNotifications: json['pushNotifications'] ?? true,
      twoFactorEnabled: json['twoFactorEnabled'] ?? false,
      blockedUsers: List<String>.from(json['blockedUsers'] ?? []),
      customSettings: Map<String, dynamic>.from(json['customSettings'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'emailNotifications': emailNotifications,
      'smsNotifications': smsNotifications,
      'pushNotifications': pushNotifications,
      'twoFactorEnabled': twoFactorEnabled,
      'blockedUsers': blockedUsers,
      'customSettings': customSettings,
    };
  }
}
