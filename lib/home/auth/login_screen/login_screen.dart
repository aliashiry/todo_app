import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/home/auth/custom_text_form_field.dart';
import 'package:todo_app/home/auth/register_screen/register_screen.dart';
import 'package:todo_app/home/home_screen.dart';
import 'package:todo_app/theme/my_theme.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "login screen";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
              'Login',
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
                              height:
                                  MediaQuery.of(context).size.height * 0.22),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Welcome back!',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color: Colors.black,
                                    )),
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
                              if (text == null || text.isEmpty) {
                                return 'please enter a password';
                              }
                              if (text.length < 6) {
                                return 'password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8, left: 8),
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(RegisterScreen.routeName);
                              },
                              child: Container(
                                alignment: Alignment.bottomLeft,
                                child: Text('Forgot password?',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 18,
                                        )),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                ),
                                onPressed: () {
                                  login();

                                 // Navigator.pushNamed(context, HomeScreen.routeName);
                                },
                                child: Text(
                                  'Login',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                )),
                          )
                        ],
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(right: 8, left: 8),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(RegisterScreen.routeName);
                    },
                    child: Text('Or Create My Account',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Colors.grey,
                                  fontSize: 18,
                                )),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  void login() async {
    if (formKey.currentState?.validate() == true) {
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        print('Login successful');
        print(credential.user?.uid ?? '');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }

      } catch (e) {
        print(e.toString());
      }
    }
  }
}
