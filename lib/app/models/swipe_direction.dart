enum SwipeDirection { left, right, top, bottom }

extension SwipeDirectionUtils on SwipeDirection {
  bool get isLeft => this == SwipeDirection.left;
  bool get isRight => this == SwipeDirection.right;
  bool get isTop => this == SwipeDirection.top;
  bool get isBottom => this == SwipeDirection.bottom;
}
