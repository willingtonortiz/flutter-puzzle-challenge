import 'package:flutter/material.dart';

import 'package:puzzle_challenge/app/models/box.dart';
import 'package:puzzle_challenge/app/models/swipe_direction.dart';

class GameBox extends StatefulWidget {
  const GameBox({
    Key? key,
    required this.box,
    required this.size,
    required this.onSwipe,
  }) : super(key: key);

  final Box box;
  final double size;
  final void Function(Box box, SwipeDirection direction) onSwipe;

  @override
  State<GameBox> createState() => _GameBoxState();
}

class _GameBoxState extends State<GameBox> {
  SwipeDirection? swipeDirection;
  final double minDelta = 5;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      key: widget.key,
      duration: const Duration(milliseconds: 100),
      top: widget.box.y * widget.size,
      left: widget.box.x * widget.size,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: GestureDetector(
          onHorizontalDragUpdate: onHorizontalDragUpdate,
          onVerticalDragUpdate: onVerticalDragUpdate,
          onVerticalDragEnd: onDragEnd,
          onHorizontalDragEnd: onDragEnd,
          child: Container(
            width: widget.size - 8,
            height: widget.size - 8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: Colors.blue,
            ),
            child: Center(
              child: Text(
                widget.box.value,
                style: const TextStyle(fontSize: 32, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onHorizontalDragUpdate(DragUpdateDetails details) {
    final primaryDelta = details.primaryDelta ?? 0;

    if (primaryDelta < -minDelta) {
      swipeDirection = SwipeDirection.left;
    } else if (primaryDelta > minDelta) {
      swipeDirection = SwipeDirection.right;
    }
  }

  void onVerticalDragUpdate(DragUpdateDetails details) {
    final primaryDelta = details.primaryDelta ?? 0;

    if (primaryDelta < -minDelta) {
      swipeDirection = SwipeDirection.top;
    } else if (primaryDelta > minDelta) {
      swipeDirection = SwipeDirection.bottom;
    }
  }

  void onDragEnd(DragEndDetails _) {
    if (swipeDirection != null) {
      widget.onSwipe(widget.box, swipeDirection!);
    }
    swipeDirection = null;
  }
}
