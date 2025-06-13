import 'package:flutter/material.dart';
import 'package:litlens_v1/features/profile/domain/entities/profile_user.dart';
import 'package:litlens_v1/features/profile/presentation/pages/profile_page.dart';

class UserTile extends StatelessWidget {
  final ProfileUser user;
  const UserTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.person,
        size: 40,
        color: Theme.of(context).colorScheme.primary,
      ),
      title: Text(user.name),
      subtitle: Text(user.email),
      subtitleTextStyle: TextStyle(
        color: Theme.of(context).colorScheme.primary,
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: Theme.of(context).colorScheme.primary,
      ),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage(uid: user.uid)),
      ),
    );
  }
}
