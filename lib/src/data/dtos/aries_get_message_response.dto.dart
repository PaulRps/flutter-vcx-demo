import 'package:json_annotation/json_annotation.dart';

import 'native_error.dto.dart';
import 'native_to_flutter_response.dto.dart';

part 'aries_get_message_response.dto.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class AriesGetMessageResponseDto extends NativeToFlutterResponseDto {
  String? msg;
  String? pairwiseDid;

  AriesGetMessageResponseDto(
      this.msg, this.pairwiseDid, bool success, NativeErrorDto? errorMessage)
      : super(success, errorMessage: errorMessage);

  factory AriesGetMessageResponseDto.fromJson(Map json) =>
      _$AriesGetMessageResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AriesGetMessageResponseDtoToJson(this);
}
