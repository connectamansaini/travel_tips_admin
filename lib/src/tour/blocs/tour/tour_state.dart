part of 'tour_bloc.dart';

class TourState {
  const TourState({
    this.toursStatus = const StatusInitial(),
    this.tourDeleteStatus = const StatusInitial(),
    this.tours = const [],
  });

  final Status toursStatus;
  final List<Tour> tours;
  final Status tourDeleteStatus;

  TourState copyWith({
    Status? toursStatus,
    List<Tour>? tours,
    Status? tourDeleteStatus,
  }) {
    return TourState(
      toursStatus: toursStatus ?? this.toursStatus,
      tours: tours ?? this.tours,
      tourDeleteStatus: tourDeleteStatus ?? this.tourDeleteStatus,
    );
  }
}
