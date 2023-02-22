class UserModel {
 String name; 
 String gender; 
 String dob;
 String createdAt; 
String phoneNumber;
 String uid;
UserModel({
required this.name,
required this.gender,
required this.createdAt,
required this.phoneNumber,
required this.uid,
required this.dob,
}
);
factory UserModel.fromMap (Map<String, dynamic> map) {
return UserModel(
name: map['name'] ?? '', 
gender: map['gender'] ?? '', 
uid: map['uid'] ?? '',
phoneNumber: map['phoneNumber'] ?? '', 
createdAt: map['createdAt'] ?? '', 
dob: map['dob'] ?? '',
);
  }
  Map<String, dynamic> toMap() {
return {
"name": name,
"gender": gender,
"uid": uid,
"dob": dob,
"phoneNumber": phoneNumber, 
"createdAt": createdAt,
};
}
}
