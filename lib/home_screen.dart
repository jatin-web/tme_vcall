import 'package:flutter/material.dart';
import 'package:tme_vcall/vcall_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ReplyVideoCard(
            videoUrl:
                "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
            time: "1020",
            onTap: () {}),
      ),
    );
  }
}
