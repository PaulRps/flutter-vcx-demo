import 'package:json_annotation/json_annotation.dart';

import '../../native_error.dto.dart';
import '../../native_to_flutter_response.dto.dart';

part 'aries_connection_invitation_response.dto.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class AriesConnectionInvitationResponseDto extends NativeToFlutterResponseDto {
  String? invitation;
  String? connectionHandle;

  AriesConnectionInvitationResponseDto(this.invitation, this.connectionHandle,
      bool success, NativeErrorDto? errorMessage)
      : super(success, errorMessage: errorMessage);

  factory AriesConnectionInvitationResponseDto.fromJson(Map json) =>
      _$AriesConnectionInvitationResponseDtoFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AriesConnectionInvitationResponseDtoToJson(this);
}
