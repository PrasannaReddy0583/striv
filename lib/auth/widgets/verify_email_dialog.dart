import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class VerifyEmailDialog extends StatefulWidget {
  final String email;

  const VerifyEmailDialog({super.key, required this.email});

  @override
  State<VerifyEmailDialog> createState() => _VerifyEmailDialogState();
}

class _VerifyEmailDialogState extends State<VerifyEmailDialog> {
  int _secondsLeft = 30;
  bool _canResend = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _secondsLeft = 30;
    _canResend = false;

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft == 0) {
        setState(() {
          _canResend = true;
        });
        _timer?.cancel();
      } else {
        setState(() {
          _secondsLeft--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    double iconSize = width * 0.18;
    double padding = width * 0.05;
    double spacingSmall = height * 0.01;
    double spacingMedium = height * 0.02;
    double spacingLarge = height * 0.03;

    return Dialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: width * 0.05,
        vertical: height * 0.03,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(width * 0.05),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(width * 0.05),
        child: Stack(
          children: [
            /// Background with abstract network image (blurred & faded)
            Positioned.fill(
              child: CachedNetworkImage(
                imageUrl: "https://picsum.photos/400/600",
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(color: Colors.white),
                errorWidget: (context, url, error) =>
                    Container(color: Colors.white),
              ),
            ),

            /// Blur + dim overlay
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: Container(color: Colors.white.withOpacity(0.85)),
              ),
            ),

            /// Foreground content
            Padding(
              padding: EdgeInsets.all(padding),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// Close button
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: Icon(
                        Icons.close,
                        color: Colors.black54,
                        size: width * 0.07,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),

                  Icon(
                    Icons.check_circle_outline,
                    color: const Color(0xFFB59D82),
                    size: iconSize,
                  ),
                  SizedBox(height: spacingSmall),

                  Text(
                    "Please Check Your Inbox",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: spacingSmall),

                  Text(
                    "We've sent you a verification link to your email address.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: width * 0.035,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: spacingMedium),

                  /// Email box
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.03,
                      vertical: height * 0.01,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(width * 0.03),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.email,
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: width * 0.035,
                              color: Colors.black87,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Icon(
                          Icons.email_outlined,
                          color: Colors.grey,
                          size: width * 0.06,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: spacingSmall),

                  /// Loader + Awaiting message
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: width * 0.04,
                        width: width * 0.04,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.grey,
                          ),
                        ),
                      ),
                      SizedBox(width: width * 0.01),
                      Expanded(
                        child: Text(
                          "Awaiting verification… This may take a moment",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: width * 0.03,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spacingMedium),

                  /// Resend Email Button with timer
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: _canResend
                            ? () {
                                // TODO: implement resend logic
                                _startTimer();
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3D3D3D),
                          disabledBackgroundColor: const Color(
                            0xFF3D3D3D,
                          ).withOpacity(0.4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(width * 0.03),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: width * 0.06,
                            vertical: height * 0.015,
                          ),
                        ),
                        child: Text(
                          _canResend
                              ? "Resend Email"
                              : "Resend in $_secondsLeft s",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            color: Colors.white,
                            fontSize: width * 0.035,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spacingSmall),

                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Change Email Address",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        color: Colors.black,
                        fontSize: width * 0.03,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  SizedBox(height: spacingLarge * 0.5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
