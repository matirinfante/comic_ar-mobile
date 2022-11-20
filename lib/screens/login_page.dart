import 'dart:convert';

import 'package:comic_ar/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../services/User.dart';

const users = {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class LoginScreen extends StatelessWidget {
  Duration get loginTime => const Duration(milliseconds: 2250);
  final String _email = '';
  final String _password = '';

  Future<String?> loginPressed(LoginData data) async {
    final prefs = await SharedPreferences.getInstance();

    debugPrint('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) async {
      http.Response response =
          await AuthServices.login(data.name, data.password);
      Map responseMap = jsonDecode(response.body);
      await prefs.setInt('user_id', responseMap['user']['id']);
      // debugPrint('${responseMap['user']['id']}');
      return null;
    });
  }

  Future<String?> _signupUser(SignupData data) {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return 'ok';
    });
  }

  @override
  Widget build(BuildContext context) {
    const inputBorder = BorderRadius.vertical(
      bottom: Radius.circular(10.0),
      top: Radius.circular(10.0),
    );

    return FlutterLogin(
      //title: 'Comic-AR',
      logo: const AssetImage('assets/logo.png'),
      onLogin: loginPressed,
      onSignup: _signupUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ));
      },
      onRecoverPassword: _recoverPassword,
      messages: LoginMessages(
        userHint: 'Correo Electronico',
        passwordHint: 'Contraseña',
        confirmPasswordHint: 'Confirmar',
        loginButton: 'Ingresar',
        signupButton: 'Registrarse',
        forgotPasswordButton: 'Olvidaste tu contraseña?',
        recoverPasswordButton: '¡Ayuda!',
        goBackButton: 'Ir atrás',
        confirmPasswordError: 'Ha ocurrido un error!',
        recoverPasswordDescription:
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
        recoverPasswordSuccess: 'Password rescued successfully',
      ),
      theme: LoginTheme(
        primaryColor: Colors.teal,
        errorColor: Colors.deepOrange,
        titleStyle: const TextStyle(
          color: Colors.greenAccent,
          fontFamily: 'Quicksand',
          letterSpacing: 2,
        ),
        cardTheme: CardTheme(
          color: Colors.yellow.shade100,
          elevation: 2,
          margin: const EdgeInsets.only(top: 25),
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(50.0)),
        ),
        buttonTheme: LoginButtonTheme(
          splashColor: Colors.purple,
          backgroundColor: Colors.pinkAccent,
          highlightColor: Colors.lightGreen,
          elevation: 5,
          highlightElevation: 2,
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          // shape: CircleBorder(side: BorderSide(color: Colors.green)),
          // shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(55.0)),
        ),
      ),
    );
  }
}
