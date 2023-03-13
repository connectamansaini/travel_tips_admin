import 'package:json_annotation/json_annotation.dart';

part 'city.g.dart';

@JsonSerializable()
class City {
  const City({
    this.id = '',
    this.name = '',
    this.state = '',
  });

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);
  Map<String, dynamic> toJson() => _$CityToJson(this);

  final String id;
  final String name;
  final String state;

  static const empty = City();

  City copyWith({
    String? id,
    String? name,
    String? state,
  }) {
    return City(
      id: id ?? this.id,
      name: name ?? this.name,
      state: state ?? this.state,
    );
  }
}
