import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:striv/features/auth/presentation/widgets/auth_slider.dart';
import 'package:striv/features/auth/presentation/widgets/verify_email_dialog.dart';
import 'package:striv/constants.dart';
import 'package:striv/core/helpers/account_password_rule.dart';
import 'package:striv/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:striv/features/auth/presentation/bloc/auth_event.dart';
import 'package:striv/features/auth/presentation/bloc/auth_state.dart';
import 'package:striv/navigation.dart';
import 'package:striv/features/auth/presentation/pages/terms_and_conditions.dart';
import 'package:striv/utils/app_palette.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false;
  bool _agreedToTerms = false;
  bool _submitted = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _isPasswordValid() {
    final value = _passwordController.text;
    return value.length >= 8 &&
        RegExp(r'[A-Z]').hasMatch(value) &&
        RegExp(r'\d').hasMatch(value) &&
        RegExp(r'[!@#\$&*~]').hasMatch(value);
  }

  Future<void> _onSlideComplete() async {
    setState(() => _submitted = true);

    if (_formKey.currentState?.validate() != true ||
        !_isPasswordValid() ||
        !_agreedToTerms) {
      return;
    }

    await Future.delayed(const Duration(milliseconds: 300));

    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => VerifyEmailDialog(email: _emailController.text),
    );

    context.read<AuthBloc>().add(
          SignupRequested(
            username: _nameController.text.trim(),
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
        if (state is AuthSignupSuccess) {
          Navigator.pushAndRemoveUntil(
            context,
            CupertinoPageRoute(builder: (_) => const Navigation()),
            (route) => false,
          );
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Account created successfully!"),
              duration: Duration(seconds: 2),
            ),
          );
        } else if (state is AuthFailure) {
          Navigator.of(context).pop(); // close the verify dialog if open
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              duration: const Duration(seconds: 3),
            ),
          );
        }
      },
      child: Scaffold(
        body: Container(
          color: AppPalette.background,
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
                        TextStrings.signupTitle,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: "Revalia",
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF3D3D3D),
                        ),
                      ),
                      const SizedBox(height: 28),

                      Text(
                        TextStrings.signupSubTitle,
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
                        controller: _nameController,
                        autofocus: false,
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.name,
                        decoration: _buildInputDecoration('Full Name'),
                        style: const TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your full name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

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
                        onChanged: (_) => setState(() {}),
                      ),
                      const SizedBox(height: 8),

                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildPasswordRule(
                              'At least 8 characters',
                              _passwordController.text.length >= 8,
                            ),
                            buildPasswordRule(
                              'At least 1 capital letter',
                              RegExp(
                                r'[A-Z]',
                              ).hasMatch(_passwordController.text),
                            ),
                            buildPasswordRule(
                              'At least 1 digit',
                              RegExp(r'\d').hasMatch(_passwordController.text),
                            ),
                            buildPasswordRule(
                              'At least 1 special character (!@#\$&*~)',
                              RegExp(
                                r'[!@#\$&*~]',
                              ).hasMatch(_passwordController.text),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: _agreedToTerms,
                            onChanged: (bool? value) {
                              setState(() => _agreedToTerms = value ?? false);
                            },
                            activeColor: const Color(0xFFB59D82),
                            checkColor: Colors.white,
                          ),
                          Text(
                            TextStrings.terms,
                            style: const TextStyle(
                              fontFamily: "Poppins",
                              color: Colors.black54,
                              fontSize: 10,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) =>
                                      const TermsAndConditionsScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              "Terms & Conditions",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                decoration: TextDecoration.underline,
                                color: Colors.black,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          return SlideButton(
                            text: "\t\t\tCreate Account",
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
                            "Already have an account? ",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              color: Colors.black54,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Text(
                              'Log In',
                              style: TextStyle(
                                fontFamily: "Poppins",
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
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
    );
  }

  InputDecoration _buildInputDecoration(
    String label, {
    bool isPassword = false,
  }) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
        fontFamily: "Poppins",
        color: Colors.grey.shade600,
      ),
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
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: Colors.grey.shade600,
              ),
              onPressed: () {
                setState(() => _isPasswordVisible = !_isPasswordVisible);
              },
            )
          : null,
    );
  }
}
