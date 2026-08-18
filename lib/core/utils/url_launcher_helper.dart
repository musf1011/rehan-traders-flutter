import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherHelper {
  static Future<void> launchLink({
    required BuildContext context,
    required String url,
    required String errorMessage,
  }) async {
    try {
      final Uri uri = Uri.parse(url);

      final bool launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (!launched) {
        throw Exception('Launch failed');
      }
    } catch (e) {
      debugPrint('URL LAUNCH ERROR: $e');

      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(errorMessage)));
      }
    }
  }
}
