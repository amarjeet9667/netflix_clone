// lib/features/auth/presentation/pages/register_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:netflix_clone/core/constants/app_colors.dart';
import 'package:netflix_clone/core/constants/app_sizes.dart';
import 'package:netflix_clone/core/constants/app_strings.dart';
import 'package:netflix_clone/core/constants/app_text_style.dart';
import 'package:netflix_clone/core/router/route_names.dart';
import '../bloc/auth_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey        = GlobalKey<FormState>();
  final _emailCtrl      = TextEditingController();
  final _passwordCtrl   = TextEditingController();
  final _confirmCtrl    = TextEditingController();
  bool  _obscure        = true;
  bool  _obscureConfirm = true;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(AuthRegisterEvent(
        email:    _emailCtrl.text.trim(),
        password: _passwordCtrl.text,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          context.go(RouteNames.whoIsWatching);
        }
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message),
              backgroundColor: AppColors.error),
          );
        }
      },
      child: Scaffold(
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
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.spaceXXL,
            vertical:   AppSizes.spaceXL,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(AppStrings.signUp, style: AppTextStyles.headlineMedium),
                const SizedBox(height: AppSizes.spaceSM),
                Text(
                  'Watch anywhere. Cancel anytime.',
                  style: AppTextStyles.bodyMedium,
                ),
                const SizedBox(height: AppSizes.spaceXXL),

                // Email
                _Field(
                  controller:   _emailCtrl,
                  label:        AppStrings.emailHint,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Required';
                    if (!v.contains('@')) return AppStrings.invalidEmail;
                    return null;
                  },
                ),
                const SizedBox(height: AppSizes.spaceMD),

                // Password
                _Field(
                  controller:  _passwordCtrl,
                  label:       AppStrings.passwordHint,
                  obscureText: _obscure,
                  suffix: _EyeIcon(
                    obscure:   _obscure,
                    onToggle: () => setState(() => _obscure = !_obscure),
                  ),
                  validator: (v) {
                    if (v == null || v.length < 6) return AppStrings.invalidPassword;
                    return null;
                  },
                ),
                const SizedBox(height: AppSizes.spaceMD),

                // Confirm password
                _Field(
                  controller:  _confirmCtrl,
                  label:       AppStrings.confirmPassword,
                  obscureText: _obscureConfirm,
                  suffix: _EyeIcon(
                    obscure:   _obscureConfirm,
                    onToggle: () => setState(() => _obscureConfirm = !_obscureConfirm),
                  ),
                  validator: (v) {
                    if (v != _passwordCtrl.text) return AppStrings.passwordMismatch;
                    return null;
                  },
                ),
                const SizedBox(height: AppSizes.spaceXXL),

                // Agree text
                Text(
                  'By continuing, you agree to our Terms of Use and Privacy Policy.',
                  style: AppTextStyles.labelSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSizes.spaceMD),

                // Sign Up button
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    final loading = state is AuthLoading;
                    return SizedBox(
                      height: AppSizes.btnHeightXL,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.netflixRed,
                          foregroundColor: AppColors.textPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppSizes.radiusSM),
                          ),
                        ),
                        onPressed: loading ? null : _submit,
                        child: loading
                            ? const SizedBox(
                                width: 24, height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColors.textPrimary,
                                ),
                              )
                            : Text(
                                AppStrings.signUp,
                                style: AppTextStyles.btnPrimary.copyWith(
                                  color: AppColors.textPrimary,
                                ),
                              ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: AppSizes.spaceXL),

                // Login link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppStrings.alreadyAccount,
                        style: AppTextStyles.bodyMedium),
                    GestureDetector(
                      onTap: () => context.go(RouteNames.login),
                      child: Text(
                        AppStrings.signIn,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color:      AppColors.textPrimary,
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Field extends StatelessWidget {
  final TextEditingController      controller;
  final String                     label;
  final bool                       obscureText;
  final TextInputType?             keyboardType;
  final Widget?                    suffix;
  final String? Function(String?)? validator;

  const _Field({
    required this.controller,
    required this.label,
    this.obscureText  = false,
    this.keyboardType,
    this.suffix,
    this.validator,
  });

  @override
  Widget build(BuildContext context) => TextFormField(
    controller:   controller,
    obscureText:  obscureText,
    keyboardType: keyboardType,
    validator:    validator,
    style:        AppTextStyles.inputText,
    cursorColor:  AppColors.textPrimary,
    decoration: InputDecoration(
      labelText:  label,
      suffixIcon: suffix,
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
          color: AppColors.inputBorderFocus, width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.inputRadius),
        borderSide: const BorderSide(color: AppColors.inputBorderError),
      ),
    ),
  );
}

class _EyeIcon extends StatelessWidget {
  final bool       obscure;
  final VoidCallback onToggle;
  const _EyeIcon({required this.obscure, required this.onToggle});
  @override
  Widget build(BuildContext context) => IconButton(
    icon: Icon(
      obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
      color: AppColors.textTertiary,
      size:  AppSizes.iconMD,
    ),
    onPressed: onToggle,
  );
}