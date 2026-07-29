import 'package:azkar/feature/azkar/data/cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/azkar_service.dart';
import '../../../../core/utils/azkar_progress_service.dart';




class AzkarCubit extends Cubit<AzkarState> {
  AzkarCubit() : super(AzkarInitial());

  // تحميل قسم واحد بالاسم، زي "أذكار الصباح"، مع تحميل التقدم المحفوظ
  Future<void> loadCategory(String title) async {
    emit(AzkarLoading());
    try {
      final category = await AzkarService.loadByTitle(title);
      if (category == null) {
        emit(const AzkarError('القسم غير موجود'));
        return;
      }

      final defaultRepeats = category.items.map((e) => e.repeat).toList();
      final progress = await AzkarProgressService.loadProgress(
        categoryTitle: title,
        defaultRepeats: defaultRepeats,
      );

      emit(AzkarLoaded(category, progress));
    } catch (e) {
      emit(AzkarError('حصل خطأ أثناء تحميل الأذكار: $e'));
    }
  }

  // بتنقص واحد من عداد الذكر رقم index، وتحفظ التقدم فوراً
  Future<void> decrementItem(int index) async {
    final current = state;
    if (current is! AzkarLoaded) return;

    final remaining = current.progress[index] ?? 0;
    if (remaining <= 0) return;

    final newProgress = Map<int, int>.from(current.progress);
    newProgress[index] = remaining - 1;

    emit(current.copyWith(progress: newProgress));

    await AzkarProgressService.saveProgress(
      categoryTitle: current.category.title,
      progress: newProgress,
    );
  }

  // زرار "ابدأ من جديد" لو حابب تصفّر التقدم يدوياً
  Future<void> resetProgress() async {
    final current = state;
    if (current is! AzkarLoaded) return;

    final defaultRepeats = current.category.items.map((e) => e.repeat).toList();
    await AzkarProgressService.resetProgress(
      categoryTitle: current.category.title,
      defaultRepeats: defaultRepeats,
    );

    final resetMap = {for (var i = 0; i < defaultRepeats.length; i++) i: defaultRepeats[i]};
    emit(current.copyWith(progress: resetMap));
  }

  // تحميل كل الأقسام مرة واحدة (مفيد لشاشة رئيسية بها قايمة الأقسام)
  Future<void> loadAllCategories() async {
    emit(AzkarLoading());
    try {
      final categories = await AzkarService.loadAll();
      emit(AzkarListLoaded(categories));
    } catch (e) {
      emit(AzkarError('حصل خطأ أثناء تحميل الأقسام: $e'));
    }
  }

}