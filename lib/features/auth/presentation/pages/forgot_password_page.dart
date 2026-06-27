// lib/features/auth/presentation/pages/forgot_password_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:netflix_clone/core/constants/app_colors.dart';
import 'package:netflix_clone/core/constants/app_sizes.dart';
import 'package:netflix_clone/core/constants/app_text_style.dart';
import 'package:netflix_clone/core/constants/app_strings.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});
  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey   = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  bool  _sent      = false;
  bool  _loading   = false;

  @override
  void dispose() { _emailCtrl.dispose(); super.dispose(); }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _loading = true);
    await Future.delayed(const Duration(seconds: 2)); // TODO: real call
    if (mounted) setState(() { _loading = false; _sent = true; });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,
              color: AppColors.textPrimary, size: AppSizes.iconMD),
          onPressed: () => context.pop(),
        ),
        title: Text('NETFLIX',
          style: AppTextStyles.titleMedium.copyWith(
            color: AppColors.netflixRed, fontWeight: FontWeight.w900,
            letterSpacing: 2,
          )),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.spaceXXL),
        child: _sent ? _SuccessView(email: _emailCtrl.text) : _FormView(
          formKey:   _formKey,
          emailCtrl: _emailCtrl,
          loading:   _loading,
          onSubmit:  _submit,
        ),
      ),
    );
  }
}

class _FormView extends StatelessWidget {
  final GlobalKey<FormState>   formKey;
  final TextEditingController  emailCtrl;
  final bool                   loading;
  final VoidCallback           onSubmit;
  const _FormView({
    required this.formKey,
    required this.emailCtrl,
    required this.loading,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: AppSizes.space3XL),
          Text('Forgot Password?', style: AppTextStyles.headlineMedium),
          const SizedBox(height: AppSizes.spaceSM),
          Text(
            'Enter the email address associated with your account and we\'ll send you a link to reset your password.',
            style: AppTextStyles.bodyMedium,
          ),
          const SizedBox(height: AppSizes.spaceXXL),
          TextFormField(
            controller:   emailCtrl,
            keyboardType: TextInputType.emailAddress,
            style:        AppTextStyles.inputText,
            cursorColor:  AppColors.textPrimary,
            validator: (v) {
              if (v == null || v.isEmpty) return 'Required';
              if (!v.contains('@')) return AppStrings.invalidEmail;
              return null;
            },
            decoration: InputDecoration(
              labelText:  AppStrings.emailHint,
              filled:     true,
              fillColor:  AppColors.inputBg,
              labelStyle: AppTextStyles.inputLabel,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizes.inputRadius),
                borderSide: const BorderSide(color: AppColors.inputBorder),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizes.inputRadius),
                borderSide: const BorderSide(color: AppColors.inputBorder),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizes.inputRadius),
                borderSide: const BorderSide(
                  color: AppColors.inputBorderFocus, width: 2),
              ),
            ),
          ),
          const SizedBox(height: AppSizes.spaceXXL),
          SizedBox(
            height: AppSizes.btnHeightXL,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.netflixRed,
                foregroundColor: AppColors.textPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.radiusSM),
                ),
              ),
              onPressed: loading ? null : onSubmit,
              child: loading
                  ? const SizedBox(
                      width: 24, height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2, color: AppColors.textPrimary,
                      ),
                    )
                  : const Text('Send Reset Link'),
            ),
          ),
        ],
      ),
    );
  }
}

class _SuccessView extends StatelessWidget {
  final String email;
  const _SuccessView({required this.email});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.mark_email_read_outlined,
            color: AppColors.success, size: 72),
        const SizedBox(height: AppSizes.spaceXL),
        Text('Check your email', style: AppTextStyles.headlineSmall),
        const SizedBox(height: AppSizes.spaceMD),
        Text(
          'We\'ve sent a password reset link to\n$email',
          style: AppTextStyles.bodyMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSizes.space3XL),
        SizedBox(
          width: double.infinity,
          height: AppSizes.btnHeightLG,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.textPrimary,
              side: const BorderSide(color: AppColors.dividerLight),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusSM),
              ),
            ),
            onPressed: () => context.pop(),
            child: const Text('Back to Sign In'),
          ),
        ),
      ],
    );
  }
}