import 'package:flutter_bloc/flutter_bloc.dart';

import 'menu_navigation.state.dart';

Map<int, MenuNavigationState> menuMap = {
  0: const MenuNavigationState.wallet(),
  1: const MenuNavigationState.connection(),
  2: const MenuNavigationState.credential(),
  3: const MenuNavigationState.proof()
};

class MenuNavigationCubit extends Cubit<MenuNavigationState> {
  MenuNavigationCubit() : super(menuMap[0]!);

  void navigateTo(int selectedIndex) {
    emit(menuMap[selectedIndex] ?? const MenuNavigationState.wallet());
  }
}
