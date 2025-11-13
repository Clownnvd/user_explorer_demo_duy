import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:github_user_explorer/features/users/domain/entities/github_user.dart';

class UserCard extends StatelessWidget {
  final GithubUser user;

  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(backgroundImage: NetworkImage(user.avatarUrl)),
        title: Text(user.login),
        subtitle: Text(user.htmlUrl),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          context.push(
            '/detail/${user.id}?login=${user.login}&avatar=${user.avatarUrl}',
          );
        },
      ),
    );
  }
}
