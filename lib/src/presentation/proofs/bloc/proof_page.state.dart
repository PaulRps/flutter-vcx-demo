import 'package:flutter_vcx_demo/src/data/dtos/aries_send_proof_response.dto.dart';
import 'package:flutter_vcx_demo/src/domain/entities/connection_data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'proof_page.state.freezed.dart';

@freezed
class ProofPageState with _$ProofPageState {
  factory ProofPageState.initial() = ProofPageStateInitial;

  factory ProofPageState.error({required String message}) = ProofPageError;

  factory ProofPageState.presentedProofRequest() =
      ProofPagePresentedProofRequest;

  factory ProofPageState.rejectedProofRequest() = ProofPageRejectedProofRequest;

  factory ProofPageState.getConnectionsData(
          {@Default([]) List<ConnectionData> connections}) =
      ProofStateGetConnectionsData;

  factory ProofPageState.startWaitProverPresentProof() =
      ProofPageStartWaitProverPresentProof;

  factory ProofPageState.stopWaitProverPresentProof() =
      ProofPageStopWaitProverPresentProof;

  factory ProofPageState.verifierGotProofAttributes(
          {required AriesSendProofResponseDto proofData}) =
      ProofPageVerifierGotProofAttributes;
}
