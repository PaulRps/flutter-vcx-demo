import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vcx_demo/src/data/dtos/aries_request_proof_attribute.dto.dart';
import 'package:flutter_vcx_demo/src/domain/use_cases/prover_present_proof_request.usecase.dart';
import 'package:flutter_vcx_demo/src/domain/use_cases/prover_reject_proof_request.usecase.dart';
import 'package:flutter_vcx_demo/src/domain/use_cases/retrieve_aries_connection_data.usecase.dart';
import 'package:flutter_vcx_demo/src/domain/use_cases/verifier_send_proof_request.usecase.dart';

import 'proof_page.state.dart';

class ProofPageCubit extends Cubit<ProofPageState> {
  ProofPageCubit(
      this._presentProofRequestUseCase, this._rejectProofRequestUseCase)
      : super(ProofPageState.initial());

  late final ProverPresentProofRequestUseCase _presentProofRequestUseCase;
  late final ProverRejectProofRequestUseCase _rejectProofRequestUseCase;
  late final VerifierSendProofRequestUseCase _sendProofRequest;
  late final RetrieveAriesConnectionDataUseCase _connectionDataUsecase;

  void presentProof() {
    try {
      _presentProofRequestUseCase.presentProof().then((isSuccess) {
        emit(isSuccess
            ? ProofPageState.presentedProofRequest()
            : ProofPageState.error(message: "Could not present proof"));
      }).catchError((error) {
        emit(ProofPageState.error(message: error.toString()));
      });
    } catch (e) {
      emit(ProofPageState.error(message: e.toString()));
    }
  }

  void rejectProof() {
    try {
      _rejectProofRequestUseCase.reject().then((isSuccess) {
        emit(isSuccess
            ? ProofPageState.rejectedProofRequest()
            : ProofPageState.error(message: "Could not reject proof"));
      }).catchError((error) {
        emit(ProofPageState.error(message: error.toString()));
      });
    } catch (e) {
      emit(ProofPageState.error(message: e.toString()));
    }
  }

  void getConnectionsData() {
    try {
      _connectionDataUsecase
          .getConnectionsData()
          .then((value) =>
              emit(ProofPageState.getConnectionsData(connections: value)))
          .catchError((error) {
        emit(ProofPageState.error(message: error.toString()));
      });
    } catch (e) {
      emit(ProofPageState.error(message: e.toString()));
    }
  }

  void sendProofRequest(
      {required String pairwiseDid,
      required List<AriesRequestedProofAttributeDto> requestedAttributes}) {
    _sendProofRequest
        .sendRequest(
        sourceId: "flutter_vcx_demo",
        pairwiseDid: pairwiseDid,
        requestedAttributes: requestedAttributes)
        .then((value) {
          emit(ProofPageState.verifierGotProofAttributes(proofData: value));
          emit(ProofPageState.stopWaitProverPresentProof());
    }).catchError((error, stack) {
      emit(ProofPageState.error(message: error.toString()));
      emit(ProofPageState.stopWaitProverPresentProof());
      // FlutterError.reportError(FlutterErrorDetails(
      //     exception: error,
      //     library: 'Flutter Vcx Demo',
      //     context: ErrorSummary('while running async send proof request'),
      //     stack: stack));
    });
  }
}
