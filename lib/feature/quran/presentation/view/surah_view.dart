import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constant/api_color.dart';
import '../../data/cubit/quran_cubit.dart';
import '../../data/cubit/quran_states.dart';

class SurahView extends StatelessWidget {
  final int surahId;

  const SurahView({super.key, required this.surahId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => QuranCubit()..loadSurah(surahId),
      child: const _SurahView(),
    );
  }
}

class _SurahView extends StatelessWidget {
  const _SurahView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: BlocBuilder<QuranCubit, QuranState>(
        builder: (context, state) {
          if (state is QuranLoading || state is QuranInitial) {
            return Center(
              child: CircularProgressIndicator.adaptive(
                valueColor: AlwaysStoppedAnimation<Color>(ApiColor.primary),
              ),
            );
          }

          if (state is QuranError) {
            return Center(
              child: Text(
                state.message,
                textDirection: TextDirection.rtl,
                style: const TextStyle(fontSize: 16, color: Colors.redAccent),
              ),
            );
          }

          if (state is QuranSurahLoaded) {
            final surah = state.surah;

            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  expandedHeight: 110.0,
                  floating: false,
                  pinned: true,
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  leading: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    decoration: BoxDecoration(
                      color:  Theme.of(context).colorScheme.surface.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
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
                      titlePadding: const EdgeInsetsDirectional.only(
                        start: 56,
                        end: 56,
                        bottom: 16,
                      ),
                      centerTitle: true,
                      title: Text(
                        surah.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: ApiColor.tertiary,
                        ),
                      ),
                    ),
                  ),
                ),


                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(16, 20, 16, 12),
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          ApiColor.primary,
                          ApiColor.primary.withOpacity(0.9),
                        ],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                      ),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: ApiColor.neutral.withOpacity(0.08),
                          blurRadius: 15,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: ApiColor.tertiary.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                surah.isMeccan ? 'سورة مكية' : 'سورة مدنية',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: ApiColor.tertiary,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '•',
                              style: TextStyle(color: ApiColor.secondary, fontSize: 16),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: ApiColor.tertiary.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '${surah.totalVerses} آية',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: ApiColor.tertiary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (surah.id != 9) ...[
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: ApiColor.secondary.withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              'بِسْمِ اللهِ الرَّحْمٰنِ الرَّحِيمِ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: ApiColor.tertiary,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),

                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                  sliver: SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: ApiColor.tertiary.withOpacity(0.5),
                          width: 1.2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: RichText(
                        textAlign: TextAlign.justify,
                        textDirection: TextDirection.rtl,
                        text: TextSpan(
                          children: surah.verses.expand((ayah) {
                            return [

                              TextSpan(
                                text: '${ayah.text} ',
                                style: TextStyle(
                                  fontSize: 22,
                                  height: 2.3,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).textTheme.bodyLarge?.color,
                                ),
                              ),

                              // زُخرفة رقم الآية
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 4),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: ApiColor.tertiary.withOpacity(0.25),
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: ApiColor.secondary,
                                        width: 1,
                                      ),
                                    ),
                                    child: Text(
                                      '﴿${ayah.id}﴾',
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: ApiColor.neutral,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const TextSpan(text: ' '),
                            ];
                          }).toList(),
                        ),
                      ),
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