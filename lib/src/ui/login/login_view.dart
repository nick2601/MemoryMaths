import 'package:flutter/material.dart';
import 'package:mathsgames/src/core/dyslexic_theme.dart';
import 'package:mathsgames/src/ui/signup/signup_screen.dart';
import 'package:provider/provider.dart';
import '../../core/app_constant.dart';
import '../app/auth_provider.dart';

/// Login screen with dyslexic-friendly design
/// Features high contrast colors, readable fonts, and optimized input fields
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _obscurePassword = true;

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

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<AuthProvider>(context, listen: false)
          .login(_usernameController.text.trim(), _passwordController.text);
      Navigator.pushReplacementNamed(context, KeyUtil.dashboard);
    } catch (e) {
      _showErrorSnackBar(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showErrorSnackBar(String message) {
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
        duration: Duration(seconds: 4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DyslexicTheme.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
            ),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: SlideTransition(
              position: _slideAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Welcome header with dyslexic-friendly design
                  _buildHeader(),

                  SizedBox(height: 48),

                  // Login form card
                  _buildLoginCard(),

                  SizedBox(height: 32),

                  // Signup link
                  _buildSignupLink(),
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
        // App icon with enhanced styling
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: DyslexicTheme.primaryColor.withValues(alpha: 0.15),
                blurRadius: 25,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Icon(
            Icons.calculate_outlined,
            size: 60,
            color: DyslexicTheme.primaryColor,
          ),
        ),

        SizedBox(height: 24),

        // Welcome title
        Text(
          'Welcome Back!',
          style: TextStyle(
            fontFamily: DyslexicTheme.dyslexicFont,
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: DyslexicTheme.primaryTextColor,
            letterSpacing: 0.5,
            height: 1.2,
          ),
          textAlign: TextAlign.center,
        ),

        SizedBox(height: 12),

        // Subtitle
        Text(
          'Sign in to continue your math journey',
          style: TextStyle(
            fontFamily: DyslexicTheme.dyslexicFont,
            fontSize: 18,
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

  Widget _buildLoginCard() {
    return Container(
      padding: EdgeInsets.all(32),
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
            // Username field with enhanced accessibility
            TextFormField(
              controller: _usernameController,
              style: DyslexicInputTheme.getInputTextStyle(),
              decoration: DyslexicInputTheme.getInputDecoration(
                labelText: 'Username',
                prefixIcon: Icons.person_outline_rounded,
                hintText: 'Enter your username',
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your username';
                }
                if (value.trim().length < 3) {
                  return 'Username must be at least 3 characters';
                }
                return null;
              },
              textInputAction: TextInputAction.next,
            ),

            SizedBox(height: 24),

            // Password field with visibility toggle
            TextFormField(
              controller: _passwordController,
              style: DyslexicInputTheme.getInputTextStyle(),
              obscureText: _obscurePassword,
              decoration: DyslexicInputTheme.getInputDecoration(
                labelText: 'Password',
                prefixIcon: Icons.lock_outline_rounded,
                hintText: 'Enter your password',
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                    color: DyslexicTheme.secondaryTextColor,
                  ),
                  onPressed: _togglePasswordVisibility,
                  tooltip: _obscurePassword ? 'Show password' : 'Hide password',
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _login(),
            ),

            SizedBox(height: 36),

            // Login button with enhanced styling
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
                  onPressed: _login,
                  style: DyslexicButtonTheme.getPrimaryButtonStyle(),
                  child: Text('Sign In'),
                ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignupLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'New to Memory Math? ',
          style: TextStyle(
            fontFamily: DyslexicTheme.dyslexicFont,
            fontSize: DyslexicTheme.baseFontSize,
            color: DyslexicTheme.secondaryTextColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        TextButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => SignupScreen()),
          ),
          style: DyslexicButtonTheme.getSecondaryButtonStyle(),
          child: Text('Create Account'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _slideController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
