abstract class AuthMixin {
  String token;

  Map<String, dynamic> toJson();

  AuthMixin.fromJson(Map<String, dynamic> json);
}
