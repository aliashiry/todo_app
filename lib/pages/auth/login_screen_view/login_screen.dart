import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/theme/my_theme.dart';
import 'package:todo_app/core/utils/Interface.dart';
import 'package:todo_app/core/utils/dialog_utils.dart';
import 'package:todo_app/model/login_screen_view_model/login_screen_view_model.dart';
import 'package:todo_app/pages/auth/custom_text_form_field.dart';
import 'package:todo_app/pages/auth/register_screen_view/register_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "login screen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements InterFace {
  TextEditingController emailController =
      TextEditingController(text: 'ali@gmail.com');
  TextEditingController passwordController =
      TextEditingController(text: '123456');
  bool obscureText = true;
  var formKey = GlobalKey<FormState>();
  LoginScreenViewModel viewModel = LoginScreenViewModel();

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
      child: Stack(
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
                AppLocalizations.of(context)!.login,
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
                              child: Text(
                                  AppLocalizations.of(context)!.welcome_back,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        color: Colors.black,
                                      )),
                            ),
                            CustomTextFormField(
                              lableText: 'Email',
                              keyboardType: TextInputType.emailAddress,
                              controller: viewModel.email,
                              validator: (text) {
                                if (text == null || text.trim().isEmpty) {
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
                              lableText: 'Password',
                              obscureText: obscureText,
                              suffixIcon: InkWell(
                                  onTap: () {
                                    obscureText == true
                                        ? obscureText = false
                                        : obscureText = true;
                                    setState(() {});
                                  },
                                  child: Icon(Icons.remove_red_eye_outlined)),
                              keyboardType: TextInputType.number,
                              controller: viewModel.password,
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
                            Padding(
                              padding: const EdgeInsets.only(right: 8, left: 8),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(RegisterScreen.routeName);
                                },
                                child: Container(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                      AppLocalizations.of(context)!
                                          .forgot_password,
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
                                    AppLocalizations.of(context)!.login,
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
                        Navigator.of(context)
                            .pushNamed(RegisterScreen.routeName);
                      },
                      child: Text(
                          AppLocalizations.of(context)!.or_create_my_account,
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
      ),
    );
  }

  void login() async {
    if (formKey.currentState?.validate() == true) {
      viewModel.login(context);
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
  void showMessage(String message) {
    // TODO: implement showMessage
    DialogUtils.showMessage(
        context: context, message: message, posActionName: 'ok');
  }
}
