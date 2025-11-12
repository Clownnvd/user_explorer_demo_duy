import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_user_explorer/features/users/presentation/cubit/user_cubit.dart';
import 'package:github_user_explorer/features/users/presentation/cubit/user_state.dart';
import 'package:github_user_explorer/features/users/presentation/widgets/EmptyState.dart';
import 'package:github_user_explorer/features/users/presentation/widgets/ErrorState.dart';
import 'package:github_user_explorer/features/users/presentation/widgets/LoadingIndicator.dart';
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
                    return const EmptyStateWidget();
                  case UserLoading():
                    return const LoadingIndicator();
                  case UserLoaded(:final users):
                    return LayoutBuilder(
                      builder: (context, constraints) {
                        // nếu màn hình rộng hơn 600px => hiển thị dạng lưới
                        final isWide = constraints.maxWidth > 600;

                        if (isWide) {
                          return GridView.builder(
                            padding: const EdgeInsets.all(8),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 3,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                            ),
                            itemCount: users.length,
                            itemBuilder: (_, index) =>
                                UserCard(user: users[index]),
                          );
                        } else {
                          return ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemCount: users.length,
                            itemBuilder: (_, index) =>
                                UserCard(user: users[index]),
                          );
                        }
                      },
                    ); //responsive
                  // Phần BlocBuilder sửa lại
                  case UserError(:final message):
                    return Center(
                      child: ErrorMessageWidget(
                        errorText: l10n.errorState,
                        details: message,
                        onRetry: () => context.read<UserCubit>().fetchUsers(),
                        retryText: l10n.retry,
                        textStyle: Theme.of(context).textTheme.bodySmall,
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
