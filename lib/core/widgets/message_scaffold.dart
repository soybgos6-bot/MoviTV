import 'package:flutter/material.dart';
import 'package:movies_2see/core/theme/app_colors.dart';
import 'package:movies_2see/core/theme/app_spacing.dart';
import 'package:movies_2see/core/theme/app_typography.dart';

class MessageScaffold extends StatelessWidget {
  const MessageScaffold({super.key, required this.message, this.onRetry});

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final retry = onRetry;
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Center(
        child: Padding(
          padding: AppSpacing.screenPadding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.warning_amber_rounded,
                  color: AppColors.error, size: 48),
              SizedBox(height: AppSpacing.md),
              Text(message,
                  style: AppTypography.bodyMd, textAlign: TextAlign.center),
              if (retry != null) ...[
                SizedBox(height: AppSpacing.lg),
                ElevatedButton(
                    onPressed: retry, child: const Text('Reintentar')),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
