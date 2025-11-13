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

  void _onSearch() {
    context.read<UserCubit>().fetchUsers(query: _controller.text);
  }

  void _onSubmit(String value) {
    context.read<UserCubit>().fetchUsers(query: value);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n!.usersTitle)),
      body: Column(
        children: [
          // SEARCH BAR
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: l10n.searchHint,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _onSearch,
                ),
              ),
              onSubmitted: _onSubmit,
            ),
          ),

          // STATE HANDLER
          Expanded(
            child: BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const EmptyStateWidget(),

                  loading: () => const LoadingIndicator(),

                  loaded: (users) {
                    return LayoutBuilder(
                      builder: (context, constraints) {
                        final isWide = constraints.maxWidth > 600;

                        // GRID UI FOR LARGE SCREEN
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
                        }

                        // LIST UI FOR MOBILE
                        return ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemCount: users.length,
                          itemBuilder: (_, index) =>
                              UserCard(user: users[index]),
                        );
                      },
                    );
                  },

                  error: (message) => Center(
                    child: ErrorMessageWidget(
                      errorText: l10n.errorState,
                      details: message,
                      onRetry: () =>
                          context.read<UserCubit>().fetchUsers(),
                      retryText: l10n.retry,
                      textStyle: Theme.of(context).textTheme.bodySmall,
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
}
