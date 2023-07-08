import 'package:aries_api/aries_api.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'injection.config.dart';

final locator = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: false,
)
void configureInjection() => init(locator);

@module
abstract class AriesApiRegisterModule {
  AriesConnectionApi connectionApi() => AriesConnectionApi();

  AriesConnectionParser connectionParser() => AriesConnectionParser();

  AriesCredentialApi credentialApi() => AriesCredentialApi();

  AriesProofApi proofApi() => AriesProofApi();

  AriesMessageApi messageApi() => AriesMessageApi();

  AriesSdkApi sdkApi() => AriesSdkApi();
}
