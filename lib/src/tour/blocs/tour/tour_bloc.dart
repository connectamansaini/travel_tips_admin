import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:travel_tips_admin/src/core/domain/status.dart';
import 'package:travel_tips_admin/src/tour/models/tour.dart';
import 'package:travel_tips_admin/src/tour/repository/tour_repository.dart';

part 'tour_event.dart';
part 'tour_state.dart';

class TourBloc extends Bloc<TourEvent, TourState> {
  TourBloc(this.tourRepository) : super(const TourState()) {
    on<TourAdded>(_onTourAdded);
    on<TourRequested>(_onTourRequested);
    on<TourDeleted>(_onTourDeleted);
  }
  final TourRepository tourRepository;

  void _onTourAdded(TourAdded event, Emitter<TourState> emit) {
    emit(state.copyWith(tours: List.of(state.tours)..add(event.tour)));
  }

  Future<void> _onTourDeleted(
      TourDeleted event, Emitter<TourState> emit,) async {
    try {
      emit(state.copyWith(tourDeleteStatus: Status.loading()));
      await tourRepository.deleteTour(event.tour.id);
      emit(state.copyWith(tours: List.of(state.tours)..remove(event.tour)));
      emit(state.copyWith(tourDeleteStatus: Status.success()));
    } on Failure catch (f) {
      emit(state.copyWith(tourDeleteStatus: Status.failure(f)));
    }
  }

  Future<void> _onTourRequested(
    TourRequested event,
    Emitter<TourState> emit,
  ) async {
    try {
      emit(state.copyWith(toursStatus: Status.loading()));
      final tours = await tourRepository.getTours();
      emit(state.copyWith(tours: tours, toursStatus: Status.success()));
    } catch (e) {
      emit(state.copyWith(toursStatus: Status.failure()));
    }
  }
}
