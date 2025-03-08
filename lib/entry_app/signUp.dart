import 'package:flutter/material.dart';
import 'package:krishidost/entry_app/textfieldAuth.dart';
import 'package:krishidost/utility/extensions.dart';
import '../screens/login_screen/provider/user_provider.dart';

class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _agreeToTerms = false;
  final _formKey = GlobalKey<FormState>();

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    if (value.length < 3) {
      return 'Name must be at least 3 characters';
    }
    return null;
  }

  String? validateBusinessName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your business name';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    if (value.length != 10 || !RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Please enter a valid 10-digit phone number';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$').hasMatch(value)) {
      return 'Password must contain both letters and numbers';
    }
    return null;
  }

  void _handleSignUp(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      if (!_agreeToTerms) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please agree to the Terms & Conditions'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
      print(context.userProvider.buisnessNameController.text);
      Map<String, dynamic> data = {
        "name": context.userProvider.userNameController.text.toLowerCase(),
        "BuisnessName": context.userProvider.buisnessNameController.text,
        "password": context.userProvider.passwordController.text,
        "phoneNo": context.userProvider.phoneNumberController.text
      };
      bool response = await context.userProvider.register(data);
      if (response == true) {
        context.userProvider.clearFields();
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Stack(
        children: [
          // Background with dynamic gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  colorScheme.primaryContainer,
                  colorScheme.surface,
                ],
              ),
            ),
          ),
          // Main content
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 8),
                    // Logo and welcome text
                    Center(
                      child: Hero(
                        tag: 'app_logo',
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: colorScheme.surface,
                            boxShadow: [
                              BoxShadow(
                                color: colorScheme.shadow.withOpacity(0.1),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Image.asset(
                            "assets/krishi_logo.png",
                            width: 80,
                            height: 80,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      "Create Account",
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: colorScheme.onSurface,
                                fontWeight: FontWeight.bold,
                              ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Join our farming community",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 18),
                    // Signup form
                    Card(
                      elevation: 0,
                      color: colorScheme.surface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFeildAuth(
                                text: "Full Name",
                                secure: false,
                                controller:
                                    context.userProvider.userNameController,
                                prefixIcon: Icon(Icons.person_outline,
                                    color: colorScheme.primary),
                                validator: validateName,
                              ),
                              const SizedBox(height: 16),
                              TextFeildAuth(
                                text: "Business Name",
                                secure: false,
                                controller:
                                    context.userProvider.buisnessNameController,
                                prefixIcon: Icon(Icons.business_outlined,
                                    color: colorScheme.primary),
                                validator: validateBusinessName,
                              ),
                              const SizedBox(height: 16),
                              TextFeildAuth(
                                text: "Phone Number",
                                secure: false,
                                controller:
                                    context.userProvider.phoneNumberController,
                                prefixIcon: Icon(Icons.phone_outlined,
                                    color: colorScheme.primary),
                                validator: validatePhone,
                              ),
                              const SizedBox(height: 16),
                              TextFeildAuth(
                                text: "Password",
                                isSuffixShow: true,
                                secure: true,
                                controller:
                                    context.userProvider.passwordController,
                                prefixIcon: Icon(Icons.lock_outline,
                                    color: colorScheme.primary),
                                validator: validatePassword,
                              ),
                              const SizedBox(height: 24),
                              // Terms and conditions
                              Row(
                                children: [
                                  Checkbox(
                                    value: _agreeToTerms,
                                    onChanged: (value) {
                                      setState(() {
                                        _agreeToTerms = value ?? false;
                                      });
                                    },
                                  ),
                                  Expanded(
                                    child: Text(
                                      "I agree to the Terms & Conditions and Privacy Policy",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color: colorScheme.onSurfaceVariant,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              // Sign up button
                              FilledButton(
                                onPressed: _agreeToTerms
                                    ? () => _handleSignUp(context)
                                    : null,
                                style: FilledButton.styleFrom(
                                  minimumSize: const Size(double.infinity, 56),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: const Text(
                                  "Sign Up",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 0),
                    // Login link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        TextButton(
                          onPressed: () {
                            context.userProvider.clearFields();
                            Navigator.pop(context);
                          },
                          child: const Text("Login"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
