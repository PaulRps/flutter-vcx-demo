import 'package:flutter_vcx_demo/src/data/datasources/aries_proof.datasource.dart';
import 'package:flutter_vcx_demo/src/data/dtos/flutter_request_aries_proof_channel.dto.dart';
import 'package:flutter_vcx_demo/src/data/dtos/native_to_flutter_response.dto.dart';

abstract class IAriesProofRepository {
  Future<NativeToFlutterResponseDto> presentProof(
      FlutterRequestAriesProofChannelDto dto);
}

class AriesProofRepository implements IAriesProofRepository {
  late final IAriesProofDatasource _ariesProofDatasource;

  AriesProofRepository({ariesProofDatasource})
      : _ariesProofDatasource = ariesProofDatasource ?? AriesProofDatasource();

  @override
  Future<NativeToFlutterResponseDto> presentProof(
      FlutterRequestAriesProofChannelDto dto) {
    return _ariesProofDatasource
        .presentProof(dto)
        .then((value) => NativeToFlutterResponseDto(true))
        .catchError((error) => NativeToFlutterResponseDto(false));
  }
}
