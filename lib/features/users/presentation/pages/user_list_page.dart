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
    final mediaQuery = MediaQuery.of(context); 
    final isTabletOrWider = mediaQuery.size.width >= 600;
    double horizontal = isTabletOrWider ? 24 : 8;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.usersTitle)),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontal,
          vertical: 8,
        ),
        child: Column(
          children: [
            _buildSearch(l10n),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return BlocBuilder<UserCubit, UserState>(
                    builder: (context, state) {
                      return state.when(
                        initial: () => const Center(
                          child: Text("Hãy tìm người dùng"),
                        ),
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        loaded: (users) =>
                            _buildResult(users, constraints),
                        error: (msg) => Center(
                          child: Text(
                            msg,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Ô search giữ nguyên chức năng nhưng bo góc + UX tốt hơn một chút.
  Widget _buildSearch(AppLocalizations l10n) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        hintText: l10n.searchHint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        suffixIcon: IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            context.read<UserCubit>().fetchUsers(
                  query: _controller.text,
                );
          },
        ),
      ),
      onSubmitted: (v) =>
          context.read<UserCubit>().fetchUsers(query: v),
    );
  }

  /// Kết quả được render responsive:
  /// - Màn nhỏ (mobile): ListView như cũ
  /// - Tablet: Grid 2 cột
  /// - Màn lớn / web: Grid 3–4 cột
  Widget _buildResult(List users, BoxConstraints constraints) {
    final maxWidth = constraints.maxWidth;

    if (maxWidth >= 1200) {
      // Desktop / màn rất rộng → 4 cột
      return GridView.builder(
        padding: const EdgeInsets.only(top: 8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisExtent: 100,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: users.length,
        itemBuilder: (_, index) => UserCard(user: users[index]),
      );
    } else if (maxWidth >= 900) {
      // Tablet xoay ngang / màn trung bình → 3 cột
      return GridView.builder(
        padding: const EdgeInsets.only(top: 8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisExtent: 100,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: users.length,
        itemBuilder: (_, index) => UserCard(user: users[index]),
      );
    } else if (maxWidth >= 600) {
      // Tablet dọc → 2 cột
      return GridView.builder(
        padding: const EdgeInsets.only(top: 8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 100,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: users.length,
        itemBuilder: (_, index) => UserCard(user: users[index]),
      );
    }

    // Mobile: giữ nguyên behavior ListView như code cũ
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8),
      itemCount: users.length,
      itemBuilder: (_, index) => UserCard(user: users[index]),
    );
  }
}
