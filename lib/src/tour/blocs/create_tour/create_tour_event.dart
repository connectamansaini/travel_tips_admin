part of 'create_tour_bloc.dart';

abstract class CreateTourEvent {
  const CreateTourEvent();
}

class TourIdCreated extends CreateTourEvent {}

class TitleChanged extends CreateTourEvent {
  TitleChanged(this.title);

  final String title;
}

class DescriptionChanged extends CreateTourEvent {
  DescriptionChanged(this.description);

  final String description;
}

class PriceChanged extends CreateTourEvent {
  PriceChanged(this.price);

  final double price;
}

class DayItineraryAdded extends CreateTourEvent {
  DayItineraryAdded(this.dayItinerary);

  final String dayItinerary;
}

class DayItineraryRemoved extends CreateTourEvent {
  DayItineraryRemoved(this.dayItinerary);

  final String dayItinerary;
}

class CityAdded extends CreateTourEvent {
  CityAdded(this.city);

  final String city;
}

class CityRemoved extends CreateTourEvent {
  CityRemoved(this.city);

  final String city;
}

class ImageUploaded extends CreateTourEvent {
  ImageUploaded({
    required this.file,
  });
  File file;
}

class DataUploaded extends CreateTourEvent {}
