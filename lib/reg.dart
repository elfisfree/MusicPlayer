import 'package:flutter/material.dart';
import 'package:music_player/database/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegPage extends StatefulWidget {
  const RegPage({super.key});

  @override
  State<RegPage> createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController repeatController = TextEditingController();
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
          SizedBox(height: 10),
          Text(
            "Длина пароля должна составлять минимум 6 символов",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Color(0xFFC0C0C0),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.015,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.85,
            child: TextField(
              controller: repeatController,
              cursorColor: Colors.white,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.password,
                  color: Colors.white,
                ),
                labelText: 'Confirm password',
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
            height: MediaQuery.of(context).size.height * 0.05,
            child: ElevatedButton(
              onPressed: () async {
                if (emailController.text.isEmpty ||
                    passController.text.isEmpty ||
                    repeatController.text.isEmpty) {
                  print("Поля пустые");
                } else {
                  if (passController.text == repeatController.text) {
                    var user = await authService.signUp(
                        emailController.text, passController.text);
                    if (user != null) {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setBool('isLoggedIn', true);
                      Navigator.popAndPushNamed(context,
                          '/'); // ignore: use_build_context_synchronously
                    } else {
                      print("Пользователь не СОЗДАН"); // ignore: avoid_print
                    }
                  } else {
                    print("Пароли не совпадают");
                  }
                }
              },
              child: Text("Зарегистрироваться"),
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
                  Navigator.popAndPushNamed(context, '/');
                },
                child: Text("Уже есть аккаунт?")),
          ),
        ],
      ),
    ));
  }
}
