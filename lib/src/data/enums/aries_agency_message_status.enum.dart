enum AriesAgencyMessageStatusEnum {
  none,
  created,
  sent,
  received,
  accepted,
  rejected,
  reviewed
}

extension AgencyMessageStatusExt on AriesAgencyMessageStatusEnum {
  AriesAgencyMessageStatusEnum? getOne(String name) {
    return _enumMap[name];
  }

  String? getValue() {
    return _enumMapValue[this];
  }

  static final Map<String, AriesAgencyMessageStatusEnum> _enumMap = {
    "MS-101": AriesAgencyMessageStatusEnum.created,
    "MS-102": AriesAgencyMessageStatusEnum.sent,
    "MS-103": AriesAgencyMessageStatusEnum.received,
    "MS-104": AriesAgencyMessageStatusEnum.accepted,
    "MS-105": AriesAgencyMessageStatusEnum.rejected,
    "MS-106": AriesAgencyMessageStatusEnum.reviewed
  };

  static final Map<AriesAgencyMessageStatusEnum, String> _enumMapValue = {
    AriesAgencyMessageStatusEnum.created: "MS-101",
    AriesAgencyMessageStatusEnum.sent: "MS-102",
    AriesAgencyMessageStatusEnum.received: "MS-103",
    AriesAgencyMessageStatusEnum.accepted: "MS-104",
    AriesAgencyMessageStatusEnum.rejected: "MS-105",
    AriesAgencyMessageStatusEnum.reviewed: "MS-106"
  };
}
