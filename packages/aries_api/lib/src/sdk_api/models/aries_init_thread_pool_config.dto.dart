import 'package:json_annotation/json_annotation.dart';

part 'aries_init_thread_pool_config.dto.g.dart';

@JsonSerializable(explicitToJson: true)
class AriesInitThreadPoolConfigDto {
  int? numThreads;

  AriesInitThreadPoolConfigDto({numThreads = null})
      : this.numThreads = numThreads;

  factory AriesInitThreadPoolConfigDto.fromJson(Map<String, dynamic> json) =>
      _$AriesInitThreadPoolConfigDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AriesInitThreadPoolConfigDtoToJson(this);
}
