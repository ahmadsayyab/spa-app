import 'package:student_personal_assistant/Services/Auth/auth_user.dart';

abstract class AuthProvider {
  Future addUserCredentials(
      String fName, String lName, String email, String password);
  Future<void> initialize();
  AuthUser? get currentUser;
  Future<AuthUser> logIn({
    required String email,
    required String password,
  });
  Future<AuthUser> createUser({
    //required String firstName,
    //required String lastName,
    required String email,
    required String password,
  });
  Future<void> logOut();
  Future<void> sendEmailVerification();
}
