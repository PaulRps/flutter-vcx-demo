// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'native_to_flutter_response.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NativeToFlutterResponseDto _$NativeToFlutterResponseDtoFromJson(Map json) =>
    NativeToFlutterResponseDto(
      json['success'] as bool,
      errorMessage: json['errorMessage'],
    );

Map<String, dynamic> _$NativeToFlutterResponseDtoToJson(
        NativeToFlutterResponseDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'errorMessage': instance.errorMessage?.toJson(),
    };
