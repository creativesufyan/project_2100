import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class TeacherModel {
  final String name;
  final String email;
  final String photoUrl;
  final String uid;

  TeacherModel({
    required this.name,
    required this.email,
    required this.photoUrl,
    required this.uid,
  });

  @override
  String toString() {
    return 'TeacherModel(name: $name, email: $email, photoUrl: $photoUrl, uid: $uid)';
  }

  TeacherModel copyWith({
    String? name,
    String? email,
    String? photoUrl,
    String? uid,
  }) {
    return TeacherModel(
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'uid': uid,
    };
  }

  factory TeacherModel.fromMap(Map<String, dynamic> map) {
    return TeacherModel(
      name: map['name'] as String,
      email: map['email'] as String,
      photoUrl: map['photoUrl'] as String,
      uid: map['uid'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TeacherModel.fromJson(String source) =>
      TeacherModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant TeacherModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.email == email &&
        other.photoUrl == photoUrl &&
        other.uid == uid;
  }

  @override
  int get hashCode {
    return name.hashCode ^ email.hashCode ^ photoUrl.hashCode ^ uid.hashCode;
  }
}
