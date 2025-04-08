import 'package:flutter/material.dart';

class ShakeWidget extends StatefulWidget {
  final Duration duration;
  final double deltaX;
  final Curve curve;
  final Widget child;

  const ShakeWidget({
    super.key,
    this.duration = const Duration(milliseconds: 500),
    this.deltaX = 20,
    this.curve = Curves.bounceOut,
    required this.child,
  });

  @override
  State<ShakeWidget> createState() => ShakeWidgetState();
}

class ShakeWidgetState extends State<ShakeWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  /// Call this from the parent using a GlobalKey
  void shake() {
    _controller.forward(from: 0);
  }

  double get offset => widget.deltaX * _shakeValue;

  double get _shakeValue {
    final anim = widget.curve.transform(_controller.value);
    return 2 * (0.5 - (0.5 - anim).abs());
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) => Transform.translate(
        offset: Offset(offset, 0),
        child: widget.child,
      ),
    );
  }
}
