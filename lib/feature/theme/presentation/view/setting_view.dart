import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/cubit/theme_cubit.dart';
import '../../data/cubit/theme_state.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'الإعدادات',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        children: const [
          _SectionTitle('المظهر'),
          SizedBox(height: 12),
          _ModernThemeSettingCard(),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}

class _ModernThemeSettingCard extends StatelessWidget {
  const _ModernThemeSettingCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: theme.colorScheme.outlineVariant.withOpacity(0.5),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'اختر المظهر المفضل',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 12),

              // زر التبديل العصري SegmentedButton
              SizedBox(
                width: double.infinity,
                child: SegmentedButton<bool>(
                  segments: const [
                    ButtonSegment<bool>(
                      value: false,
                      label: Text('فاتح'),
                      icon: Icon(Icons.light_mode_rounded),
                    ),
                    ButtonSegment<bool>(
                      value: true,
                      label: Text('داكن'),
                      icon: Icon(Icons.dark_mode_rounded),
                    ),
                  ],
                  selected: {state.isDark},
                  onSelectionChanged: (newSelection) {
                    context.read<ThemeCubit>().setDarkMode(newSelection.first);
                  },
                  style: SegmentedButton.styleFrom(
                    selectedBackgroundColor: theme.colorScheme.primaryContainer,
                    selectedForegroundColor: theme.colorScheme.onPrimaryContainer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
class _ThemeSwitchCard extends StatelessWidget {
  const _ThemeSwitchCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(20),
          ),
          child: SwitchListTile.adaptive(
            value: state.isDark,
            onChanged: (value) => context.read<ThemeCubit>().setDarkMode(value),
            title: const Text(
              'الوضع الداكن',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              state.isDark ? 'مفعل الان' : 'معطل الان',
              style: TextStyle(color: theme.colorScheme.outline),
            ),
            secondary: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Icon(
                state.isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                key: ValueKey<bool>(state.isDark),
                color: theme.colorScheme.primary,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        );
      },
    );
  }
}