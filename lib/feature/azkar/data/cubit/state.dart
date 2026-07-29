import 'package:equatable/equatable.dart';

import '../model/azkar_model.dart';

abstract class AzkarState extends Equatable {
  const AzkarState();

  @override
  List<Object?> get props => [];
}

class AzkarInitial extends AzkarState {}

class AzkarLoading extends AzkarState {}

class AzkarLoaded extends AzkarState {
  final AzkarCategory category;
  final Map<int, int> progress; // index الذكر -> العدد المتبقي

  const AzkarLoaded(this.category, this.progress);

  bool get isAllDone => progress.values.every((v) => v == 0);

  AzkarLoaded copyWith({Map<int, int>? progress}) {
    return AzkarLoaded(category, progress ?? this.progress);
  }

  @override
  List<Object?> get props => [category, progress];
}

class AzkarError extends AzkarState {
  final String message;

  const AzkarError(this.message);

  @override
  List<Object?> get props => [message];
}

// اختياري: لو حابب تجيب كل الأقسام مرة واحدة (مثلاً لشاشة رئيسية فيها قايمة الأقسام)
class AzkarListLoaded extends AzkarState {
  final List<AzkarCategory> categories;

  const AzkarListLoaded(this.categories);

  @override
  List<Object?> get props => [categories];
}


