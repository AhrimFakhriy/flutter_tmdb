import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'genre.g.dart';

@JsonSerializable()
class Genre with EquatableMixin {
  final int id;
  final String name;

  Genre({
    this.id,
    this.name
  });

  factory Genre.fromJson(Map<String, dynamic> json) =>
    _$GenreFromJson(json);

  @override
  List<Object> get props => [id, name];

  @override
  bool get stringify => true;
}