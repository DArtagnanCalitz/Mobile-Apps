import 'package:cohort_confessions/provider/user_provider.dart';
import 'package:cohort_confessions/widgets/post_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transparent_image/transparent_image.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return ListView(
      children: [
        ProfileHeader(
          // todo: all usernames must be lowercase and start with underscore
          // username: "_username",
          username: user.name,
          photo: user.photo,
        ),
        Divider(color: Colors.grey[800]),
        ...List.generate(
          5,
          (index) => PostCard(
            username: "_username",
            photo: Image.memory(kTransparentImage),
            content: "Sample post $index",
            upvotes: 15,
            downvotes: 2,
            comments: 1,
            weather: '',
          ),
        ),
      ],
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.username,
    this.photo,
  });

  final String username;
  final Image? photo;

  @override
  Widget build(BuildContext context) {
    var icon;

    if (photo == null) {
      icon = const Icon(Icons.person, size: 40, color: Colors.white);
    } else {
      icon = photo;
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey[700],
            backgroundImage: icon.image,
          ),
          const SizedBox(height: 12),
          Text(
            username,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    '8 posts',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '8 replies',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '2 upvotes',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
