import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:striv/auth/widgets/auth_slider.dart';
import 'package:striv/constants.dart';
import 'package:striv/core/helpers/account_password_rule.dart';
import 'package:striv/pages/navigation.dart';
import 'package:striv/terms_and_conditions.dart';

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
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(const AssetImage(AssetPaths.splashbg), context);
  }

  bool _isPasswordValid() {
    final value = _passwordController.text;
    return value.length >= 8 &&
        RegExp(r'[A-Z]').hasMatch(value) &&
        RegExp(r'\d').hasMatch(value) &&
        RegExp(r'[!@#\$&*~]').hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetPaths.splashbg),
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
                      TextStrings.signupTitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Revalia",
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF3D3D3D),
                      ),
                    ),
                    const SizedBox(height: 28),

                    Text(
                      TextStrings.signupSubTitle,
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
                      controller: _nameController,
                      autofocus: false,
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.name,
                      decoration: _buildInputDecoration('Full Name'),
                      style: TextStyle(fontFamily: "Poppins", fontSize: 14),
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
                            RegExp(r'[A-Z]').hasMatch(_passwordController.text),
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
                          style: TextStyle(
                            fontFamily: "Poppins",
                            color: Colors.black54,
                            fontSize: 10,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (context) =>
                                    const TermsAndConditionsScreen(),
                              ),
                            );
                          },
                          child: Text(
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

                    SlideButton(
                      text: "\t\t\tCreate Account",
                      enabled: true,
                      onSlideComplete: () async {
                        setState(() => _submitted = true);

                        if (_formKey.currentState?.validate() != true ||
                            !_isPasswordValid() ||
                            !_agreedToTerms) {
                          return;
                        }
                        // await Future.delayed(const Duration(milliseconds: 300));
                        // showDialog(
                        //   context: context,
                        //   barrierDismissible: false,
                        //   builder: (context) =>
                        //       VerifyEmailDialog(email: _emailController.text),
                        // );

                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => Navigation(),
                          ),
                        );

                        // try {
                        //   await AuthService().signup(
                        //     _nameController.text,
                        //     _emailController.text,
                        //     _passwordController.text,
                        //   );

                        //   if (!mounted) return;

                        //   Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute<void>(
                        //       builder: (context) => const HomeScreen(),
                        //     ),
                        //   );

                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     const SnackBar(
                        //       content: Text("Account created successfully!"),
                        //       duration: Duration(seconds: 2),
                        //     ),
                        //   );
                        // } catch (e) {
                        //   if (!mounted) return;
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     SnackBar(
                        //       content: Text(e.toString()),
                        //       duration: const Duration(seconds: 3),
                        //     ),
                        //   );
                        // }
                      },
                    ),

                    const SizedBox(height: 24),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            color: Colors.black54,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Text(
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
    );
  }

  InputDecoration _buildInputDecoration(
    String label, {
    bool isPassword = false,
  }) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(fontFamily: "Poppins", color: Colors.grey.shade600),
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
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
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
