// Flutter imports:
import 'package:flutter/material.dart';

class FadingScroller extends StatefulWidget {
  final Widget Function(BuildContext context, ScrollController scrollController)
      builder;

  final ScrollController? scrollController;

  const FadingScroller({Key? key, required this.builder, this.scrollController})
      : super(key: key);

  @override
  State<FadingScroller> createState() => _FadingScrollerState();
}

class _FadingScrollerState extends State<FadingScroller> {
  late final ScrollController _scrollController;

  bool _overlayIsVisible = true;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController ?? ScrollController();
    _scrollController.addListener(_handleScrollUpdate);
  }

  @override
  void dispose() {
    if (widget.scrollController == null) {
      // Only dispise if it was _us_ creating the controller.
      _scrollController.dispose();
    }
    super.dispose();
  }

  void _handleScrollUpdate() {
    if (_scrollController.position.extentAfter <= 0) {
      setState(() {
        _overlayIsVisible = false;
      });
    } else {
      setState(() {
        _overlayIsVisible = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.builder(context, _scrollController),
        IgnorePointer(
          child: AnimatedOpacity(
            opacity: _overlayIsVisible ? 1 : 0,
            duration: const Duration(milliseconds: 500),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x00FFFFFF),
                    Color(0xFFFFFFFF),
                  ],
                  stops: [
                    0.8,
                    1,
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
