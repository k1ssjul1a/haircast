import 'package:flutter/material.dart';

import 'widgets/settings.dart';
import 'widgets/user_infos.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: const Text("Hello [user]")
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            UserInfos(),
            Settings(),
          ],
        ),
      ),
    );
  }
}
