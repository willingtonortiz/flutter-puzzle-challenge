import 'package:flutter_test/flutter_test.dart';
import 'package:puzzle_challenge/app/logic/game.dart';
import 'package:puzzle_challenge/app/models/box.dart';
import 'package:puzzle_challenge/app/models/swipe_direction.dart';

void main() {
  group('Game', () {
    late Game game;

    setUp(() {
      game = Game();
    });

    group('listBoard', () {
      test('it should return a list of boxes', () {
        expect(game.listBoard().length, 16);
      });
    });

    group('canMove', () {
      test('it should not allow swipe outside boundaries', () {
        const topLeftBox = Box(x: 0, y: 0, value: '01');
        expect(game.canBoxMove(topLeftBox, SwipeDirection.top), false);
        expect(game.canBoxMove(topLeftBox, SwipeDirection.left), false);

        const topRightBox = Box(x: 3, y: 0, value: '04');
        expect(game.canBoxMove(topRightBox, SwipeDirection.top), false);
        expect(game.canBoxMove(topRightBox, SwipeDirection.right), false);

        const bottomLeftBox = Box(x: 0, y: 3, value: '13');
        expect(game.canBoxMove(bottomLeftBox, SwipeDirection.bottom), false);
        expect(game.canBoxMove(bottomLeftBox, SwipeDirection.left), false);

        const bottomRightBox = Box(x: 3, y: 3, value: '16');
        expect(game.canBoxMove(bottomRightBox, SwipeDirection.bottom), false);
        expect(game.canBoxMove(bottomRightBox, SwipeDirection.right), false);
      });

      test('it should allow swipe if space is empty', () {
        const box15 = Box(x: 2, y: 3, value: '15');
        expect(game.canBoxMove(box15, SwipeDirection.right), true);
        expect(game.canBoxMove(box15, SwipeDirection.top), false);
        expect(game.canBoxMove(box15, SwipeDirection.bottom), false);
        expect(game.canBoxMove(box15, SwipeDirection.left), false);

        const box12 = Box(x: 3, y: 2, value: '12');
        expect(game.canBoxMove(box12, SwipeDirection.bottom), true);
        expect(game.canBoxMove(box12, SwipeDirection.top), false);
        expect(game.canBoxMove(box12, SwipeDirection.right), false);
        expect(game.canBoxMove(box12, SwipeDirection.left), false);
      });
    });

    group('getBox', () {
      test('it should retrieve null for outbound values', () {
        final null1 = game.getBox(x: -1, y: 0);
        expect(null1, null);

        final null2 = game.getBox(x: 4, y: 0);
        expect(null2, null);

        final null3 = game.getBox(x: 0, y: -1);
        expect(null3, null);

        final null4 = game.getBox(x: 0, y: 4);
        expect(null4, null);
      });

      test('it should return a box for inbound values', () {
        final box1 = game.getBox(x: 0, y: 0);
        expect(box1, const Box(x: 0, y: 0, value: '1'));
      });

      test('it should return null for empty box', () {
        final emptyBox = game.getBox(x: 3, y: 3);
        expect(emptyBox, null);
      });
    });

    group('move', () {
      test('it should move the box to the empty space', () {
        // Move 12 to bottom
        expect(game.getBox(x: 3, y: 3), null);

        const boxToMove1 = Box(x: 3, y: 2, value: '12');
        game.move(
          boxToMove1,
          SwipeDirection.bottom,
        );

        const movedBox1 = Box(x: 3, y: 3, value: '12');
        expect(game.getBox(x: 3, y: 2), null);
        expect(game.getBox(x: 3, y: 3), movedBox1);

        // Move 11 to right
        const boxToMove2 = Box(x: 2, y: 2, value: '11');
        game.move(
          boxToMove2,
          SwipeDirection.right,
        );

        const movedBox2 = Box(x: 3, y: 2, value: '11');
        expect(game.getBox(x: 2, y: 2), null);
        expect(game.getBox(x: 3, y: 2), movedBox2);
      });
    });
  });
}
