import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:location_app/features/domain/entities/user_entity.dart';
import 'package:location_app/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:location_app/features/presentation/cubit/auth/auth_state.dart';
import 'package:location_app/features/presentation/cubit/credential/credential_cubit.dart';
import 'package:location_app/features/presentation/widgets/common.dart';
import 'package:location_app/features/presentation/widgets/theme/style.dart';

import '../../../page_const.dart';
import 'home_page.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordAgainController =
      TextEditingController();

  final GlobalKey<ScaffoldMessengerState> _scaffoldState =
      GlobalKey<ScaffoldMessengerState>();

  final GlobalKey<FlutterPwValidatorState> validatorKey =
      GlobalKey<FlutterPwValidatorState>();

  bool _isShowPassword = true;

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    _passwordAgainController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      body: BlocConsumer<CredentialCubit, CredentialState>(
        listener: (context, credentialState) {
          if (credentialState is CredentialSuccess) {
            BlocProvider.of<AuthCubit>(context).loggedIn();
          }
          if (credentialState is CredentialFailure) {
            snackBar(
                msg: "Email Already Used. Please try again", context: context);
          }
        },
        builder: (context, credentialState) {
          if (credentialState is CredentialLoading) {
            return Scaffold(
              body: loadingIndicatorProgressBar(),
            );
          }
          if (credentialState is CredentialSuccess) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
                if (authState is Authenticated) {
                  return const HomePage();
                } else {
                  return _bodyWidget();
                }
              },
            );
          }

          return _bodyWidget();
        },
      ),
    );
  }

  Widget _bodyWidget() {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 70),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            Container(
                alignment: Alignment.center,
                child: const Text(
                  'Registration',
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w700,
                      color: greenColor),
                )),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              thickness: 1,
            ),
            const SizedBox(
              height: 15,
            ),
            Column(
              children: [
                Container(
                  height: 44,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: color747480.withOpacity(.2),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.lock,
                      ),
                      hintText: 'Email',
                      hintStyle:
                          TextStyle(color: Colors.black.withOpacity(0.3)),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 44,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: color747480.withOpacity(.2),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: TextField(
                    obscureText: _isShowPassword,
                    controller: _passwordController,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        hintText: 'Password',
                        hintStyle:
                            TextStyle(color: Colors.black.withOpacity(0.3)),
                        border: InputBorder.none,
                        suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _isShowPassword =
                                    _isShowPassword == false ? true : false;
                              });
                            },
                            child: Icon(_isShowPassword == false
                                ? Icons.remove_red_eye
                                : Icons.panorama_fish_eye))),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                FlutterPwValidator(
                  key: validatorKey,
                  controller: _passwordController,
                  minLength: 8,
                  uppercaseCharCount: 1,
                  numericCharCount: 1,
                  specialCharCount: 1,
                  normalCharCount: 1,
                  width: 400,
                  height: 140,
                  onSuccess: () {},
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 44,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: color747480.withOpacity(.2),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: TextField(
                    obscureText: _isShowPassword,
                    controller: _passwordAgainController,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.lock,
                        ),
                        hintText: 'Confirm Password',
                        hintStyle:
                            TextStyle(color: Colors.black.withOpacity(0.3)),
                        border: InputBorder.none,
                        suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _isShowPassword =
                                    _isShowPassword == false ? true : false;
                              });
                            },
                            child: Icon(_isShowPassword == false
                                ? Icons.remove_red_eye
                                : Icons.panorama_fish_eye))),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    _submitSignUp();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 44,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: greenColor,
                    ),
                    child: const Text(
                      'Register',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Do you have already an account?',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, PageConst.loginPage, (route) => false);
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: greenColor),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'By clicking register, you agree to the ',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: colorC1C1C1),
                    ),
                    Text(
                      'Privacy Policy',
                      style: TextStyle(
                          color: greenColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'and ',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: colorC1C1C1),
                    ),
                    Text(
                      'terms ',
                      style: TextStyle(
                          color: greenColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      'of use',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: colorC1C1C1),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool checkCredentials() {
    if (_emailController.text.isEmpty) {
      toast('Enter your email');
      return false;
    } else {
      if (!validateEmail(_emailController.text)) {
        toast("Enter valid email");
        return false;
      }
    }
    if (_passwordController.text.isEmpty) {
      toast('Enter your password');
      return false;
    } else {
      if (!validatePassword(_passwordController.text)) {
        toast("Enter valid password");
        return false;
      }
    }
    if (_passwordAgainController.text.isEmpty) {
      toast('Enter your again password');
      return false;
    } else {
      if (_passwordAgainController.text != _passwordController.text) {
        toast("Both the password are not same");
        return false;
      }
    }
    return true;
  }

  _submitSignUp() {
    if (checkCredentials()) {
      BlocProvider.of<CredentialCubit>(context).signUpSubmit(
        user: UserEntity(
          email: _emailController.text,
          password: _passwordController.text,
        ),
      );
    }
  }

  bool validateEmail(String email) {
    return (EmailValidator.validate(email)) ? true : false;
  }

  bool validatePassword(String password) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    return regex.hasMatch(password) ? true : false;
  }
}
