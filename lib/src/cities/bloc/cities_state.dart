part of 'cities_bloc.dart';

class CitiesState {
  const CitiesState({
    this.citiesStatus = const StatusInitial(),
    this.cities = const [],
    this.searchedCities = const [],
  });

  final Status citiesStatus;
  final List<City> cities;
  final List<City> searchedCities;

  CitiesState copyWith({
    Status? citiesStatus,
    List<City>? cities,
    List<City>? searchedCities,
  }) {
    return CitiesState(
      citiesStatus: citiesStatus ?? this.citiesStatus,
      cities: cities ?? this.cities,
      searchedCities: searchedCities ?? this.searchedCities,
    );
  }
}
