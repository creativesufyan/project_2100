// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String name;
  final String email;
  final String photoUrl;
  UserModel({
    required this.name,
    required this.email,
    required this.photoUrl,
  });

  @override
  String toString() =>
      'UserModel(name: $name, email: $email, photoUrl: $photoUrl)';
}
