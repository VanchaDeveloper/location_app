import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_app/app_const.dart';
import 'package:location_app/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:location_app/features/presentation/cubit/auth/auth_state.dart';
import 'package:location_app/features/presentation/cubit/credential/credential_cubit.dart';
import 'package:location_app/features/presentation/cubit/location/location_cubit.dart';
import 'package:location_app/features/presentation/pages/home_page.dart';
import 'package:location_app/features/presentation/pages/login_page.dart';
import 'package:location_app/on_generate_route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const LocationApp());
}

class LocationApp extends StatelessWidget {
  const LocationApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (_) => AuthCubit()..appStarted(),
        ),
        BlocProvider<CredentialCubit>(
          create: (_) => CredentialCubit(),
        ),
        BlocProvider<LocationCubit>(
          create: (_) => LocationCubit(),
        ),
      ],
      child: MaterialApp(
        title: AppConst.appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        initialRoute: '/',
        onGenerateRoute: OnGenerateRoute.route,
        routes: {
          "/": (context) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
                if (authState is Authenticated) {
                  return const HomePage();
                } else {
                  return const LoginPage();
                }
              },
            );
          }
        },
      ),
    );
  }
}
