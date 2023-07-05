import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:student_personal_assistant/components/custom_button.dart';
import 'package:student_personal_assistant/components/custom_divider.dart';
import 'package:student_personal_assistant/components/custom_heading.dart';
import 'package:student_personal_assistant/components/custom_text.dart';
import 'package:student_personal_assistant/components/custom_text_button.dart';
import 'package:student_personal_assistant/components/custom_text_field.dart';
import 'package:student_personal_assistant/constants/routes.dart';

import '../../firebase_options.dart';
import '../../utilities/show_error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 21),
          child: FutureBuilder(
            future: Firebase.initializeApp(
              options: DefaultFirebaseOptions.currentPlatform,
            ),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // const SizedBox(height: 118),
                      const CustomHeading(text: "Log in"),
                      const SizedBox(height: 18),
                      const CustomText(
                        text:
                            "Nice to see you again!\nPlease log in to access\nyour personalized account.",
                        alignLeft: true,
                      ),
                      const SizedBox(
                        height: 23,
                      ),
                      const CustomDivider(alignLeft: true),
                      // const CustomDivider(alignLeft: true),
                      const SizedBox(
                        height: 41,
                      ),
                      CustomTextField(
                          controller: _email, labelText: "Email address"),
                      const SizedBox(
                        height: 22,
                      ),
                      CustomTextField(
                        controller: _password,
                        labelText: "Password",
                        obscureText: true,
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      Center(
                        child: Column(
                          children: [
                            CustomButton(
                                buttonText: "Log in",
                                onPressed: () async {
                                  final email = _email.text;
                                  final password = _password.text;
                                  try {
                                    await FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                            email: email, password: password);

                                    final user =
                                        FirebaseAuth.instance.currentUser;
                                    if (user?.emailVerified ?? false) {
                                      //usr's email is verified
                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil(
                                              setupRoute, (_) => false);
                                    } else {
                                      //user's email is NOT verified
                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil(
                                              verifyEmailRoute,
                                              (route) => false);
                                    }
                                  } on FirebaseAuthException catch (e) {
                                    if (e.code == 'user-not-found') {
                                      await showErrorDialog(
                                        context,
                                        'user-not-found',
                                      );
                                    } else if (e.code == 'wrong-password') {
                                      await showErrorDialog(
                                        context,
                                        'Wrong credentials',
                                      );
                                    } else {
                                      await showErrorDialog(
                                        context,
                                        'Error: ${e.code}',
                                      );
                                    }
                                  } catch (e) {
                                    await showErrorDialog(
                                      context,
                                      e.toString(),
                                    );
                                  }
                                }),
                            CustomTextButton(
                                text: "Forgot Password?",
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(forgotPassowrdRoute);
                                }),
                            const SizedBox(
                              height: 175,
                            ),
                            CustomButton(
                              buttonText: "Create a new account",
                              onPressed: () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    registerRoute, (_) => false);
                              },
                              isSecondary: true,
                            )
                          ],
                        ),
                      ),
                    ],
                  );

                default:
                  return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}
