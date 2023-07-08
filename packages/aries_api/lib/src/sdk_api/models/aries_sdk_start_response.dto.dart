import 'package:aries_api/aries_api.dart';
import 'package:json_annotation/json_annotation.dart';

part 'aries_sdk_start_response.dto.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class AriesSdkStartResponse extends NativeToFlutterResponseDto {
  String? agentDid;

  AriesSdkStartResponse(bool success, {errorMessage, this.agentDid})
      : super(success, errorMessage: errorMessage);

  factory AriesSdkStartResponse.fromJson(Map json) =>
      _$AriesSdkStartResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AriesSdkStartResponseToJson(this);
}
