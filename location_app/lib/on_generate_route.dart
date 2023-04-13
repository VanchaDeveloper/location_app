import 'package:flutter/material.dart';
import 'package:location_app/features/presentation/pages/home_page.dart';
import 'package:location_app/page_const.dart';
import 'features/presentation/pages/login_page.dart';
import 'features/presentation/pages/registration_page.dart';

class OnGenerateRoute {
  static Route<dynamic> route(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        {
          return materialBuilder(widget: const LoginPage());
        }
      case PageConst.homePage:
        {
          return materialBuilder(
            widget: const HomePage(),
          );
        }
      case PageConst.loginPage:
        {
          return materialBuilder(
            widget: const LoginPage(),
          );
        }

      case PageConst.registrationPage:
        {
          return materialBuilder(
            widget: const RegistrationPage(),
          );
        }
      default:
        return materialBuilder(
          widget: const ErrorPage(),
        );
    }
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("error"),
      ),
      body: const Center(
        child: Text("error"),
      ),
    );
  }
}

MaterialPageRoute materialBuilder({required Widget widget}) {
  return MaterialPageRoute(builder: (_) => widget);
}
