import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:striv/auth/pages/signupscreen.dart';
import 'package:striv/auth/services/auth_service.dart';
import 'package:striv/auth/widgets/auth_slider.dart';
import 'package:striv/constants.dart';
import 'package:striv/pages/navigation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  bool _submitted = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(const AssetImage('assets/images/loginformbg.jpg'), context);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splash_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Form(
                key: _formKey,
                autovalidateMode: _submitted
                    ? AutovalidateMode.onUserInteraction
                    : AutovalidateMode.disabled,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: screenHeight * 0.05),

                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFEADFD3),
                        border: Border.all(
                          color: const Color(0xFFD3C3B3),
                          width: 1.5,
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.shield_outlined,
                          color: Color(0xFFB59D82),
                          size: 40,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    Text(
                      TextStrings.loginTitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Revalia',
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF3D3D3D),
                      ),
                    ),
                    const SizedBox(height: 28),

                    Text(
                      TextStrings.loginSubTitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 32),

                    TextFormField(
                      controller: _emailController,
                      autofocus: false,
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.emailAddress,
                      decoration: _buildInputDecoration('Email Address'),
                      style: TextStyle(fontFamily: "Poppins", fontSize: 14),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$',
                        ).hasMatch(value)) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    TextFormField(
                      controller: _passwordController,
                      autofocus: false,
                      cursorColor: Colors.black,
                      obscureText: !_isPasswordVisible,
                      decoration: _buildInputDecoration(
                        'Password',
                        isPassword: true,
                      ),
                      style: TextStyle(fontFamily: "Poppins", fontSize: 14),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 8) {
                          return 'Password must be at least 8 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontFamily: "Poppins",
                            color: const Color(0xFF3D3D3D),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),

                    SlideButton(
                      text: "\t\tLogin",
                      enabled: true,
                      onSlideComplete: () async {
                        setState(() => _submitted = true);

                        if (_formKey.currentState?.validate() != true) {
                          return;
                        }

                        try {
                          final success = await AuthService().login(
                            _emailController.text,
                            _passwordController.text,
                          );

                          if (!mounted) return;

                          if (success.isNotEmpty) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const Navigation(),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Invalid email or password"),
                              ),
                            );
                          }
                        } catch (e) {
                          if (!mounted) return;
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text("$e")));
                        }
                      },
                    ),
                    const SizedBox(height: 24),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account? ",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black54,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        const CreateAccountScreen(),
                                transitionsBuilder:
                                    (
                                      context,
                                      animation,
                                      secondaryAnimation,
                                      child,
                                    ) {
                                      return FadeTransition(
                                        opacity: animation,
                                        child: child,
                                      );
                                    },
                                transitionDuration: const Duration(
                                  milliseconds: 400,
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            'Create One',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.05),

                    Row(
                      children: const [
                        Expanded(child: Divider(color: Colors.grey)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'or continue with',
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                        Expanded(child: Divider(color: Colors.grey)),
                      ],
                    ),
                    const SizedBox(height: 24),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildSocialIcon('assets/icons/google.png'),
                        const SizedBox(width: 20),
                        _buildSocialIcon('assets/icons/apple.png'),
                        // const SizedBox(width: 20),
                        // _buildSocialIcon('assets/icons/linkedin.png'),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.05),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(
    String label, {
    bool isPassword = false,
  }) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(fontFamily: "Poppins", color: Colors.black54),
      filled: true,
      fillColor: Colors.transparent,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(42),
        borderSide: const BorderSide(color: Colors.black54),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(42),
        borderSide: const BorderSide(color: Colors.black54),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(42),
        borderSide: const BorderSide(color: Colors.black54, width: 1.5),
      ),
      suffixIcon: isPassword
          ? IconButton(
              icon: Icon(
                _isPasswordVisible
                    ? CupertinoIcons.eye_fill
                    : CupertinoIcons.eye_slash_fill,
                color: Colors.grey.shade600,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            )
          : null,
    );
  }

  Widget _buildSocialIcon(String assetPath) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Image.asset(
        assetPath,
        height: 24,
        fit: BoxFit.cover,
        width: 24,
        color: Colors.grey.shade700,
      ),
    );
  }
}
// import 'dart:convert';
// import 'package:dealence/features/home/home.dart';
// import 'package:dealence/features/auth/widgets/authSlider.dart';
// import 'package:dealence/features/auth/screens/signupscreen.dart';
// import 'package:dealence/services/auth_service.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:dealence/core/constants.dart';
// import 'package:http/http.dart' as http;

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _formKey = GlobalKey<FormState>();
//   bool _isPasswordVisible = false;
//   bool _submitted = false;

//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   // Forgot password controllers and states
//   final TextEditingController _otpController = TextEditingController();
//   final TextEditingController _newPasswordController = TextEditingController();
//   final TextEditingController _confirmPasswordController = TextEditingController();

//   bool _isForgotPassword = false;
//   bool _isOtpSent = false;
//   bool _isOtpVerified = false;
//   bool _isNewPasswordHidden = true;
//   String? _receivedOtp;
//   bool _isLoading = false;

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     precacheImage(const AssetImage('assets/images/loginformbg.jpg'), context);
//   }

//   Future<void> _sendOtp() async {
//     setState(() => _isLoading = true);
//     final url = Uri.parse('https://sha-qq20.onrender.com/api/user/forgot-password');
//     try {
//       final res = await http.post(
//         url,
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({'email': _emailController.text.trim()}),
//       );
//       final data = jsonDecode(res.body);
//       if (res.statusCode == 200) {
//         _receivedOtp = data['otp']?.toString();
//         setState(() => _isOtpSent = true);
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(data['message'] ?? 'OTP sent successfully!')),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(data['message'] ?? 'Failed to send OTP')),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Network error. Please try again.')),
//       );
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }

//   Future<bool> _verifyOtp() async {
//     final url = Uri.parse('https://sha-qq20.onrender.com/api/user/verify-otp');
//     final res = await http.post(
//       url,
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({'email': _emailController.text.trim(), 'otp': _otpController.text.trim()}),
//     );
//     if (res.statusCode == 200) {
//       setState(() => _isOtpVerified = true);
//       return true;
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Invalid OTP. Please try again.')),
//       );
//       return false;
//     }
//   }

//   Future<void> _resetPassword() async {
//     if (_newPasswordController.text != _confirmPasswordController.text) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Passwords do not match")),
//       );
//       return;
//     }
//     final url = Uri.parse('https://sha-qq20.onrender.com/api/user/reset-password');
//     final res = await http.post(
//       url,
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({
//         'email': _emailController.text.trim(),
//         'newPassword': _newPasswordController.text.trim(),
//       }),
//     );
//     if (res.statusCode == 200) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Password changed successfully!")),
//       );
//       setState(() {
//         _isForgotPassword = false;
//         _isOtpSent = false;
//         _isOtpVerified = false;
//         _emailController.clear();
//         _passwordController.clear();
//         _otpController.clear();
//         _newPasswordController.clear();
//         _confirmPasswordController.clear();
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Failed to change password.")),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('assets/images/splash_bg.png'),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: SafeArea(
//           child: Center(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.symmetric(horizontal: 24.0),
//               child: Form(
//                 key: _formKey,
//                 autovalidateMode: _submitted
//                     ? AutovalidateMode.onUserInteraction
//                     : AutovalidateMode.disabled,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     SizedBox(height: screenHeight * 0.05),
//                     Container(
//                       width: 80,
//                       height: 80,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: const Color(0xFFEADFD3),
//                         border: Border.all(color: const Color(0xFFD3C3B3), width: 1.5),
//                       ),
//                       child: const Center(
//                         child: Icon(Icons.shield_outlined, color: Color(0xFFB59D82), size: 40),
//                       ),
//                     ),
//                     const SizedBox(height: 24),
//                     Text(
//                       _isForgotPassword
//                           ? _isOtpVerified
//                               ? "Set New Password"
//                               : "Forgot Password"
//                           : TextStrings.loginTitle,
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(
//                         fontFamily: 'Revalia',
//                         fontSize: 28,
//                         fontWeight: FontWeight.w600,
//                         color: Color(0xFF3D3D3D),
//                       ),
//                     ),
//                     const SizedBox(height: 28),
//                     Text(
//                       _isForgotPassword
//                           ? _isOtpVerified
//                               ? "Enter your new password"
//                               : "Enter your email to receive OTP"
//                           : TextStrings.loginSubTitle,
//                       textAlign: TextAlign.center,
//                       style: GoogleFonts.poppins(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w400,
//                         color: Colors.black54,
//                       ),
//                     ),
//                     const SizedBox(height: 32),

//                     // Form fields
//                     AnimatedSwitcher(
//                       duration: const Duration(milliseconds: 400),
//                       child: _isForgotPassword
//                           ? Column(
//                               key: ValueKey("forgotForm"),
//                               children: [
//                                 Row(
//                                   children: [
//                                     Expanded(
//                                       child: TextFormField(
//                                         controller: _emailController,
//                                         enabled: !_isOtpSent,
//                                         cursorColor: Colors.black,
//                                         keyboardType: TextInputType.emailAddress,
//                                         decoration: InputDecoration(
//                                           labelText: 'Email Address',
//                                           labelStyle: GoogleFonts.poppins(color: Colors.black54),
//                                           border: OutlineInputBorder(
//                                             borderRadius: BorderRadius.circular(42),
//                                             borderSide: const BorderSide(color: Colors.black54),
//                                           ),
//                                           suffixIcon: !_isOtpSent
//                                               ? TextButton(
//                                                   onPressed: _isLoading ? null : _sendOtp,
//                                                   child: _isLoading
//                                                       ? const SizedBox(
//                                                           width: 16,
//                                                           height: 16,
//                                                           child: CircularProgressIndicator(
//                                                             strokeWidth: 2,
//                                                           ),
//                                                         )
//                                                       : const Text("Send OTP"),
//                                                 )
//                                               : null,
//                                         ),
//                                         validator: (val) {
//                                           if (val == null || val.isEmpty) return 'Enter email';
//                                           if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$')
//                                               .hasMatch(val)) return 'Enter valid email';
//                                           return null;
//                                         },
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 const SizedBox(height: 16),
//                                 if (_isOtpSent && !_isOtpVerified)
//                                   TextFormField(
//                                     controller: _otpController,
//                                     keyboardType: TextInputType.number,
//                                     cursorColor: Colors.black,
//                                     decoration: _buildInputDecoration('Enter OTP'),
//                                     validator: (val) => val == null || val.isEmpty ? 'Enter OTP' : null,
//                                   ),
//                                 if (_isOtpVerified) ...[
//                                   TextFormField(
//                                     controller: _newPasswordController,
//                                     obscureText: _isNewPasswordHidden,
//                                     cursorColor: Colors.black,
//                                     decoration: _buildInputDecoration(
//                                       'New Password',
//                                       isPassword: true,
//                                       onVisibilityToggle: () {
//                                         setState(() => _isNewPasswordHidden = !_isNewPasswordHidden);
//                                       },
//                                     ),
//                                     validator: (val) {
//                                       if (val == null || val.isEmpty) return 'Enter new password';
//                                       if (val.length < 6) return 'At least 6 characters';
//                                       return null;
//                                     },
//                                   ),
//                                   const SizedBox(height: 16),
//                                   TextFormField(
//                                     controller: _confirmPasswordController,
//                                     obscureText: _isNewPasswordHidden,
//                                     cursorColor: Colors.black,
//                                     decoration: _buildInputDecoration(
//                                       'Confirm Password',
//                                       isPassword: true,
//                                       onVisibilityToggle: () {
//                                         setState(() => _isNewPasswordHidden = !_isNewPasswordHidden);
//                                       },
//                                     ),
//                                     validator: (val) {
//                                       if (val == null || val.isEmpty) return 'Confirm your password';
//                                       if (val != _newPasswordController.text) return 'Passwords do not match';
//                                       return null;
//                                     },
//                                   ),
//                                 ],
//                               ],
//                             )
//                           : Column(
//                               key: ValueKey("loginForm"),
//                               children: [
//                                 TextFormField(
//                                   controller: _emailController,
//                                   autofocus: false,
//                                   cursorColor: Colors.black,
//                                   keyboardType: TextInputType.emailAddress,
//                                   decoration: _buildInputDecoration('Email Address'),
//                                   style: GoogleFonts.poppins(fontSize: 14),
//                                   validator: (value) {
//                                     if (value == null || value.isEmpty) return 'Please enter your email';
//                                     if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(value))
//                                       return 'Enter a valid email';
//                                     return null;
//                                   },
//                                 ),
//                                 const SizedBox(height: 16),
//                                 TextFormField(
//                                   controller: _passwordController,
//                                   autofocus: false,
//                                   cursorColor: Colors.black,
//                                   obscureText: !_isPasswordVisible,
//                                   decoration: _buildInputDecoration('Password', isPassword: true),
//                                   style: GoogleFonts.poppins(fontSize: 14),
//                                   validator: (value) {
//                                     if (value == null || value.isEmpty) return 'Please enter your password';
//                                     if (value.length < 8) return 'Password must be at least 8 characters';
//                                     return null;
//                                   },
//                                 ),
//                               ],
//                             ),
//                     ),

//                     const SizedBox(height: 12),

//                     if (!_isForgotPassword)
//                       Align(
//                         alignment: Alignment.centerRight,
//                         child: GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               _isForgotPassword = true;
//                               _isOtpSent = false;
//                               _isOtpVerified = false;
//                               _otpController.clear();
//                               _newPasswordController.clear();
//                               _confirmPasswordController.clear();
//                             });
//                           },
//                           child: Text(
//                             'Forgot Password?',
//                             style: GoogleFonts.poppins(
//                               color: const Color(0xFF3D3D3D),
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                       ),

//                     const SizedBox(height: 14),

//                     SlideButton(
//                       text: !_isForgotPassword
//                           ? "\t\tLogin"
//                           : !_isOtpSent
//                               ? "Send OTP"
//                               : !_isOtpVerified
//                                   ? "Verify OTP"
//                                   : "Change Password",
//                       enabled: true,
//                       onSlideComplete: () async {
//                         setState(() => _submitted = true);
//                         if (!_isForgotPassword) {
//                           if (_formKey.currentState?.validate() != true) return;
//                           final success = await AuthService().login(
//                             _emailController.text,
//                             _passwordController.text,
//                           );
//                           if (!mounted) return;
//                           if (success.isNotEmpty) {
//                             Navigator.pushReplacement(
//                               context,
//                               MaterialPageRoute(builder: (_) => const HomeScreen()),
//                             );
//                           } else {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(content: Text("Invalid email or password")),
//                             );
//                           }
//                         } else {
//                           if (!_isOtpSent) {
//                             if (_formKey.currentState?.validate() ?? false) await _sendOtp();
//                           } else if (_isOtpSent && !_isOtpVerified) {
//                             if (_otpController.text.isNotEmpty) await _verifyOtp();
//                           } else if (_isOtpVerified) {
//                             if (_formKey.currentState?.validate() ?? false) await _resetPassword();
//                           }
//                         }
//                       },
//                     ),
//                     const SizedBox(height: 24),

//                     if (!_isForgotPassword)
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const Text(
//                             "Don't have an account? ",
//                             style: TextStyle(fontFamily: 'Poppins', color: Colors.black54),
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 PageRouteBuilder(
//                                   pageBuilder: (context, animation, secondaryAnimation) =>
//                                       const CreateAccountScreen(),
//                                   transitionsBuilder: (context, animation, secondaryAnimation, child) {
//                                     return FadeTransition(opacity: animation, child: child);
//                                   },
//                                   transitionDuration: const Duration(milliseconds: 400),
//                                 ),
//                               );
//                             },
//                             child: const Text(
//                               'Create One',
//                               style: TextStyle(
//                                   fontFamily: 'Poppins', color: Colors.black, fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                         ],
//                       ),

//                     SizedBox(height: screenHeight * 0.05),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   InputDecoration _buildInputDecoration(String label,
//       {bool isPassword = false, VoidCallback? onVisibilityToggle}) {
//     return InputDecoration(
//       labelText: label,
//       labelStyle: GoogleFonts.poppins(color: Colors.black54),
//       filled: true,
//       fillColor: Colors.transparent,
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(42),
//         borderSide: const BorderSide(color: Colors.black54),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(42),
//         borderSide: const BorderSide(color: Colors.black54),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(42),
//         borderSide: const BorderSide(color: Colors.black54, width: 1.5),
//       ),
//       suffixIcon: isPassword
//           ? IconButton(
//               icon: Icon(
//                 _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
//                 color: Colors.grey.shade600,
//               ),
//               onPressed: onVisibilityToggle ??
//                   () {
//                     setState(() {
//                       _isPasswordVisible = !_isPasswordVisible;
//                     });
//                   },
//             )
//           : null,
//     );
//   }
// }
