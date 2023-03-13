part of 'cities_bloc.dart';

abstract class CitiesEvent {
  const CitiesEvent();
}

class CitiesRequested extends CitiesEvent {}

class CitySearched extends CitiesEvent {
  CitySearched(this.query);

  final String query;
}
