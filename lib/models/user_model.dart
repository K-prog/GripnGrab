class UserModel {
  String id;
  String phoneNumber;
  String firstName;
  String lastName;
  String gender;
  String dateOfBirth;
  String profilePhoto;
  bool membershipActivated;
  DateTime createdAt;

  UserModel({
    required this.id,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.createdAt,
    required this.profilePhoto,
    required this.dateOfBirth,
    required this.membershipActivated,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      profilePhoto: json['profilePhoto'] as String,
      id: json['id'] as String,
      phoneNumber: json['phoneNumber'] as String,
      firstName: json['firstName'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt']),
      lastName: json['lastName'] as String,
      gender: json['gender'] as String,
      dateOfBirth: json['dateOfBirth'] as String,
      membershipActivated: json['membershipActivated'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phoneNumber': phoneNumber,
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'profilePhoto': profilePhoto,
      'dateOfBirth': dateOfBirth,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'membershipActivated': membershipActivated,
    };
  }
}
