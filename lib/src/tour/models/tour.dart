import 'package:json_annotation/json_annotation.dart';

part 'tour.g.dart';

@JsonSerializable()
class Tour {
  const Tour({
    this.id = '',
    this.title = '',
    this.description = '',
    this.titleImageUrl = '',
    this.cities = const [],
    this.price = 0,
    this.daysItinerary = const [],
  });

  factory Tour.fromJson(Map<String, dynamic> json) => _$TourFromJson(json);
  Map<String, dynamic> toJson() => _$TourToJson(this);

  final String id;
  final String title;
  final String description;
  final String titleImageUrl;
  final List<String> cities;
  final double price;
  final List<String> daysItinerary;

  static const empty = Tour();

  Tour copyWith({
    String? id,
    String? title,
    String? description,
    String? titleImageUrl,
    List<String>? cities,
    double? price,
    List<String>? daysItinerary,
  }) {
    return Tour(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      titleImageUrl: titleImageUrl ?? this.titleImageUrl,
      cities: cities ?? this.cities,
      price: price ?? this.price,
      daysItinerary: daysItinerary ?? this.daysItinerary,
    );
  }
}
