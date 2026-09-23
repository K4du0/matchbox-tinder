import 'package:flutter/material.dart';

import 'screens/like_not_screen.dart';
import 'screens/matches_screen.dart';
import 'screens/messages_screen.dart';

void main() {
  runApp(const MatchBoxApp());
}

class MatchBoxApp extends StatelessWidget {
  const MatchBoxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MatchBox',

      initialRoute: '/like',

      routes: {
        '/like': (context) => const LikeScreen(),
        '/matches': (context) => const MatchesScreen(),
        '/messages': (context) => const MessagesScreen(),
      },
    );
  }
}