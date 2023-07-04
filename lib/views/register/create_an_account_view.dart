import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:student_personal_assistant/components/custom_button.dart';
import 'package:student_personal_assistant/components/custom_divider.dart';
import 'package:student_personal_assistant/components/custom_heading.dart';
import 'package:student_personal_assistant/components/custom_text.dart';
import 'package:student_personal_assistant/components/custom_text_field.dart';
import 'package:student_personal_assistant/constants/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../firebase_options.dart';

class CreateAnAccountView extends StatefulWidget {
  const CreateAnAccountView({super.key});

  @override
  State<CreateAnAccountView> createState() => _CreateAnAccountViewState();
}

class _CreateAnAccountViewState extends State<CreateAnAccountView> {
  late final TextEditingController _firstName;
  late final TextEditingController _lastName;
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _firstName = TextEditingController();
    _lastName = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 21),
        child: FutureBuilder(
          future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          ),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // const SizedBox(height: 118),
                    const CustomHeading(text: "Create an account"),
                    const SizedBox(height: 18),
                    const CustomText(
                        text:
                            "Please complete your profile. \nDon’t worry, your data will remain private\nand only you can see it"),
                    const SizedBox(height: 20),
                    const CustomDivider(),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTextField(
                          controller: _firstName,
                          width: 170,
                          labelText: "First Name",
                        ),
                        CustomTextField(
                          controller: _lastName,
                          width: 170,
                          labelText: "Last Name",
                        )
                      ],
                    ),
                    const SizedBox(height: 22),
                    CustomTextField(
                        controller: _email, labelText: "Email address"),
                    const SizedBox(height: 22),
                    CustomTextField(
                      controller: _password,
                      labelText: "New password",
                      obscureText: true,
                    ),
                    const SizedBox(height: 22),
                    CustomButton(
                      buttonText: "Register",
                      onPressed: () async {
                        final fName = _firstName.text;
                        final lName = _lastName.text;
                        final email = _email.text;
                        final password = _password.text;

                        try {
                          final userCredential = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: email, password: password);

                          print(userCredential);
                          Navigator.of(context).pushNamed(verifyEmailRoute);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            print('Weak password');
                          } else if (e.code == 'email-already-in-use') {
                            print('Email is already in use');
                          } else if (e.code == 'invalid-email') {
                            print('Invalid email entered');
                          }
                        }
                      },
                    ),
                    const SizedBox(height: 169),
                    CustomButton(
                      buttonText: "Already have an account? Log in",
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamedAndRemoveUntil(loginRoute, (_) => false);
                      },
                      isSecondary: true,
                    ),
                  ],
                );

              default:
                return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
