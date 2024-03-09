import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/firebase/firebase_utils.dart';
import 'package:todo_app/core/providers/auth_provider.dart';
import 'package:todo_app/core/theme/my_theme.dart';
import 'package:todo_app/core/utils/dialog_utils.dart';
import 'package:todo_app/model/user.dart';
import 'package:todo_app/pages/auth/custom_text_form_field.dart';
import 'package:todo_app/pages/auth/login_screen/login_screen.dart';
import 'package:todo_app/pages/home/home_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register_screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController(text: 'Ali');

  TextEditingController emailController =
      TextEditingController(text: 'ali@gmail.com');

  TextEditingController passwordController =
      TextEditingController(text: '123456');

  TextEditingController confirmPasswordController =
      TextEditingController(text: '123456');

  var formkey = GlobalKey<FormState>();
  bool obscureText = true;
  bool obscureText1 = true;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        color: MyTheme.whiteColor,
        child: Image.asset(
          'assets/images/main_background.png',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.fill,
        ),
      ),
      Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leading: BackButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
              },
            ),
            backgroundColor: Colors.transparent,
            title: Text('Create Account'),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.23,
              ),
              Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomTextFormField(
                      lableText: 'User Name',
                      controller: nameController,
                      validator: (name) {
                        if (name == null || name.trim().isEmpty) {
                          return 'Please Enter User Name';
                        }
                        return null;
                      },
                    ),
                    CustomTextFormField(
                      lableText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      validator: (email) {
                        if (email!.trim().isEmpty) {
                          return 'Please Enter Email';
                        }
                        bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(email);
                        if (!emailValid) {
                          return 'Please enter valid email';
                        }
                        return null;
                      },
                    ),
                    CustomTextFormField(
                      suffixIcon: InkWell(
                          onTap: () {
                            obscureText == true
                                ? obscureText = false
                                : obscureText = true;
                            setState(() {});
                          },
                          child: Icon(Icons.remove_red_eye_outlined)),
                      // IconButton(
                      //     onPressed: () {
                      //       obscureText == true
                      //           ? obscureText = false
                      //           : obscureText = true;
                      //       setState(() {});
                      //     },
                      //     icon: Icon(Icons.remove_red_eye_outlined,)),
                      obscureText: obscureText,
                      lableText: 'Password',
                      keyboardType: TextInputType.phone,
                      controller: passwordController,
                      validator: (password) {
                        if (password == null || password.trim().isEmpty) {
                          return 'Please Enter Password';
                        }
                        if (password.length < 6) {
                          return 'Password Should be at least  6 chars. ';
                        }
                        return null;
                      },
                    ),
                    CustomTextFormField(
                      obscureText: obscureText1,
                      lableText: 'Confirm Password',
                      keyboardType: TextInputType.phone,
                      controller: confirmPasswordController,
                      validator: (confirm) {
                        if (confirm == null || confirm.trim().isEmpty) {
                          return 'Please Enter ConfirmPassword';
                        }
                        if (confirm != passwordController.text) {
                          return 'Invalid ConfirmPassword';
                        }
                        return null;
                      },
                      suffixIcon: InkWell(
                          onTap: () {
                            obscureText1 == true
                                ? obscureText1 = false
                                : obscureText1 = true;
                            setState(() {});
                          },
                          child: Icon(Icons.remove_red_eye_outlined)),
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
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontSize: 20,
                                  ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ))
    ]);
  }

  void register() async {
    if (formkey.currentState!.validate() == true) {
      /// register
      /// todo: show loading
      // await Future.delayed(Duration(seconds: 2));
      try {
        DialogUtils.showLoading(context: context, message: 'Loading...');
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        MyUser myUser = MyUser(
            id: credential.user?.uid ?? '',
            name: nameController.text,
            email: emailController.text);
        await FirebaseUtils.addUserToFireStore(myUser);
        var authProvider = Provider.of<AuthProviders>(context, listen: false);
        authProvider.updateUser(myUser);
        // todo : hide loading
        DialogUtils.hideDialog(context);
        // todo : show message
        DialogUtils.showMessage(
            context: context,
            message: 'Account Created Successfully',
            title: "success",
            posActionName: 'OK',
            posAction: () {
              Navigator.pushReplacementNamed(context, HomeScreen.routeName);
            });
        // todo : navigate to login screen
        //  Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          // todo : hide loading
          DialogUtils.hideDialog(context);
          // todo : show message
          DialogUtils.showMessage(
            context: context,
            message: 'The password provided is too weak',
            title: 'Error',
            posActionName: 'OK',
          );
        } else if (e.code == 'email-already-in-use') {
          // todo : hide loading
          DialogUtils.hideDialog(context);
          // todo : show message
          DialogUtils.showMessage(
            context: context,
            message: 'The account already exists for that email.',
            title: 'Error',
            posActionName: 'OK',
          );
        }
      } catch (e) {
        // todo : hide loading
        DialogUtils.hideDialog(context);
        // todo : show message
        DialogUtils.showMessage(
          context: context,
          message: '${e.toString()}',
          title: 'Error',
          posActionName: 'OK',
        );
      }
    }
  }
}
