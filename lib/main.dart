import 'package:flutter/material.dart';
import 'package:music_player/auth.dart';
import 'package:music_player/home.dart';
import 'package:music_player/medialibrary.dart';
import 'package:music_player/profile.dart';
import 'package:music_player/recovery_pass.dart';
import 'package:music_player/reg.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5taWRjbXN4a3FiZ3NqaGhudmZvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzk5NTk3NTYsImV4cCI6MjA1NTUzNTc1Nn0.cOmTMXTTj9x2y8zEr17w_ne8HTEaMN0meQ0UAbgAH1A',
    url: 'https://nmidcmsxkqbgsjhhnvfo.supabase.co',
    );
  runApp(const AppTheme());
}

class AppTheme extends StatelessWidget {
  const AppTheme({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blueGrey,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20),
        ),
        scaffoldBackgroundColor: Colors.blueGrey,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.white),
            foregroundColor: WidgetStatePropertyAll(Colors.blueGrey)
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(Colors.white),
           ),
        ),
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        )
      ),
      initialRoute: "/",
      routes: {
        '/': (context) => AuthPage(),
        '/reg': (context) => RegPage(),
        '/recovery': (context) => RecoveryPage(),
        '/home': (context) => HomePage(),
        '/medialibrary': (context) => MediaLibraryPage(),
        '/profile': (context) => ProfilePage()
      },
    );
  }
}