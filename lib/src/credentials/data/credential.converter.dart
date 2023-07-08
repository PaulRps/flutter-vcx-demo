import 'package:aries_api/aries_api.dart';
import 'package:flutter_vcx_demo/src/credentials/domain/domain.dart';
import 'package:smartstruct/smartstruct.dart';
import 'package:injectable/injectable.dart';

part 'credential.converter.mapper.g.dart';

@Mapper(useInjection: true, caseSensitiveFields: false)
abstract class CredentialConverter {
  @IgnoreMapping()
  List<AriesCredentialDto> toAriesCredentialDtoList(
          AriesGetCredentialsResponseDto from) =>
      from.credentials;

  Credential toCredential(AriesCredentialDto from);

  @IgnoreMapping()
  List<Credential> toCredentialList(List<AriesCredentialDto> from) =>
      from.map((e) => toCredential(e)).toList();
}
