import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_user_explorer/features/users/presentation/cubit/user_cubit.dart';
import 'package:github_user_explorer/features/users/presentation/cubit/user_state.dart';
import 'package:github_user_explorer/features/users/presentation/widgets/user_card.dart';
import 'package:github_user_explorer/l10n/app_localizations.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n!.usersTitle)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: l10n.searchHint,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => context
                      .read<UserCubit>()
                      .fetchUsers(query: _controller.text),
                ),
              ),
              onSubmitted: (v) =>
                  context.read<UserCubit>().fetchUsers(query: v),
            ),
          ),
          Expanded(
            child: BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                switch (state) {
                  case UserInitial():
                    return Center(child: Text(l10n.emptyState));
                  case UserLoading():
                    return const Center(child: CircularProgressIndicator());
                  case UserLoaded(:final users):
                    return ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) =>
                          UserCard(user: users[index]),
                    );
                  case UserError(:final message):
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(l10n.errorState),
                          Text(message,
                              style: Theme.of(context).textTheme.bodySmall),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () =>
                                context.read<UserCubit>().fetchUsers(),
                            child: Text(l10n.retry),
                          )
                        ],
                      ),
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
