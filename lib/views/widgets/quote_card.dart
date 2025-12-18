import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quote_geh/models/quote.dart';
import 'package:quote_geh/viewmodels/favorites_viewmodel.dart';

class QuoteCard extends ConsumerWidget {
  final Quote quote;
  final VoidCallback? onFavorite;
  final VoidCallback? onShare;
  final VoidCallback? onDelete;
  final bool showFavoriteButton;

  const QuoteCard({
    super.key,
    required this.quote,
    this.onFavorite,
    this.onShare,
    this.onDelete,
    this.showFavoriteButton = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isFavAsync = ref.watch(isFavoriteProvider(quote));

    return Card(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [
                    theme.colorScheme.surface,
                    theme.colorScheme.surface.withAlpha(204),
                  ]
                : [
                    Colors.white,
                    Colors.grey.shade50,
                  ],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.format_quote,
              size: 40,
              color: theme.colorScheme.primary.withAlpha(128),
            ),
            const SizedBox(height: 16),
            Text(
              quote.text,
              textAlign: TextAlign.center,
              style: GoogleFonts.merriweather(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.italic,
                height: 1.6,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withAlpha(26),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '— ${quote.author}',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (showFavoriteButton)
                  IconButton(
                    onPressed: onFavorite,
                    icon: isFavAsync.when(
                      data: (isFav) => Icon(
                        isFav ? Icons.favorite : Icons.favorite_outline,
                        color: isFav ? Colors.red : theme.hintColor,
                      ),
                      loading: () => Icon(Icons.favorite_outline, color: theme.hintColor),
                      error: (_, __) => Icon(Icons.favorite_outline, color: theme.hintColor),
                    ),
                  ),
                IconButton(
                  onPressed: onShare,
                  icon: Icon(Icons.share_outlined, color: theme.hintColor),
                ),
                if (onDelete != null)
                  IconButton(
                    onPressed: onDelete,
                    icon: Icon(Icons.delete_outline, color: theme.colorScheme.error),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
