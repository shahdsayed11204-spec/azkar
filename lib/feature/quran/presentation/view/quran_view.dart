import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constant/api_color.dart';
import '../../data/cubit/quran_cubit.dart';
import '../../data/cubit/quran_states.dart';
import 'surah_view.dart';

class QuranView extends StatelessWidget {
  const QuranView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => QuranCubit()..loadAllSurahs(),
      child: const _QuranHomeView(),
    );
  }
}

class _QuranHomeView extends StatelessWidget {
  const _QuranHomeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: 120.0,
            floating: false,
            pinned: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
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
                titlePadding: const EdgeInsetsDirectional.only(start: 20, bottom: 18),
                title: Text(
                  'القرآن الكريم',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: ApiColor.tertiary,
                  ),
                ),
              ),
            ),
          ),

          // قائمة السور
          BlocBuilder<QuranCubit, QuranState>(
            builder: (context, state) {
              if (state is QuranLoading || state is QuranInitial) {
                return SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator.adaptive(
                      valueColor: AlwaysStoppedAnimation<Color>(ApiColor.primary),
                    ),
                  ),
                );
              }

              if (state is QuranError) {
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

              if (state is QuranListLoaded) {
                return SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        final surah = state.surahs[index];
                        return _SurahCard(
                          surah: surah,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => SurahView(surahId: surah.id),
                              ),
                            );
                          },
                        );
                      },
                      childCount: state.surahs.length,
                    ),
                  ),
                );
              }

              return const SliverToBoxAdapter(child: SizedBox.shrink());
            },
          ),
        ],
      ),
    );
  }
}

class _SurahCard extends StatelessWidget {
  final dynamic surah;
  final VoidCallback onTap;

  const _SurahCard({
    required this.surah,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: ApiColor.tertiary.withOpacity(0.3),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: ApiColor.neutral.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 16,
                  color: ApiColor.secondary,
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      surah.name,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.85),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${surah.totalVerses} آية',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.5),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: CircleAvatar(
                            radius: 2,
                            backgroundColor: ApiColor.secondary,
                          ),
                        ),
                        Text(
                          surah.isMeccan ? 'مكية' : 'مدنية',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: ApiColor.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Transform.rotate(
                  angle: 0.785398,
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: ApiColor.tertiary.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: ApiColor.secondary.withOpacity(0.5),
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Transform.rotate(
                        angle: -0.785398, // إعادة تعديل الزاوية للرقم
                        child: Text(
                          '${surah.id}',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: ApiColor.primary,
                          ),
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