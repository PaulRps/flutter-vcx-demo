import 'package:flutter_vcx_demo/src/data/datasources/aries_proof.datasource.dart';
import 'package:flutter_vcx_demo/src/data/dtos/aries_send_proof_response.dto.dart';
import 'package:flutter_vcx_demo/src/data/dtos/flutter_request_aries_proof_channel.dto.dart';
import 'package:flutter_vcx_demo/src/data/dtos/native_to_flutter_response.dto.dart';
import 'package:injectable/injectable.dart';

abstract class IAriesProofRepository {
  Future<NativeToFlutterResponseDto> presentProof(
      FlutterRequestAriesProofChannelDto dto);

  Future<NativeToFlutterResponseDto> rejectProof(
      FlutterRequestAriesProofChannelDto dto);

  Future<AriesSendProofResponseDto> sendProofRequest(
      FlutterRequestAriesProofChannelDto dto);
}

@LazySingleton(as: IAriesProofRepository)
class AriesProofRepository implements IAriesProofRepository {
  late final IAriesProofDatasource _ariesProofDatasource;

  AriesProofRepository(this._ariesProofDatasource);

  @override
  Future<NativeToFlutterResponseDto> presentProof(
      FlutterRequestAriesProofChannelDto dto) {
    return _ariesProofDatasource
        .presentProof(dto)
        .then((value) => NativeToFlutterResponseDto(true))
        .catchError((error) => NativeToFlutterResponseDto(false));
  }

  @override
  Future<NativeToFlutterResponseDto> rejectProof(
      FlutterRequestAriesProofChannelDto dto) {
    return _ariesProofDatasource
        .rejectProof(dto)
        .then((value) => NativeToFlutterResponseDto(true))
        .catchError((error) => NativeToFlutterResponseDto(false));
  }

  @override
  Future<AriesSendProofResponseDto> sendProofRequest(
      FlutterRequestAriesProofChannelDto dto) {
    return _ariesProofDatasource
        .sendProofRequest(dto)
        .then((value) => AriesSendProofResponseDto.fromJson(value));
  }
}
