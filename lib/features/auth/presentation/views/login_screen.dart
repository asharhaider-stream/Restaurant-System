import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../src/shared widgets/common_button.dart';
import '../../../../src/utils/constants.dart';
import '../../../../src/utils/extensions.dart';
import '../../../../src/shared widgets/custom_text_field.dart';

/// Login Screen
/// Email/password login with social auth options
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _onLoginPressed() async {
    context.hideKeyboard();

    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() => _isLoading = false);
      context.showSuccessSnackBar('Login successful!');
      context.go('/menu');
    }
  }

  void _onForgotPasswordPressed() {
    // Navigate to forgot password (will build later)
    context.showSnackBar('Forgot password screen coming soon');
  }

  void _onSignUpPressed() {
    // Navigate to signup (will build later)
    context.showSnackBar('Sign up screen coming soon');
  }

  void _onGoogleLoginPressed() {
    context.showSnackBar('Google login coming soon');
  }

  void _onAppleLoginPressed() {
    context.showSnackBar('Apple login coming soon');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back Button
                // IconButton(
                //   onPressed: () => context.pop(),
                //   icon: const Icon(Icons.arrow_back_rounded),
                //   style: IconButton.styleFrom(
                //     backgroundColor: Colors.white,
                //     padding: const EdgeInsets.all(AppSpacing.sm),
                //   ),
                // ),

                // const SizedBox(height: AppSpacing.lg),

                // Title
                Center(
                  child: Text(
                    AppStrings.login,
                    style: AppTextStyles.h2,
                  ),
                ),

                const SizedBox(height: AppSpacing.xl),

                // Logo
                Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppColors.accent.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.restaurant_rounded,
                      size: 50,
                      color: AppColors.primary,
                    ),
                  ),
                ),

                const SizedBox(height: AppSpacing.lg),

                // Welcome Text
                Center(
                  child: Column(
                    children: [
                      Text(
                        'Welcome Back!',
                        style: AppTextStyles.h3,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        'Log in to your favorite flavors.',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.xxl),

                // Email Field
                CustomTextField(
                  controller: _emailController,
                  label: AppStrings.email,
                  hintText: 'hello@flavor.com',
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.isValidEmail) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: AppSpacing.lg),

                // Password Field
                CustomTextField(
                  controller: _passwordController,
                  label: AppStrings.password,
                  hintText: '••••••••',
                  prefixIcon: Icons.lock_outline_rounded,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: AppSpacing.md),

                // Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: _onForgotPasswordPressed,
                    child: Text(
                      AppStrings.forgotPassword,
                      style: AppTextStyles.labelMedium.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: AppSpacing.lg),

                // Login Button
                CustomButton.primary(
                  text: AppStrings.login,
                  onPressed: _onLoginPressed,
                  isLoading: _isLoading,
                  isFullWidth: true,
                  icon: Icons.arrow_forward_rounded,
                  height: 56,
                ),

                const SizedBox(height: AppSpacing.xl),

                // Divider
                Row(
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                      ),
                      child: Text(
                        'OR CONTINUE WITH',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.secondary,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),

                const SizedBox(height: AppSpacing.xl),

                // Social Login Buttons
                Row(
                  children: [
                    Expanded(
                      child: _buildSocialButton(
                        onPressed: _onGoogleLoginPressed,
                        icon: Icons.g_mobiledata_rounded,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: _buildSocialButton(
                        onPressed: _onAppleLoginPressed,
                        icon: Icons.apple_rounded,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: AppSpacing.xl),

                // Sign Up Link
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: AppTextStyles.bodyMedium,
                      ),
                      TextButton(
                        onPressed: _onSignUpPressed,
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(0, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          'Sign Up',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required VoidCallback onPressed,
    required IconData icon,
  }) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        side: BorderSide(color: AppColors.secondary, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        ),
      ),
      child: Icon(
        icon,
        size: AppSpacing.iconLg,
        color: AppColors.textPrimary,
      ),
    );
  }
}
