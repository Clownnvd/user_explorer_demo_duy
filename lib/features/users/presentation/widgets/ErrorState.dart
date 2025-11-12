import 'package:flutter/material.dart';
class ErrorMessageWidget extends StatelessWidget {
  final String errorText;
  final String details;
  final VoidCallback onRetry;
  final String retryText;
  final TextStyle? textStyle;
  const ErrorMessageWidget({
    super.key,
    required this.errorText,
    required this.details,
    required this.onRetry,
    this.retryText = "Retry",
    this.textStyle,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(errorText),
        Text(details, style: textStyle),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: onRetry,
          child: Text(retryText),
        ),
      ],
    );
  }
}