import 'package:json_annotation/json_annotation.dart';

import '../../native_error.dto.dart';
import '../../native_to_flutter_response.dto.dart';

part 'aries_create_connection_response.dto.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class AriesCreateConnectionResponseDto extends NativeToFlutterResponseDto {
  String? pairwiseDid;
  String? connectionName;

  AriesCreateConnectionResponseDto(this.pairwiseDid, this.connectionName,
      bool success, NativeErrorDto? errorMessage)
      : super(success, errorMessage: errorMessage);

  factory AriesCreateConnectionResponseDto.fromJson(Map json) =>
      _$AriesCreateConnectionResponseDtoFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AriesCreateConnectionResponseDtoToJson(this);
}
