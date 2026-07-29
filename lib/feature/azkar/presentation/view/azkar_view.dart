import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constant/api_color.dart';
import '../../data/cubit/cubit.dart';
import '../../data/cubit/state.dart';
import '../../data/model/azkar_model.dart';


class AzkarView extends StatelessWidget {
  final String categoryTitle;

  const AzkarView({super.key, required this.categoryTitle});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AzkarCubit()..loadCategory(categoryTitle),
      child: const _AzkarView(),
    );
  }
}

class _AzkarView extends StatelessWidget {
  const _AzkarView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: BlocBuilder<AzkarCubit, AzkarState>(
        builder: (context, state) {
          if (state is AzkarLoading || state is AzkarInitial) {
            return Center(
              child: CircularProgressIndicator.adaptive(
                valueColor: AlwaysStoppedAnimation<Color>(ApiColor.primary),
              ),
            );
          }

          if (state is AzkarError) {
            return Center(
              child: Text(
                state.message,
                textDirection: TextDirection.rtl,
                style: const TextStyle(fontSize: 16, color: Colors.redAccent),
              ),
            );
          }

          if (state is AzkarLoaded) {
            final totalCount = state.category.items.length;
            final completedCount = state.progress.values.where((v) => v == 0).length;
            final double progressValue = totalCount > 0 ? completedCount / totalCount : 0.0;

            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                   expandedHeight: 120.0,
                  floating: false,
                  pinned: true,
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  leading: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: ApiColor.tertiary,
                        size: 18,
                      ),
                    ),
                  ),
                  flexibleSpace: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          ApiColor.primary,
                          ApiColor.primary.withOpacity(0.85),
                        ],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                      ),
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(28),
                      ),
                    ),
                    child: FlexibleSpaceBar(
                      titlePadding: const EdgeInsetsDirectional.only(start: 15, bottom: 18,top: 30,),

                      title: Center(
                        child: Text(
                          state.category.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: ApiColor.tertiary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  actions: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        tooltip: 'إعادة إحياء العداد',
                        icon: Icon(Icons.refresh_rounded, color: ApiColor.tertiary),
                        onPressed: () => context.read<AzkarCubit>().resetProgress(),
                      ),
                    ),

                  ],
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'المكتمل: $completedCount من $totalCount',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: ApiColor.neutral.withOpacity(0.7),
                              ),
                            ),
                            Text(
                              '${(progressValue * 100).toInt()}%',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: ApiColor.secondary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: progressValue,
                            minHeight: 8,
                            backgroundColor: ApiColor.tertiary.withOpacity(0.4),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              state.isAllDone ? Colors.green.shade600 : ApiColor.secondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                if (state.isAllDone)
                  SliverToBoxAdapter(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: ApiColor.tertiary.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: ApiColor.secondary.withOpacity(0.5)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.check_circle_rounded, color: ApiColor.primary),
                          const SizedBox(width: 8),
                          Text(
                            'تقبل الله!الحمدلله الذي هدانا لهذا',
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).textTheme.bodyLarge?.color,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) => _ModernAzkarCard(
                        item: state.category.items[index],
                        remaining: state.progress[index] ?? 0,
                        onTap: () => context.read<AzkarCubit>().decrementItem(index),
                      ),
                      childCount: state.category.items.length,
                    ),
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _ModernAzkarCard extends StatelessWidget {
  final AzkarItem item;
  final int remaining;
  final VoidCallback onTap;

  const _ModernAzkarCard({
    required this.item,
    required this.remaining,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final done = remaining == 0;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: done
            ? ApiColor.tertiary.withOpacity(0.2)
            : Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: done ? ApiColor.secondary.withOpacity(0.5) : ApiColor.tertiary.withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: ApiColor.neutral.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: done ? null : onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                Text(
                  item.text,
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontSize: 18,
                    height: 1.8,
                    fontWeight: FontWeight.w600,
                    color: done
                        ?  Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.5)
                        : Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),

                if (item.description.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: ApiColor.tertiary.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      item.description,
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.5,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    transitionBuilder: (child, anim) => ScaleTransition(scale: anim, child: child),
                    child: done
                        ? Container(
                      key: const ValueKey('done'),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: ApiColor.secondary,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.check, size: 18, color: ApiColor.tertiary),
                          const SizedBox(width: 6),
                          Text(
                            'تم',
                            style: TextStyle(
                              color: ApiColor.tertiary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                        : Container(
                      key: ValueKey('counter_$remaining'),
                      height: 46,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            ApiColor.primary,
                            ApiColor.primary.withOpacity(0.85),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: ApiColor.primary.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if(remaining>1)
                            Text(
                              'تكرار',
                              style: TextStyle(
                                color: ApiColor.tertiary.withOpacity(0.8),
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '$remaining',
                              style: TextStyle(
                                color: ApiColor.tertiary,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
