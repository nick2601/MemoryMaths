import 'package:flutter/material.dart';

class CommonTabAnimationView extends StatefulWidget {
  final VoidCallback onTab;
  final Widget child;
  final bool isDelayed;

  const CommonTabAnimationView({
    Key? key,
    required this.child,
    required this.onTab,
    this.isDelayed = false,
  }) : super(key: key);

  @override
  State<CommonTabAnimationView> createState() =>
      _CommonTabAnimationViewState();
}

class _CommonTabAnimationViewState extends State<CommonTabAnimationView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.0,
      upperBound: 0.1,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleTap() async {
    await _controller.forward();
    await _controller.reverse();
    if (widget.isDelayed) {
      await Future.delayed(const Duration(milliseconds: 195));
    }
    widget.onTab();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: 1 - _controller.value,
          child: GestureDetector(
            onTap: _handleTap,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}