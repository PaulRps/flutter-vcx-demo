import 'package:json_annotation/json_annotation.dart';

part 'aries_open_pool_config.dto.g.dart';

@JsonSerializable(explicitToJson: true)
class AriesOpenPoolConfigDto {
  String? genesisPath;

  String? poolName;

  String? poolConfig;

  AriesOpenPoolConfigDto(this.genesisPath, this.poolName, this.poolConfig);

  AriesOpenPoolConfigDto.from(this.genesisPath)
      : poolName = "flutter_vcx_demo",
        poolConfig = null;

  factory AriesOpenPoolConfigDto.fromJson(Map<String, dynamic> json) =>
      _$AriesOpenPoolConfigDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AriesOpenPoolConfigDtoToJson(this);
}
