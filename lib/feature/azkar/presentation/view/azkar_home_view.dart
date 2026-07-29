import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../core/constant/api_color.dart';

import '../../../theme/presentation/view/setting_view.dart';
import '../../data/cubit/cubit.dart';
import '../../data/cubit/state.dart';
import '../widgets/Icon_data.dart';
import 'azkar_view.dart';


class AzkarHomeView extends StatelessWidget {
  const AzkarHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AzkarCubit()..loadAllCategories(),
      child: const _AzkarHomeView(),
    );
  }
}
class _AzkarHomeView extends StatelessWidget {
  const _AzkarHomeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 110.0,
            floating: false,
            pinned: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.primary.withOpacity(0.85),
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(28),
                ),
              ),
              child: FlexibleSpaceBar(
                titlePadding: const EdgeInsetsDirectional.only(start: 20, bottom: 18),
                title: Text(
                  'أذكار المسلم',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: ApiColor.tertiary,
                  ),
                ),
              ),
            ),
          ),
          BlocBuilder<AzkarCubit, AzkarState>(
            builder: (context, state) {
              if (state is AzkarLoading || state is AzkarInitial) {
                return SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator.adaptive(
                      valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary),
                    ),
                  ),
                );
              }

              if (state is AzkarError) {
                return SliverFillRemaining(
                  child: Center(
                    child: Text(
                      state.message,
                      textDirection: TextDirection.rtl,
                      style: const TextStyle(fontSize: 16, color: Colors.redAccent),
                    ),
                  ),
                );
              }

              if (state is AzkarListLoaded) {
                return SliverPadding(
                  padding: const EdgeInsets.all(16.0),
                  sliver: SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                      childAspectRatio: 1.1,
                    ),
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        final category = state.categories[index];
                        return _CategoryCard(
                          title: category.title,
                          itemCount: category.items.length,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => AzkarView(categoryTitle: category.title),
                              ),
                            );
                          },
                        );
                      },
                      childCount: state.categories.length,
                    ),
                  ),
                );
              }

              return const SliverToBoxAdapter(
                  child: SizedBox.shrink()
              );
            },
          ),
        ],
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {

  final String title;
  final int itemCount;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.title,
    required this.itemCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final IconData iconData = getCategoryIcon(title);
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: ApiColor.tertiary.withOpacity(0.3),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: ApiColor.neutral.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: ApiColor.tertiary.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: FaIcon(
                      iconData,
                      size: 15,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      textDirection: TextDirection.rtl,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 14,
                          color: ApiColor.secondary,
                        ),
                        Text(
                          '$itemCount ذكر',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}