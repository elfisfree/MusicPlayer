import 'package:flutter/material.dart';
import 'package:music_player/database/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userEmail = "Загрузка...";
  final String userBio = "Любитель музыки и путешествий";
  final String userAvatar = "images/avatar.png";
  final List<String> favoriteTracks = [
    "Трек 1 - Исполнитель 1",
    "Трек 2 - Исполнитель 2",
    "Трек 3 - Исполнитель 3",
  ];
  List<bool> isFavouriteList = [];
  AuthService authService = AuthService();
  final SupabaseClient supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    isFavouriteList = List.generate(favoriteTracks.length, (index) => true);
    _fetchUserEmail(); // Загружаем email пользователя
  }

  Future<void> _fetchUserEmail() async {
    try {
      // Получаем текущего пользователя
      final user = supabase.auth.currentUser;
      if (user == null) {
        throw Exception("Пользователь не авторизован");
      }

      // Обновляем состояние с email пользователя
      setState(() {
        userEmail = user.email ?? "Email не указан";
      });
    } catch (e) {
      setState(() {
        userEmail = "Ошибка загрузки email";
      });
      print("Ошибка при загрузке email: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            color: const Color.fromARGB(180, 255, 255, 255),
            onPressed: () {
              _editProfile();
            },
          ),
          // Кнопка выхода
          IconButton(
            icon: const Icon(Icons.exit_to_app_outlined),
            color: const Color.fromARGB(180, 255, 255, 255),
            onPressed: () async {
              await authService.logOut();
              final prefs = await SharedPreferences.getInstance();
              await prefs.setBool('isLoggedIn', false);
              Navigator.popAndPushNamed(context, '/auth');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(userAvatar),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    userEmail,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    userBio,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      _shareProfile();
                    },
                    child: const Text("Поделиться профилем"),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Любимые треки",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: favoriteTracks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.music_note),
                  title: Text(favoriteTracks[index]),
                  trailing: IconButton(
                    icon: Icon(
                      isFavouriteList[index]
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.white,
                      size: 24,
                    ),
                    onPressed: () {
                      setState(() {
                        isFavouriteList[index] = !isFavouriteList[index];
                      });
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _editProfile() {}
  void _shareProfile() {}
  void _removeFromFavorites(int index) {
    // ignore: unused_element
    setState(() {
      favoriteTracks.removeAt(index);
      isFavouriteList.removeAt(index);
    });
  }
}
