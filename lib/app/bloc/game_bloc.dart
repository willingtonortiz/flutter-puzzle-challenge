import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:puzzle_challenge/app/logic/game.dart';
import 'package:puzzle_challenge/app/models/box.dart';
import 'package:puzzle_challenge/app/models/swipe_direction.dart';

class GameState {
  const GameState({
    this.board = const [],
  });

  final List<Box?> board;

  GameState copyWith({
    List<Box?>? board,
  }) {
    return GameState(
      board: board ?? this.board,
    );
  }
}

class GameCubit extends Cubit<GameState> {
  GameCubit() : super(const GameState()) {
    emit(
      state.copyWith(
        board: game.listBoard(),
      ),
    );
  }

  final game = Game();

  void move(
    Box box,
    SwipeDirection direction,
  ) {
    final isMoved = game.move(box, direction);
    if (!isMoved) {
      return;
    }

    emit(state.copyWith(board: game.listBoard()));
  }
}
