import 'package:json_annotation/json_annotation.dart';

part 'connection_data.dto.g.dart';

@JsonSerializable()
class ConnectionDataDto {
  static const String CONNECTION_REF = "connection_data_ref";

  String? pairwiseDto;
  String? connectionName;

  ConnectionDataDto(this.pairwiseDto, this.connectionName);

  factory ConnectionDataDto.fromJson(Map<String, dynamic> json) =>
      _$ConnectionDataDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ConnectionDataDtoToJson(this);
}
