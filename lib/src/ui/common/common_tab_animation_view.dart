import 'package:flutter/material.dart';

class CommonTabAnimationView extends StatefulWidget {
  final Function onTab;
  final Widget child;
  final bool isDelayed;

  const CommonTabAnimationView({
    Key? key,
    required this.child,
    required this.onTab,
    this.isDelayed = false,
  }) : super(key: key);

  @override
  _CommonTabAnimationViewState createState() => _CommonTabAnimationViewState();
}

class _CommonTabAnimationViewState extends State<CommonTabAnimationView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
      lowerBound: 0.0,
      upperBound: 0.1,
    );

    // Create animation instead of listening to controller directly
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.9,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: child,
        );
      },
      child: GestureDetector(
        onTap: () async {
          _controller.forward().then((value) => _controller.reverse());
          if (widget.isDelayed)
            await Future.delayed(Duration(milliseconds: 195));
          widget.onTab();
        },
        child: widget.child,
      ),
    );
  }
}
