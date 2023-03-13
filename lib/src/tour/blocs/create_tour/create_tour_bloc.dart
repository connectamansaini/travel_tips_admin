import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:travel_tips_admin/src/core/domain/status.dart';
import 'package:travel_tips_admin/src/tour/models/tour.dart';
import 'package:travel_tips_admin/src/tour/repository/tour_repository.dart';
import 'package:uuid/uuid.dart';

part 'create_tour_event.dart';
part 'create_tour_state.dart';

class CreateTourBloc extends Bloc<CreateTourEvent, CreateTourState> {
  CreateTourBloc(this.tourRepository) : super(const CreateTourState()) {
    on<TourIdCreated>(_onTourIdCreated);
    on<TitleChanged>(_onTitleChanged);
    on<DescriptionChanged>(_onDescriptionChanged);
    on<PriceChanged>(_onPriceChanged);
    on<DayItineraryAdded>(_onDaysItineraryAdded);
    on<DayItineraryRemoved>(_onDayItineraryRemoved);
    on<CityAdded>(_onCityAdded);
    on<CityRemoved>(_onCityRemoved);
    on<ImageUploaded>(_onImageUploaded);
    on<DataUploaded>(_onDataUploaded);
  }
  final TourRepository tourRepository;

  void _onTourIdCreated(TourIdCreated event, Emitter<CreateTourState> emit) {
    final id = const Uuid().v4();
    emit(state.copyWith(tour: state.tour.copyWith(id: id)));
  }

  void _onTitleChanged(TitleChanged event, Emitter<CreateTourState> emit) {
    emit(state.copyWith(tour: state.tour.copyWith(title: event.title)));
  }

  void _onDescriptionChanged(
    DescriptionChanged event,
    Emitter<CreateTourState> emit,
  ) {
    emit(
      state.copyWith(
        tour: state.tour.copyWith(description: event.description),
      ),
    );
  }

  void _onPriceChanged(PriceChanged event, Emitter<CreateTourState> emit) {
    emit(
      state.copyWith(
        tour: state.tour.copyWith(price: event.price),
      ),
    );
  }

  void _onDaysItineraryAdded(
    DayItineraryAdded event,
    Emitter<CreateTourState> emit,
  ) {
    emit(
      state.copyWith(
        tour: state.tour.copyWith(
          daysItinerary: List.of(state.tour.daysItinerary)
            ..add(event.dayItinerary),
        ),
      ),
    );
  }

  void _onDayItineraryRemoved(
      DayItineraryRemoved event, Emitter<CreateTourState> emit) {
    emit(
      state.copyWith(
        tour: state.tour.copyWith(
          daysItinerary: List.of(state.tour.daysItinerary)
            ..remove(event.dayItinerary),
        ),
      ),
    );
  }

  void _onCityAdded(
    CityAdded event,
    Emitter<CreateTourState> emit,
  ) {
    emit(
      state.copyWith(
        tour: state.tour.copyWith(
          cities: List.of(state.tour.cities)..add(event.city),
        ),
      ),
    );
  }

  void _onCityRemoved(
    CityRemoved event,
    Emitter<CreateTourState> emit,
  ) {
    emit(
      state.copyWith(
        tour: state.tour.copyWith(
          cities: List.of(state.tour.cities)..remove(event.city),
        ),
      ),
    );
  }

  Future<void> _onImageUploaded(
    ImageUploaded event,
    Emitter<CreateTourState> emit,
  ) async {
    try {
      emit(state.copyWith(imageUploadStatus: Status.loading()));
      final titleImageUrl =
          await tourRepository.uploadImage(event.file, state.tour.id);
      emit(
        state.copyWith(
          tour: state.tour.copyWith(titleImageUrl: titleImageUrl),
          imageUploadStatus: Status.success(),
        ),
      );
    } on Failure catch (f) {
      emit(state.copyWith(imageUploadStatus: Status.failure(f)));
    }
  }

  Future<void> _onDataUploaded(
    DataUploaded event,
    Emitter<CreateTourState> emit,
  ) async {
    try {
      emit(state.copyWith(tourUploadStatus: Status.loading()));
      await tourRepository.addData(state.tour);
      emit(state.copyWith(tourUploadStatus: Status.success()));
    } on Failure catch (f) {
      emit(state.copyWith(tourUploadStatus: Status.failure(f)));
    }
  }
}
