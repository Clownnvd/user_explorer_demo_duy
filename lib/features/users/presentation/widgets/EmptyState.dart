import 'package:flutter/material.dart';
import 'package:github_user_explorer/l10n/app_localizations.dart';
class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Center(child: Text(l10n!.emptyState));
  }
}