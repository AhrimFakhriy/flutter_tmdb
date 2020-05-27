import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

class BaseResponse with EquatableMixin {
  @JsonKey(ignore: true)
  String path;

  int page;
  
  @JsonKey(name: "total_results")
  int totalResults;

  @JsonKey(name: "total_pages")
  int totalPages;

  BaseResponse({
    this.page,
    this.totalPages,
    this.totalResults,
  });

  @override
  List<Object> get props => [page, totalResults, totalPages];

  @override
  bool get stringify => true;
}