import 'package:flutter/material.dart';
import 'package:mathsgames/src/core/dyslexic_theme.dart';
import 'package:provider/provider.dart';
import '../app/auth_provider.dart';
import '../login/login_view.dart';

/// Signup screen with dyslexic-friendly design
/// Features high contrast colors, readable fonts, and optimized input fields
class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> with TickerProviderStateMixin {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;

  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize slide animation for smooth entrance
    _slideController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _slideController.forward();
  }

  @override
  void dispose() {
    _slideController.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  /// Validates email format using regex
  bool _isValidEmail(String email) {
    return RegExp(r'^[\w.-]+@[\w.-]+\.[A-Za-z]{2,}$').hasMatch(email);
  }

  /// Shows success message with dyslexic-friendly styling
  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            fontFamily: DyslexicTheme.dyslexicFont,
            fontSize: DyslexicTheme.baseFontSize,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: DyslexicTheme.successColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DyslexicTheme.borderRadius),
        ),
        duration: Duration(seconds: 4),
      ),
    );
  }

  /// Shows error message with dyslexic-friendly styling
  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            fontFamily: DyslexicTheme.dyslexicFont,
            fontSize: DyslexicTheme.baseFontSize,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: DyslexicTheme.errorColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DyslexicTheme.borderRadius),
        ),
        duration: Duration(seconds: 5),
      ),
    );
  }

  /// Handles the signup process
  Future<void> _handleSignup() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<AuthProvider>(context, listen: false).signup(
        _usernameController.text.trim(),
        _emailController.text.trim().toLowerCase(),
        _passwordController.text,
        _fullNameController.text.trim(),
      );

      _showSuccessMessage(
        'Account created successfully! Your profile has been set up for progress tracking.',
      );

      // Navigate to dashboard after successful signup
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/dashboard',
          (route) => false,
        );
      });
    } catch (e) {
      _showErrorMessage(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DyslexicTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: DyslexicTheme.primaryTextColor,
          ),
          onPressed: () => Navigator.pop(context),
          tooltip: 'Go back to login',
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - kToolbarHeight - MediaQuery.of(context).padding.top,
            ),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: SlideTransition(
              position: _slideAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header section
                  _buildHeader(),

                  SizedBox(height: 32),

                  // Signup form card
                  _buildSignupCard(),

                  SizedBox(height: 24),

                  // Login link
                  _buildLoginLink(),

                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // App icon
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: DyslexicTheme.primaryColor.withValues(alpha: 0.15),
                blurRadius: 20,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Icon(
            Icons.person_add_outlined,
            size: 50,
            color: DyslexicTheme.primaryColor,
          ),
        ),

        SizedBox(height: 20),

        // Title
        Text(
          'Create Account',
          style: TextStyle(
            fontFamily: DyslexicTheme.dyslexicFont,
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: DyslexicTheme.primaryTextColor,
            letterSpacing: 0.5,
            height: 1.2,
          ),
          textAlign: TextAlign.center,
        ),

        SizedBox(height: 8),

        // Subtitle
        Text(
          'Join Memory Math and track your progress!',
          style: TextStyle(
            fontFamily: DyslexicTheme.dyslexicFont,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: DyslexicTheme.secondaryTextColor,
            letterSpacing: 0.3,
            height: 1.4,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildSignupCard() {
    return Container(
      padding: EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: DyslexicTheme.primaryColor.withValues(alpha: 0.08),
            blurRadius: 30,
            offset: Offset(0, 15),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Full Name Field
            TextFormField(
              controller: _fullNameController,
              style: DyslexicInputTheme.getInputTextStyle(),
              decoration: DyslexicInputTheme.getInputDecoration(
                labelText: 'Full Name',
                prefixIcon: Icons.person_outline_rounded,
                hintText: 'Enter your full name',
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your full name';
                }
                if (value.trim().length < 2) {
                  return 'Name must be at least 2 characters';
                }
                return null;
              },
              textInputAction: TextInputAction.next,
            ),

            SizedBox(height: 20),

            // Email Field
            TextFormField(
              controller: _emailController,
              style: DyslexicInputTheme.getInputTextStyle(),
              keyboardType: TextInputType.emailAddress,
              decoration: DyslexicInputTheme.getInputDecoration(
                labelText: 'Email Address',
                prefixIcon: Icons.email_outlined,
                hintText: 'Enter your email address',
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your email address';
                }
                if (!_isValidEmail(value.trim())) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
              textInputAction: TextInputAction.next,
            ),

            SizedBox(height: 20),

            // Username Field
            TextFormField(
              controller: _usernameController,
              style: DyslexicInputTheme.getInputTextStyle(),
              decoration: DyslexicInputTheme.getInputDecoration(
                labelText: 'Username',
                prefixIcon: Icons.account_circle_outlined,
                hintText: 'Choose a username',
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a username';
                }
                if (value.trim().length < 3) {
                  return 'Username must be at least 3 characters';
                }
                return null;
              },
              textInputAction: TextInputAction.next,
            ),

            SizedBox(height: 20),

            // Password Field
            TextFormField(
              controller: _passwordController,
              style: DyslexicInputTheme.getInputTextStyle(),
              obscureText: !_isPasswordVisible,
              decoration: DyslexicInputTheme.getInputDecoration(
                labelText: 'Password',
                prefixIcon: Icons.lock_outline_rounded,
                hintText: 'Create a password',
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: DyslexicTheme.secondaryTextColor,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                  tooltip: _isPasswordVisible ? 'Hide password' : 'Show password',
                ),
              ),
              validator: (value) {
                if (value == null || value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
              textInputAction: TextInputAction.next,
            ),

            SizedBox(height: 20),

            // Confirm Password Field
            TextFormField(
              controller: _confirmPasswordController,
              style: DyslexicInputTheme.getInputTextStyle(),
              obscureText: !_isConfirmPasswordVisible,
              decoration: DyslexicInputTheme.getInputDecoration(
                labelText: 'Confirm Password',
                prefixIcon: Icons.lock_clock_outlined,
                hintText: 'Confirm your password',
                suffixIcon: IconButton(
                  icon: Icon(
                    _isConfirmPasswordVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: DyslexicTheme.secondaryTextColor,
                  ),
                  onPressed: () {
                    setState(() {
                      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                    });
                  },
                  tooltip: _isConfirmPasswordVisible ? 'Hide password' : 'Show password',
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please confirm your password';
                }
                if (value != _passwordController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _handleSignup(),
            ),

            SizedBox(height: 36),

            // Sign Up Button
            _isLoading
                ? Container(
                    height: DyslexicTheme.buttonHeight,
                    child: Center(
                      child: SizedBox(
                        width: 32,
                        height: 32,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            DyslexicTheme.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  )
                : ElevatedButton(
                    onPressed: _handleSignup,
                    style: DyslexicButtonTheme.getPrimaryButtonStyle(),
                    child: Text('Create Account'),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account? ',
          style: TextStyle(
            fontFamily: DyslexicTheme.dyslexicFont,
            fontSize: DyslexicTheme.baseFontSize,
            color: DyslexicTheme.secondaryTextColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => LoginScreen()),
          ),
          style: DyslexicButtonTheme.getSecondaryButtonStyle(),
          child: Text('Sign In'),
        ),
      ],
    );
  }
}
