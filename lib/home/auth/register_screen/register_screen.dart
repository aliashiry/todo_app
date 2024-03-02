import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/home/auth/custom_text_form_field.dart';
import 'package:todo_app/theme/my_theme.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "register screen";

  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            color: MyTheme.whiteColor,
            child: Image.asset(
              'assets/images/main_background.png',
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
            )),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(
              'Create Account',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.22),
                        CustomTextFormField(
                          label: 'User Name',
                          controller: nameController,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'please enter a user name';
                            }
                            return null;
                          },
                        ),
                        CustomTextFormField(
                          label: 'Email',
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'please enter a email';
                            }
                            bool emailValid = RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(text);
                            if (!emailValid) {
                              return 'please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        CustomTextFormField(
                          label: 'Password',
                          keyboardType: TextInputType.number,
                          controller: passwordController,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'please enter a password';
                            }
                            if (text.length < 6) {
                              return 'password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        CustomTextFormField(
                          label: 'Confirm Password',
                          keyboardType: TextInputType.number,
                          controller: confirmController,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'please enter password-confirmation';
                            }
                            // if ( passwordController.text != confirmController.text) {
                            //   return "password doesn't match";
                            //   //  print('exit the condation password');
                            // }
                            return null;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                            ),
                            onPressed: () {
                              register();

                            },
                            child: Text(
                              'Create Account',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontSize: 20,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

// Users  users = Users(id: credential.user!.uid, name: nameController.text, email: emailController.text);
  // FirebaseUtils.addUserToFireStorage(users);
  void register() async {
    if (formKey.currentState!.validate() == true) {
      print('start');
      try {
        print('start 2');
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        print('register successfully');
        print(credential.user?.uid ?? '');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }
}
