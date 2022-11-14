import 'package:flutter_vcx_demo/src/data/dtos/aries_create_connection_response.dto.dart';
import 'package:flutter_vcx_demo/src/data/dtos/flutter_request_aries_connection_channel.dto.dart';
import 'package:flutter_vcx_demo/src/data/services/aries_connection.service.dart';

import '../dtos/aries_connection_invitation_response.dto.dart';
import '../services/aries_connection_url_parser.service.dart';

abstract class IAriesConnectionDatasource {
  Future<AriesCreateConnectionResponseDto> createConnection(
      String connectionUrl, String inviteId);

  Future<AriesConnectionInvitationResponseDto> createConnectionInvitation();

  Future<AriesCreateConnectionResponseDto> checkConnectionInvitation(
      String connectionHandle, bool isToDeleteHandle);
}

class AriesConnectionDatasource implements IAriesConnectionDatasource {
  late final IAriesConnectionService _ariesConnectionService;
  late final IAriesConnectionUrlParserService _ariesConnectionUrlParserService;

  AriesConnectionDatasource(
      {ariesConnectionService, ariesConnectionUrlParserService})
      : _ariesConnectionService =
            ariesConnectionService ?? AriesConnectionService(),
        _ariesConnectionUrlParserService =
            ariesConnectionUrlParserService ?? AriesConnectionParserService();

  @override
  Future<AriesCreateConnectionResponseDto> createConnection(
      String connectionUrl, String inviteId) {
    if (inviteId.isEmpty) return Future.error("connection id is required");

    if (connectionUrl.isEmpty)
      return Future.error("connection url is required");

    var invitation = _ariesConnectionUrlParserService.parse(connectionUrl);
    if (invitation == null) return Future.error("connection url is invalid");

    var dto = FlutterRequestAriesConnectionChannelDto(
        invitation: invitation, inviteId: inviteId);

    return _ariesConnectionService
        .createConnection(dto)
        .then((value) => AriesCreateConnectionResponseDto.fromJson(value));
  }

  @override
  Future<AriesCreateConnectionResponseDto> checkConnectionInvitation(
      String connectionHandle, bool isToDeleteHandle) {
    return _ariesConnectionService
        .checkConnectionInvitation(FlutterRequestAriesConnectionChannelDto(
            connectionHandle: connectionHandle,
            isToDeleteHandle: isToDeleteHandle))
        .then((value) => AriesCreateConnectionResponseDto.fromJson(value));
  }

  @override
  Future<AriesConnectionInvitationResponseDto> createConnectionInvitation() {
    return _ariesConnectionService
        .createConnectionInvitation()
        .then((value) => AriesConnectionInvitationResponseDto.fromJson(value));
  }
}
