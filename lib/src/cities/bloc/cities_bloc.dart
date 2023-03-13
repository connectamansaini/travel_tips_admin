import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:travel_tips_admin/src/cities/model/city.dart';
import 'package:travel_tips_admin/src/cities/repository/cities_repository.dart';
import 'package:travel_tips_admin/src/core/domain/status.dart';

part 'cities_event.dart';
part 'cities_state.dart';

class CitiesBloc extends Bloc<CitiesEvent, CitiesState> {
  CitiesBloc(this.cityRepository) : super(const CitiesState()) {
    on<CitiesRequested>(_onCitiesRequested);
    on<CitySearched>(_onCitySearched);
  }

  final CitiesRepository cityRepository;

  Future<void> _onCitiesRequested(
    CitiesRequested event,
    Emitter<CitiesState> emit,
  ) async {
    try {
      emit(state.copyWith(citiesStatus: Status.loading()));
      final cities = await cityRepository.getCities();
      emit(
        state.copyWith(
          citiesStatus: Status.success(),
          cities: cities,
        ),
      );
    } on Failure catch (f) {
      emit(state.copyWith(citiesStatus: Status.failure(f)));
    }
  }

  void _onCitySearched(CitySearched event, Emitter<CitiesState> emit) {
    final searchedCities = List.of(state.cities)
        .where(
          (city) => city.name.toLowerCase().contains(event.query.toLowerCase()),
        )
        .toList();

    emit(state.copyWith(searchedCities: searchedCities));
  }
}
