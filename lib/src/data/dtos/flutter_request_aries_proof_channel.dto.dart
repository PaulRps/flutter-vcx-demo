import 'package:flutter_vcx_demo/src/data/dtos/flutter_request_aries_credential_channel.dto.dart';

class FlutterRequestAriesProofChannelDto
    extends FlutterRequestAriesCredentialChannelDto {
  FlutterRequestAriesProofChannelDto(String? pairwiseDid, String? sourceId)
      : super(pairwiseDid, sourceId);
}
