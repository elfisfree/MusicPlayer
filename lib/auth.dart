import 'package:flutter/material.dart';
import 'package:music_player/database/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('images/logo.png'),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.015,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.85,
            child: TextField(
              controller: emailController,
              cursorColor: Colors.white,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.white,
                ),
                labelText: 'Email',
                labelStyle: TextStyle(color: Color(0xFFC0C0C0)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.white)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.015,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.85,
            child: TextField(
              controller: passController,
              cursorColor: Colors.white,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.password,
                  color: Colors.white,
                ),
                labelText: 'Password',
                labelStyle: TextStyle(color: Color(0xFFC0C0C0)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.white)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Container(
              width: MediaQuery.of(context).size.width * 0.85,
              alignment: Alignment.centerRight,
              child: InkWell(
                child: Text('Забыли пароль?'),
                onTap: () {
                  Navigator.popAndPushNamed(context, '/recovery');
                },
              )),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.015,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.85,
            height: MediaQuery.of(context).size.height * 0.05,
            child: ElevatedButton(
              onPressed: () async {
                if (emailController.text.isEmpty ||
                    passController.text.isEmpty) {
                  print("Поля пустые!");
                } else {
                  var user = await authService.signIn(
                      emailController.text, passController.text);

                  if (user != null) {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setBool('isLoggedIn', true);
                    Navigator.popAndPushNamed(context, '/');// ignore: use_build_context_synchronously
                  } else {
                    print("Пользователь не найден");// ignore: avoid_print
                  }
                }
              },
              child: Text("Войти"),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.85,
            height: MediaQuery.of(context).size.height * 0.05,
            child: OutlinedButton(
                onPressed: () {
                  Navigator.popAndPushNamed(context, '/reg');
                },
                child: Text("Создать аккаунт")),
          ),
        ],
      ),
    ));
  }
}
