import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

/// {@template animated_indexed_stack.builder}
/// AnimatedIndexedStackTransitionBuilder.
/// {@endtemplate}
typedef AnimatedIndexedStackTransitionBuilder =
    Widget Function(BuildContext context, Animation<double> animation, Widget child);

/// Default value of [AnimatedIndexedStackTransitionBuilder] for [AnimatedIndexedStack] widget.
Widget _defaultTransitionBuilder(BuildContext context, Animation<double> primary, Widget child) {
  final tween = Tween<Offset>(begin: const Offset(0, .01), end: Offset.zero);
  final animation = CurveTween(curve: Curves.easeInOutCubicEmphasized).animate(primary);
  return SlideTransition(
    position: animation.drive(tween),
    child: FadeTransition(opacity: animation, child: child),
  );
}

/// {@template animated_indexed_stack}
/// AnimatedNavigatorStack widget.
/// {@endtemplate}
class AnimatedIndexedStack extends StatefulWidget {
  /// {@macro animated_indexed_stack}
  const AnimatedIndexedStack({
    super.key,
    required this.index,
    required this.children,
    this.duration = Durations.extralong2,
    AnimatedIndexedStackTransitionBuilder? transitionBuilder,
  }) : _transitionBuilder = transitionBuilder ?? _defaultTransitionBuilder;

  final int index;
  final Duration duration;
  final List<Widget> children;
  final AnimatedIndexedStackTransitionBuilder _transitionBuilder;

  @override
  State<AnimatedIndexedStack> createState() => _AnimatedIndexedStackState();
}

class _AnimatedIndexedStackState extends State<AnimatedIndexedStack>
    with SingleTickerProviderStateMixin {
  late final AnimationController _incomingController;
  late Animation<double> _incomingAnimation;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();

    _incomingController = AnimationController(vsync: this, duration: widget.duration);
    _incomingAnimation = Tween<double>(begin: 0, end: 1).animate(_incomingController);
    _currentIndex = widget.index;
    // Initial tab should be visible immediately
    _incomingController.value = 1.0;
  }

  @override
  void didUpdateWidget(covariant AnimatedIndexedStack oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Only animate if the index actually changed
    if (oldWidget.index != widget.index) {
      _currentIndex = widget.index;
      _incomingController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _incomingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget childBuilder(bool isActive, Widget child) => Offstage(
      offstage: !isActive,
      child: IgnorePointer(
        ignoring: !isActive,
        child: TickerMode(enabled: isActive, child: child),
      ),
    );

    final children = widget.children
        .mapIndexed(
          (index, child) => widget._transitionBuilder(
            context,
            _incomingAnimation,
            childBuilder(index == _currentIndex, child),
          ),
        )
        .toList();
    return Stack(children: children);
  }
}
