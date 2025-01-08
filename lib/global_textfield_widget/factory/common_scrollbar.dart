import 'package:flutter/material.dart';

class CommonScrollableWithControls extends StatefulWidget {
  final Widget child;
  final double maxHeight;
  final double spacing;

  const CommonScrollableWithControls(
      {super.key,
      required this.child,
      this.maxHeight = 400.0,
      this.spacing = 40.0});

  @override
  State<CommonScrollableWithControls> createState() =>
      _CommonScrollableWithControlsState();
}

class _CommonScrollableWithControlsState
    extends State<CommonScrollableWithControls> {
  late final ScrollController _scrollController;
  bool _canScroll = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_checkScrollability);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_checkScrollability);
    _scrollController.dispose();
    super.dispose();
  }

  void _checkScrollability() {
    if (!mounted) return;
    final maxExtent = _scrollController.position.maxScrollExtent;
    setState(() {
      _canScroll = maxExtent > 0;
    });
  }

  void _scrollUp() {
    _scrollController.animateTo(
      _scrollController.offset - 100,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollDown() {
    _scrollController.animateTo(
      _scrollController.offset + 100,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            _checkScrollability();
          }
        });

        return Container(
          constraints: BoxConstraints(maxHeight: widget.maxHeight),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(overscroll: false),
                child: RawScrollbar(
                  controller: _scrollController,
                  thumbColor: Colors.grey[400]!,
                  radius: const Radius.circular(20),
                  thickness: 35,
                  thumbVisibility: _canScroll,
                  trackVisibility: _canScroll,
                  trackColor: Colors.grey[200],
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    padding: EdgeInsets.only(
                        left: 8, right: _canScroll ? widget.spacing : 8),
                    child: widget.child,
                  ),
                ),
              ),
              if (_canScroll)
                Positioned(
                  top: 0,
                  right: 0,
                  child: InkWell(
                    onTap: _scrollUp,
                    child: Container(
                      width: 35,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Icon(
                        Icons.arrow_drop_up,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              if (_canScroll)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: InkWell(
                    onTap: _scrollDown,
                    child: Container(
                      width: 35,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
