import 'package:flutter/material.dart';

class MediaLibraryPage extends StatefulWidget {
  const MediaLibraryPage({super.key});

  @override
  State<MediaLibraryPage> createState() => _MediaLibraryPageState();
}

class _MediaLibraryPageState extends State<MediaLibraryPage> {
  // Состояние для избранного для каждого трека
  List<bool> isFavouriteList = [];

  final List<String> savedPlaylists = [
    'Плейлист 1',
    'Плейлист 2',
    'Плейлист 3',
  ];

  final List<String> favoriteTracks = [
    'Трек 1',
    'Трек 2',
    'Трек 3',
  ];

  final List<String> recentlyPlayedAlbums = [
    'Альбом 1',
    'Альбом 2',
    'Альбом 3',
  ];

  @override
  void initState() {
    super.initState();
    // Инициализация списка состояний "избранного" (по умолчанию все треки не избранные)
    isFavouriteList = List.generate(favoriteTracks.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: Text(
                'Сохраненные плейлисты',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 180,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: savedPlaylists.map((playlist) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Container(
                            width: 140,
                            height: 140,
                            decoration: BoxDecoration(
                              color: Colors.grey[800],
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Icon(Icons.music_note,
                                color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          playlist,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
              child: Text(
                'Избранные треки',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Column(
              children: favoriteTracks.asMap().entries.map((entry) {
                final index = entry.key;
                final track = entry.value;
                return ListTile(
                  leading: const Icon(Icons.music_note, color: Colors.white),
                  title: Text(
                    track,
                    style: const TextStyle(color: Colors.white),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      isFavouriteList[index] ? Icons.favorite : Icons.favorite_border,
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
              }).toList(),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
              child: Text(
                'Недавно прослушанные альбомы',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 180,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: recentlyPlayedAlbums.map((album) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                          },
                          child: Container(
                            width: 140,
                            height: 140,
                            decoration: BoxDecoration(
                              color: Colors.grey[800],
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Icon(Icons.album, color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          album,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}