import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_app/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:location_app/features/presentation/cubit/auth/auth_state.dart';
import 'package:location_app/features/presentation/cubit/credential/credential_cubit.dart';
import 'package:location_app/features/presentation/widgets/common.dart';
import 'package:location_app/features/presentation/widgets/theme/style.dart';
import '../../../page_const.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isShowPassword = true;

  final GlobalKey<ScaffoldMessengerState> _scaffoldState =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
                msg: "Wrong email/password please check", context: context);
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

  _bodyWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          Container(
              alignment: Alignment.center,
              child: const Text(
                'Login',
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
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: color747480.withOpacity(.2),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.grey,
                ),
                hintText: 'Email',
                hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 17,
                    fontWeight: FontWeight.w400),
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: color747480.withOpacity(.2),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: TextField(
              obscureText: _isShowPassword,
              controller: _passwordController,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.lock,
                  color: Colors.grey,
                ),
                hintText: 'Password',
                hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 17,
                    fontWeight: FontWeight.w400),
                border: InputBorder.none,
                suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        _isShowPassword =
                            _isShowPassword == false ? true : false;
                      });
                    },
                    child: Icon(_isShowPassword == false
                        ? Icons.remove_red_eye
                        : Icons.panorama_fish_eye)),
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              _submitLogin();
            },
            child: Container(
              alignment: Alignment.center,
              height: 44,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: greenColor,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: const Text(
                'Login',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.topRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "Don't have an Account",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, PageConst.registrationPage);
                  },
                  child: const Text(
                    'Register',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: greenColor),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  bool checkCredentials() {
    if (_emailController.text.isEmpty) {
      toast('enter your email');
      return false;
    }
    if (_passwordController.text.isEmpty) {
      toast('enter your password');
      return false;
    }
    return true;
  }

  void _submitLogin() {
    if (checkCredentials()) {
      BlocProvider.of<CredentialCubit>(context).signInSubmit(
        email: _emailController.text,
        password: _passwordController.text,
      );
    }
  }
}
