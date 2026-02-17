import 'dart:ui';
import 'package:flutter/material.dart';

class SlideButton extends StatefulWidget {
  final VoidCallback onSlideComplete;
  final String text;

  const SlideButton({
    super.key,
    required this.onSlideComplete,
    required this.text,
  });

  @override
  State<SlideButton> createState() => _SlideButtonState();
}

class _SlideButtonState extends State<SlideButton>
    with SingleTickerProviderStateMixin {
  double _dragPosition = 0.0;
  late AnimationController _resetController;
  late Animation<double> _resetAnimation;

  @override
  void initState() {
    super.initState();
    _resetController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
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

  void _resetSlider() {
    _resetAnimation = Tween<double>(
      begin: _dragPosition,
      end: 0,
    ).animate(CurvedAnimation(parent: _resetController, curve: Curves.easeOut));
    _resetController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width * 0.8;
    const double height = 78.0;
    const double circleSize = 68.0;
    const double horizontalPadding = 5.0;

    final double maxDrag = width - circleSize - horizontalPadding * 2;

    double progress = (_dragPosition / maxDrag).clamp(0.0, 1.0);
    double rotationAngle = -progress * 0.5;

    return Center(
      child: Stack(
        children: [
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: 54,
                  offset: Offset(0, 12),
                ),
              ],
              color: Colors.black,
              borderRadius: BorderRadius.circular(height / 2),
            ),
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                widget.text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Revalia',
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          Positioned(
            left: _dragPosition + horizontalPadding,
            top: (height - circleSize) / 2,
            child: GestureDetector(
              onHorizontalDragUpdate: (details) {
                setState(() {
                  _dragPosition += details.delta.dx;

                  if (_dragPosition < 0) _dragPosition = 0;
                  if (_dragPosition > maxDrag) _dragPosition = maxDrag;
                });
              },
              onHorizontalDragEnd: (details) {
                if (_dragPosition >= maxDrag - 5) {
                  widget.onSlideComplete();
                } else {
                  _resetSlider();
                }
              },
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
                          Colors.white.withOpacity(0.2),
                          Colors.white.withOpacity(0.4),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.1),
                        width: 1.5,
                      ),
                    ),
                    child: AnimatedRotation(
                      turns: rotationAngle,
                      duration: const Duration(milliseconds: 100),
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
        ],
      ),
    );
  }
}
