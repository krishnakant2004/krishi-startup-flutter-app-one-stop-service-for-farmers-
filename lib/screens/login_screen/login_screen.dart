import 'package:krishidost/screens/UserScreen.dart';
import 'package:krishidost/utility/app_data.dart';

import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:krishidost/utility/extensions.dart';

import '../../entry_app/login.dart';



class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LoginPage();
    // return FlutterLogin(
    //   // savedEmail: 'testing@gmail.com',
    //   // savedPassword: '12345',
    //   loginAfterSignUp: false,
    //   logo: const AssetImage('assets/krishi_logo.png'),
    //   onLogin: (LoginData data) {
    //     context.userProvider.login(data);
    //   },
    //   onSignup: (SignupData data) {
    //     context.userProvider.register(data);
    //   },
    //   onSubmitAnimationCompleted: () {
    //     if(context.userProvider.getLoginUsr()?.sId != null){
    //       Navigator.of(context).pushReplacement(MaterialPageRoute(
    //         builder: (context) {
    //           return const UserScreen();
    //         },
    //       ));
    //     }else{
    //       Navigator.of(context).pushReplacement(MaterialPageRoute(
    //         builder: (context) {
    //           return const LoginScreen();
    //         },
    //       ));
    //     }
    //   },
    //   onRecoverPassword: (_) => null,
    //   hideForgotPasswordButton: true,
    //   theme: LoginTheme(
    //       primaryColor: AppData.darkGrey,
    //       accentColor: AppData.darkOrange,
    //       buttonTheme: const LoginButtonTheme(
    //         backgroundColor: AppData.darkOrange,
    //       ),
    //       cardTheme: const CardTheme(color: Colors.white, surfaceTintColor: Colors.white),
    //       titleStyle: const TextStyle(color: Colors.black)),
    // );
  }
}
