// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tour.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tour _$TourFromJson(Map<String, dynamic> json) => Tour(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      titleImageUrl: json['titleImageUrl'] as String? ?? '',
      cities: (json['cities'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      price: (json['price'] as num?)?.toDouble() ?? 0,
      daysItinerary: (json['daysItinerary'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$TourToJson(Tour instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'titleImageUrl': instance.titleImageUrl,
      'cities': instance.cities,
      'price': instance.price,
      'daysItinerary': instance.daysItinerary,
    };
