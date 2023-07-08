import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vcx_demo/src/wallet/domain/domain.dart';
import 'package:injectable/injectable.dart';

import 'wallet_page.state.dart';

@Injectable()
class WalletPageCubit extends Cubit<WalletPageState> {
  WalletPageCubit(this._startAriesSdkUseCase, this._retrieveWalletDataUseCase,
      this._shutdownOrResetAriesSdkUseCase)
      : super(const WalletPageState.initial());

  late final StartAriesSdkAndSaveWalletDataUseCase _startAriesSdkUseCase;

  late final RetrieveAriesWalletDataUseCase _retrieveWalletDataUseCase;

  late final ShutdownOrResetAriesSdkUseCase _shutdownOrResetAriesSdkUseCase;

  Future<WalletData> retrieveWalletData() {
    try {
      return _retrieveWalletDataUseCase.retrieveWalletData().then((value) {
        emit(WalletPageState.retrievedWalletData(
            walletName: value.name, walletKey: value.key));
        return value;
      }).catchError((error) {
        emit(WalletPageState.error(errorMessage: error.toString()));
        return WalletData(name: "", key: "");
      });
    } catch (e) {
      emit(WalletPageState.error(errorMessage: e.toString()));
      return Future.value(WalletData(name: "", key: ""));
    }
  }

  void openWallet({required String name, required String key}) {
    String walletName = name.isNotEmpty ? name : "flutter_vcx_demo_wallet";
    try {
      if (state.isWalletOpened) {
        emit(WalletPageState.walletAlreadyOpened(
            walletName: state.walletName, walletKey: state.walletKey));
      } else {
        _startAriesSdkUseCase
            .startSdkAndSaveWalletData(WalletData(name: walletName, key: key))
            .then((value) => emit(WalletPageState.walletOpened(
                walletName: walletName, walletKey: key)))
            .catchError((error) => emit(WalletPageState.error(
                walletName: walletName,
                walletKey: key,
                errorMessage: error.toString())));
      }
    } catch (e) {
      emit(WalletPageState.error(
          walletName: walletName, walletKey: key, errorMessage: e.toString()));
    }
  }

  void closeWallet() {
    try {
      if (state.isWalletOpened) {
        _shutdownOrResetAriesSdkUseCase
            .shutdownSdk()
            .then((value) => emit(WalletPageState.walletClosed(
                walletName: state.walletName, walletKey: state.walletKey)))
            .catchError((error) => emit(WalletPageState.error(
                walletName: state.walletName,
                walletKey: state.walletKey,
                errorMessage: error.toString())));
      } else {
        emit(WalletPageState.walletAreNotOpened(
            walletName: state.walletName, walletKey: state.walletKey));
      }
    } catch (e) {
      emit(WalletPageState.error(
          walletName: state.walletName,
          walletKey: state.walletKey,
          errorMessage: e.toString()));
    }
  }

  void deleteWallet() {
    try {
      if (state.isWalletOpened) {
        _shutdownOrResetAriesSdkUseCase
            .resetSdk()
            .then((value) => emit(WalletPageState.walletDeleted(
                walletName: state.walletName, walletKey: state.walletKey)))
            .catchError((error) => emit(WalletPageState.error(
                walletName: state.walletName,
                walletKey: state.walletKey,
                errorMessage: error.toString())));
      } else {
        emit(WalletPageState.walletAreNotOpened(
            walletName: state.walletName, walletKey: state.walletKey));
      }
    } catch (e) {
      emit(WalletPageState.error(
          walletName: state.walletName,
          walletKey: state.walletKey,
          errorMessage: e.toString()));
    }
  }
}
