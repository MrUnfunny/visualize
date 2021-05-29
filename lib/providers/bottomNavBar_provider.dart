import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bottomNavBarProvider =
    StateNotifierProvider<BottomNavBarStateState, BottomNavBarState>((ref) {
  return BottomNavBarStateState();
});

class BottomNavBarStateState extends StateNotifier<BottomNavBarState> {
  BottomNavBarStateState()
      : super(
          BottomNavBarState(
            isNextPressed: false,
            isPrevPressed: false,
          ),
        );

  void toggleIsNextPressed() {
    state = state.copyWith(isNextPressed: !state.isNextPressed);
  }

  void toggleIsPrevPressed() {
    state = state.copyWith(isPrevPressed: !state.isPrevPressed);
  }
}

@immutable
class BottomNavBarState {
  final bool isNextPressed;
  final bool isPrevPressed;

  BottomNavBarState({
    required this.isNextPressed,
    required this.isPrevPressed,
  });

  BottomNavBarState copyWith({
    bool? isNextPressed,
    bool? isPrevPressed,
  }) {
    return BottomNavBarState(
      isNextPressed: isNextPressed ?? this.isNextPressed,
      isPrevPressed: isPrevPressed ?? this.isPrevPressed,
    );
  }
}
