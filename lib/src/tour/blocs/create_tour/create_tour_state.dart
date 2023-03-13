part of 'create_tour_bloc.dart';

class CreateTourState {
  const CreateTourState({
    this.tour = Tour.empty,
    this.imageUploadStatus = const StatusInitial(),
    this.tourUploadStatus = const StatusInitial(),
  });

  final Tour tour;
  final Status imageUploadStatus;
  final Status tourUploadStatus;

  CreateTourState copyWith({
    Tour? tour,
    Status? imageUploadStatus,
    Status? tourUploadStatus,
  }) {
    return CreateTourState(
      tour: tour ?? this.tour,
      imageUploadStatus: imageUploadStatus ?? this.imageUploadStatus,
      tourUploadStatus: tourUploadStatus ?? this.tourUploadStatus,
    );
  }
}
