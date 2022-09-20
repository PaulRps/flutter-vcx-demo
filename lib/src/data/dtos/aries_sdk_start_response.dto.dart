import 'package:flutter_vcx_demo/src/data/dtos/native_to_flutter_response.dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'aries_sdk_start_response.dto.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class AriesSdkStartResponse extends NativeToFlutterResponseDto {
  String? agentDid;

  AriesSdkStartResponse(bool success, {errorMessage, agentDid})
      : super(success, errorMessage: errorMessage) {
    this.agentDid = agentDid;
  }

  factory AriesSdkStartResponse.fromJson(Map json) =>
      _$AriesSdkStartResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AriesSdkStartResponseToJson(this);
}
