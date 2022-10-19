import '../../data/dtos/flutter_request_aries_proof_channel.dto.dart';
import '../../data/repositories/aries_connection.repository.dart';
import '../../data/repositories/aries_proof.repository.dart';

class RejectProofRequestUsecase {
  late final AriesProofRepository _ariesProofRepository;
  late final AriesConnectionRepository _ariesConnectionRepository;

  RejectProofRequestUsecase({ariesProofRepository, ariesConnectionRepository})
      : _ariesProofRepository =
            ariesConnectionRepository ?? AriesProofRepository(),
        _ariesConnectionRepository =
            ariesConnectionRepository ?? AriesConnectionRepository();

  Future<bool> reject() {
    return _ariesConnectionRepository.getConnectionData().then((connection) {
      var dto = FlutterRequestAriesProofChannelDto(
          connection.pairwiseDid, "flutterVcxDemo",
          proofMessage:
          "{\"@type\":\"did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/present-proof/1.0/request-presentation\",\"@id\":\"320633b5-fd20-4283-b916-22d2eb64bcee\",\"request_presentations~attach\":[{\"@id\":\"libindy-request-presentation-0\",\"mime-type\":\"application/json\",\"data\":{\"base64\":\"eyJuYW1lIjogInRlc3RlIHJlcXVlc3QgcHJvb2YiLCAicmVxdWVzdGVkX2F0dHJpYnV0ZXMiOiB7IjBfY3BmX3V1aWQiOiB7Im5hbWUiOiAiY3BmIiwgInJlc3RyaWN0aW9ucyI6IFt7InNjaGVtYV9pZCI6ICJIYTJER2VuVWNnRHEydDgxVWg3WG13OjI6Y25oLXNjaGVtYTozLjAifV19fSwgInJlcXVlc3RlZF9wcmVkaWNhdGVzIjoge30sICJ2ZXJzaW9uIjogIjAuMSIsICJub25jZSI6ICIxMDc5NzAzODcxMDU0NTc2NjA3MjQ3NTcyIn0=\"}}],\"comment\":\"teste request proof\",\"~service\":{\"recipientKeys\":[\"A2nmMv554jTJPC3vLBVh1LE34u4TdSPqkZyBd5Bevoeg\"],\"routingKeys\":null,\"serviceEndpoint\":\"https://f950-2804-26e8-5006-9201-a926-d039-7d79-ec5f.sa.ngrok.io\"}}");

      return _ariesProofRepository
          .rejectProof(dto)
          .then((value) => value.success);
    });
  }
}
