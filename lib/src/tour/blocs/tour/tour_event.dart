part of 'tour_bloc.dart';

abstract class TourEvent {
  const TourEvent();
}

class TourRequested extends TourEvent {}

class TourAdded extends TourEvent {
  TourAdded(this.tour);

  final Tour tour;
}

class TourDeleted extends TourEvent {
  TourDeleted(this.tour);

  final Tour tour;
}
