import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final String userName = "Иван Иванов";
  final String userBio = "Любитель музыки и путешествий";
  final String userAvatar = "images/avatar.png";
  final List<String> favoriteTracks = [
    "Трек 1 - Исполнитель 1",
    "Трек 2 - Исполнитель 2",
    "Трек 3 - Исполнитель 3",
  ];
  List<bool> isFavouriteList = [];

  @override
  void initState() {
    super.initState();
    isFavouriteList = List.generate(favoriteTracks.length, (index) => true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Убирает кнопку "Назад"
        actions: [
          // Кнопка редактирования
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
            onPressed: () {
              Navigator.popAndPushNamed(context, '/');
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
                    userName,
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
    setState(() {
      favoriteTracks.removeAt(index);
      isFavouriteList.removeAt(index);
    });
  }
}