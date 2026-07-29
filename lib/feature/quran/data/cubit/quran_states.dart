import 'package:equatable/equatable.dart';

import '../model/quran_model.dart';

abstract class QuranState extends Equatable {
  const QuranState();

  @override
  List<Object?> get props => [];
}

class QuranInitial extends QuranState {}

class QuranLoading extends QuranState {}

class QuranListLoaded extends QuranState {
  final List<Surah> surahs;

  const QuranListLoaded(this.surahs);

  @override
  List<Object?> get props => [surahs];
}

class QuranSurahLoaded extends QuranState {
  final Surah surah;

  const QuranSurahLoaded(this.surah);

  @override
  List<Object?> get props => [surah];
}

class QuranError extends QuranState {
  final String message;

  const QuranError(this.message);

  @override
  List<Object?> get props => [message];
}