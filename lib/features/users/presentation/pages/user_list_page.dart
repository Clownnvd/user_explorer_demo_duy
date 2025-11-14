import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_user_explorer/features/users/presentation/cubit/user_cubit.dart';
import 'package:github_user_explorer/features/users/presentation/cubit/user_state.dart';
import 'package:github_user_explorer/features/users/presentation/widgets/UserCard.dart';
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
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.usersTitle)),
      body: Column(
        children: [
          _buildSearch(l10n),
          Expanded(
            child: BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const Center(child: Text("Hãy tìm người dùng")),
                  loading: () => const Center(child: CircularProgressIndicator()),
                  loaded: (users) => _buildResult(users),
                  error: (msg) => Center(
                    child: Text(
                      msg,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearch(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: l10n.searchHint,
          suffixIcon: IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              context
                  .read<UserCubit>()
                  .fetchUsers(query: _controller.text);
            },
          ),
        ),
        onSubmitted: (v) =>
            context.read<UserCubit>().fetchUsers(query: v),
      ),
    );
  }

  Widget _buildResult(List users) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: users.length,
      itemBuilder: (_, index) => UserCard(user: users[index]),
    );
  }
}
