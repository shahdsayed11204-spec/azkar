import 'package:azkar/feature/quran/data/cubit/quran_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/quran_service.dart';

class QuranCubit extends Cubit<QuranState> {
  QuranCubit() : super(QuranInitial());

  Future<void> loadAllSurahs() async {
    emit(QuranLoading());
    try {
      final surahs = await QuranService.loadAll();
      emit(QuranListLoaded(surahs));
    } catch (e) {
      emit(QuranError('حصل خطأ أثناء تحميل القرآن: $e'));
    }
  }

  Future<void> loadSurah(int id) async {
    emit(QuranLoading());
    try {
      final surah = await QuranService.loadById(id);
      if (surah == null) {
        emit(const QuranError('السورة غير موجودة'));
      } else {
        emit(QuranSurahLoaded(surah));
      }
    } catch (e) {
      emit(QuranError('حصل خطأ أثناء تحميل السورة: $e'));
    }
  }
}