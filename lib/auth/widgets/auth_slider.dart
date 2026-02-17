import 'dart:ui';
import 'package:flutter/material.dart';

class SlideButton extends StatefulWidget {
  final Future<void> Function()? onSlideComplete;
  final String text;
  final bool enabled;

  const SlideButton({
    super.key,
    required this.text,
    this.onSlideComplete,
    this.enabled = true,
  });

  @override
  State<SlideButton> createState() => _SlideButtonState();
}

class _SlideButtonState extends State<SlideButton>
    with SingleTickerProviderStateMixin {
  double _dragPosition = 0.0;
  late final AnimationController _resetController;
  late Animation<double> _resetAnimation = AlwaysStoppedAnimation(0.0);
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _resetController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _resetController.addListener(() {
      setState(() {
        _dragPosition = _resetAnimation.value;
      });
    });
  }

  @override
  void dispose() {
    _resetController.dispose();
    super.dispose();
  }

  void _startResetAnimation() {
    _resetAnimation = Tween<double>(
      begin: _dragPosition,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _resetController, curve: Curves.easeOut));
    _resetController.forward(from: 0);
  }

  void _onDragUpdate(DragUpdateDetails details, double maxDrag) {
    setState(() {
      _dragPosition += details.delta.dx;
      if (_dragPosition < 0) _dragPosition = 0;
      if (_dragPosition > maxDrag) _dragPosition = maxDrag;
    });
  }

  Future<void> _onDragEnd(double maxDrag) async {
    if (_dragPosition >= maxDrag - 5) {
      setState(() => _isLoading = true);

      await Future.delayed(const Duration(milliseconds: 200));

      if (widget.onSlideComplete != null) {
        try {
          await widget.onSlideComplete!.call();
        } catch (_) {}
      }

      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      _startResetAnimation();
    } else {
      _startResetAnimation();
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width * 0.8;
    const double height = 78.0;
    const double circleSize = 68.0;
    const double horizontalPadding = 5.0;
    final double maxDrag = width - circleSize - horizontalPadding * 2;

    double progress = (_dragPosition / maxDrag).clamp(0.0, 1.0);
    double rotationTurns = -progress * 0.25;

    final double leftWhenNotLoading = horizontalPadding + _dragPosition;
    final double leftWhenLoading = (width - circleSize) / 2;

    return Center(
      child: SizedBox(
        width: width,
        height: height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              width: _isLoading ? circleSize + 14 : width,
              height: _isLoading ? circleSize + 20 : height,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(200),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 20,
                    offset: Offset(0, 12),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: AnimatedOpacity(
                opacity: _isLoading ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 200),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    widget.text,
                    style: const TextStyle(
                      fontFamily: 'Revalia',
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            AnimatedPositioned(
              duration: _isLoading
                  ? const Duration(milliseconds: 400)
                  : Duration.zero,
              curve: Curves.easeInOut,
              left: _isLoading ? leftWhenLoading : leftWhenNotLoading,
              top: (height - circleSize) / 2,
              child: GestureDetector(
                onHorizontalDragUpdate: (!_isLoading && widget.enabled)
                    ? (details) => _onDragUpdate(details, maxDrag)
                    : null,
                onHorizontalDragEnd: (!_isLoading && widget.enabled)
                    ? (_) => _onDragEnd(maxDrag)
                    : null,
                child: ClipOval(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 10),
                    child: Container(
                      width: circleSize,
                      height: circleSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withOpacity(0.18),
                            Colors.white.withOpacity(0.35),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.12),
                          width: 1.5,
                        ),
                      ),
                      child: Center(
                        child: _isLoading
                            ? const SizedBox(
                                width: 34,
                                height: 34,
                                child: CircularProgressIndicator(
                                  strokeWidth: 3,
                                  color: Colors.white,
                                ),
                              )
                            : Transform.rotate(
                                angle: rotationTurns * 2 * 3.141592653589793,
                                child: const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
