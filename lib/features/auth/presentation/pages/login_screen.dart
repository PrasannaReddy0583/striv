import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:striv/features/auth/presentation/pages/signupscreen.dart';
import 'package:striv/features/auth/presentation/widgets/auth_slider.dart';
import 'package:striv/constants.dart';
import 'package:striv/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:striv/features/auth/presentation/bloc/auth_event.dart';
import 'package:striv/features/auth/presentation/bloc/auth_state.dart';
import 'package:striv/navigation.dart';
import 'package:striv/utils/app_palette.dart';

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
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _onSlideComplete() async {
    setState(() => _submitted = true);

    if (_formKey.currentState?.validate() != true) return;

    context.read<AuthBloc>().add(
          LoginRequested(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoginSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const Navigation()),
          );
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          systemNavigationBarColor: Color.fromARGB(0, 0, 0, 0),
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
        ),
        child: Scaffold(
          body: Container(
            decoration: const BoxDecoration(color: AppPalette.background),
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
                          style: const TextStyle(
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
                          style: const TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14,
                          ),
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
                          style: const TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14,
                          ),
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
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                fontFamily: "Poppins",
                                color: Color(0xFF3D3D3D),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),

                        BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            return SlideButton(
                              text: "\t\tLogin",
                              enabled: state is! AuthLoading,
                              onSlideComplete: _onSlideComplete,
                            );
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
                                    pageBuilder: (
                                      context,
                                      animation,
                                      secondaryAnimation,
                                    ) =>
                                        const CreateAccountScreen(),
                                    transitionsBuilder: (
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
                                    transitionDuration:
                                        const Duration(milliseconds: 400),
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
      labelStyle: const TextStyle(fontFamily: "Poppins", color: Colors.black54),
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
