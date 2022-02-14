import 'package:puzzle_challenge/app/models/box.dart';
import 'package:puzzle_challenge/app/models/swipe_direction.dart';

class Game {
  Game() {
    board = [
      [
        const Box(x: 0, y: 0, value: '1'),
        const Box(x: 1, y: 0, value: '2'),
        const Box(x: 2, y: 0, value: '3'),
        const Box(x: 3, y: 0, value: '4'),
      ],
      [
        const Box(x: 0, y: 1, value: '5'),
        const Box(x: 1, y: 1, value: '6'),
        const Box(x: 2, y: 1, value: '7'),
        const Box(x: 3, y: 1, value: '8'),
      ],
      [
        const Box(x: 0, y: 2, value: '9'),
        const Box(x: 1, y: 2, value: '10'),
        const Box(x: 2, y: 2, value: '11'),
        const Box(x: 3, y: 2, value: '12'),
      ],
      [
        const Box(x: 0, y: 3, value: '13'),
        const Box(x: 1, y: 3, value: '14'),
        const Box(x: 2, y: 3, value: '15'),
        null
      ],
    ];
  }

  late List<List<Box?>> board;

  List<Box?> listBoard() {
    return board.fold(
      [],
      (accum, curr) => [...accum, ...curr],
    );
  }

  bool canBoxMove(Box box, SwipeDirection direction) {
    final x = box.x;
    final y = box.y;

    if (direction.isTop) {
      if (box.y == 0) {
        return false;
      }
      if (board[y - 1][x] == null) {
        return true;
      }
    }

    if (direction.isBottom) {
      if (box.y == 3) {
        return false;
      }
      if (board[y + 1][x] == null) {
        return true;
      }
    }

    if (direction.isLeft) {
      if (box.x == 0) {
        return false;
      }
      if (board[y][x - 1] == null) {
        return true;
      }
    }

    if (direction.isRight) {
      if (box.x == 3) {
        return false;
      }
      if (board[y][x + 1] == null) {
        return true;
      }
    }

    return false;
  }

  bool move(Box box, SwipeDirection direction) {
    if (!canBoxMove(box, direction)) {
      return false;
    }

    final x = box.x;
    final y = box.y;
    final xMove = direction.isLeft
        ? -1
        : direction.isRight
            ? 1
            : 0;
    final yMove = direction.isTop
        ? -1
        : direction.isBottom
            ? 1
            : 0;
    final newY = y + yMove;
    final newX = x + xMove;

    final currentBox = board[y][x]?.copyWith(
      x: newX,
      y: newY,
    );

    board[y][x] = null;
    board[newY][newX] = currentBox;

    return true;
  }

  Box? getBox({
    required int x,
    required int y,
  }) {
    if (x < 0 || x > 3 || y < 0 || y > 3) {
      return null;
    }

    return board[y][x];
  }
}
