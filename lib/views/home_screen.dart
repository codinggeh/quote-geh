import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:quote_geh/viewmodels/favorites_viewmodel.dart';
import 'package:quote_geh/viewmodels/quote_viewmodel.dart';
import 'package:quote_geh/viewmodels/theme_viewmodel.dart';
import 'package:quote_geh/views/favorites_screen.dart';
import 'package:quote_geh/views/widgets/quote_card.dart';

final bottomNavIndexProvider = StateProvider<int>((ref) => 0);

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavIndexProvider);
    final themeMode = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('title'.tr()),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              ref.read(themeProvider.notifier).setTheme(
                    themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark,
                  );
            },
          ),
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {
              if (context.locale.languageCode == 'en') {
                context.setLocale(const Locale('id', 'ID'));
              } else {
                context.setLocale(const Locale('en', 'US'));
              }
            },
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: IndexedStack(
            index: currentIndex,
            children: const [
              QuoteTab(),
              FavoritesScreen(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          NavigationBar(
            selectedIndex: currentIndex,
            onDestinationSelected: (index) {
              ref.read(bottomNavIndexProvider.notifier).state = index;
            },
            destinations: [
              NavigationDestination(
                icon: const Icon(Icons.format_quote_outlined),
                selectedIcon: const Icon(Icons.format_quote),
                label: 'nav.quotes'.tr(),
              ),
              NavigationDestination(
                icon: const Icon(Icons.favorite_outline),
                selectedIcon: const Icon(Icons.favorite),
                label: 'nav.favorites'.tr(),
              ),
            ],
          ),
          GestureDetector(
            onTap: () => launchUrl(Uri.parse('https://codinggeh.com')),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Coding Geh',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.primary,
                      decoration: TextDecoration.underline,
                      decorationColor: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '© ${DateTime.now().year} · ${'footer.rights'.tr()}',
                    style: TextStyle(
                      fontSize: 10,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class QuoteTab extends ConsumerStatefulWidget {
  const QuoteTab({super.key});

  @override
  ConsumerState<QuoteTab> createState() => _QuoteTabState();
}

class _QuoteTabState extends ConsumerState<QuoteTab> {
  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 15), (_) {
      ref.invalidate(randomQuoteProvider);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final quoteAsync = ref.watch(randomQuoteProvider);
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Spacer(),
          quoteAsync.when(
            data: (quote) => QuoteCard(
              quote: quote,
              onFavorite: () {
                ref.read(favoritesProvider.notifier).toggleFavorite(quote);
                ref.invalidate(isFavoriteProvider(quote));
              },
              onShare: () {
                Share.share('"${quote.text}"\n\n— ${quote.author}');
              },
            ).animate().fadeIn(duration: 400.ms).scale(begin: const Offset(0.95, 0.95)),
            loading: () => const CircularProgressIndicator(),
            error: (e, _) => Column(
              children: [
                Icon(Icons.error_outline, size: 48, color: theme.colorScheme.error),
                const SizedBox(height: 16),
                Text('Error: $e'),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
