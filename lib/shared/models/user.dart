import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class User {

  @JsonProperty(name: 'login')
  final String? login;

  @JsonProperty(name: 'firstName')
  final String? firstName;

  @JsonProperty(name: 'lastName')
  final String? lastName;

  @JsonProperty(name: 'preferred_username')
  final String? preferred_username;

  @JsonProperty(name: 'email')
  final String? email;

  @JsonProperty(name: 'password')
  final String? password;

  @JsonProperty(name: 'langKey')
  final String? langKey;

  const User(this.login, this.firstName, this.lastName, this.preferred_username, this.email, this.password, this.langKey);

  @override
  String toString() {
    return 'User{login: $preferred_username, email: $email, langKey: $langKey}';
  }

  User.fromJson(Map<String, dynamic> json)
      :  firstName = json['firstName'],
      login = json['login'],
        lastName = json['lastName'],
        preferred_username = json['preferred_username'],
        email = json['email'],
        password = json['password'],
        langKey = json['langKey'];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is User &&
              runtimeType == other.runtimeType &&
              preferred_username == other.preferred_username &&
              email == other.email &&
              password == other.password &&
              langKey == other.langKey;

  @override
  int get hashCode =>
      preferred_username.hashCode ^ email.hashCode ^ password.hashCode ^ langKey.hashCode;
}
