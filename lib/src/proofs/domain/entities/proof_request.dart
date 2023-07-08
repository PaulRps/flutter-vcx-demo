class ProofRequest {
  String sourceId;
  String pairwiseDid;
  List<RequestedAttribute>? requestedAttributes;
  String? proofName;

  ProofRequest(
      {required this.sourceId,
      required this.pairwiseDid,
      this.requestedAttributes,
      this.proofName});
}

class RequestedAttribute {
  String name;
  String schemaName;
  String schemaVersion;

  RequestedAttribute(
      {required this.name,
      required this.schemaName,
      required this.schemaVersion});
}
