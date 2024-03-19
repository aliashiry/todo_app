import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/theme/my_theme.dart';
import 'package:todo_app/core/utils/Interface.dart';
import 'package:todo_app/core/utils/dialog_utils.dart';
import 'package:todo_app/model/register_screen_view_model/register_screen_view_model.dart';
import 'package:todo_app/pages/auth/custom_text_form_field.dart';
import 'package:todo_app/pages/auth/login_screen_view/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register_screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> implements InterFace {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  RegisterScreenViewModel viewModel = RegisterScreenViewModel();
  var formkey = GlobalKey<FormState>();
  bool obscureText = true;
  bool obscureText1 = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Stack(children: [
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
                  Navigator.pushReplacementNamed(
                      context, LoginScreen.routeName);
                },
              ),
              backgroundColor: Colors.transparent,
              title: Text(
                AppLocalizations.of(context)!.create_account,
                style: Theme.of(context).textTheme.titleLarge,
              ),
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
                            AppLocalizations.of(context)!.create_account,
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
              ]),
            ))
      ]),
    );
  }

  void register() async {
    if (formkey.currentState!.validate() == true) {
      viewModel.register(emailController.text, passwordController.text,
          nameController.text, context);
    }
  }

  @override
  void hideDialog() {
    // TODO: implement hideDialog
    DialogUtils.hideDialog(context);
  }

  @override
  void showLoading() {
    // TODO: implement showLoading
    DialogUtils.showLoading(context: context, message: 'Loading...');
  }

  @override
  Future<void> showMessage(String message) async {
    // TODO: implement showMessage
    DialogUtils.showMessage(
        context: context, message: message, posActionName: 'ok');
  }
}
