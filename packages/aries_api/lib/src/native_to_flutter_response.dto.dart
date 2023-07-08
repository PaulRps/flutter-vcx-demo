import 'package:json_annotation/json_annotation.dart';

import 'native_error.dto.dart';

part 'native_to_flutter_response.dto.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class NativeToFlutterResponseDto {
  bool success;
  NativeErrorDto? errorMessage;

  NativeToFlutterResponseDto(this.success, {this.errorMessage});

  factory NativeToFlutterResponseDto.fromJson(Map json) =>
      _$NativeToFlutterResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$NativeToFlutterResponseDtoToJson(this);
}
