import 'package:flutter_bloc/flutter_bloc.dart';

import 'menu_navigation.state.dart';

Map<int, MenuNavigationState> menuMap = {
  0: WalletMenuState(),
  1: ConnectionMenuState(),
  2: CredentialMenuState(),
  3: ProofMenuState()
};

class MenuNavigationCubit extends Cubit<MenuNavigationState> {
  MenuNavigationCubit() : super(WalletMenuState());

  void navigateTo(int selectedIndex) {
    emit(menuMap[selectedIndex] ?? WalletMenuState());
  }
}
