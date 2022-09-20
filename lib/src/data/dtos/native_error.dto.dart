import 'package:json_annotation/json_annotation.dart';

part 'native_error.dto.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class NativeErrorDto {
  String id;
  String message;

  NativeErrorDto(this.id, this.message);

  factory NativeErrorDto.fromJson(Map json) =>
      _$NativeErrorDtoFromJson(json);

  Map<String, dynamic> toJson() => _$NativeErrorDtoToJson(this);
}