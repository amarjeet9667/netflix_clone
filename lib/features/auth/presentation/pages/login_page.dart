// lib/features/auth/presentation/pages/login_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:netflix_clone/core/constants/app_colors.dart';
import 'package:netflix_clone/core/constants/app_sizes.dart';
import 'package:netflix_clone/core/constants/app_text_style.dart';
import 'package:netflix_clone/core/constants/app_strings.dart';
import 'package:netflix_clone/core/router/route_names.dart';
import '../bloc/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey      = GlobalKey<FormState>();
  final _emailCtrl    = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool  _obscure      = true;
  bool  _rememberMe   = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(AuthLoginEvent(
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
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.bgPrimary,
        body: Stack(
          children: [
            // Background image
            Positioned.fill(
              child: Image.network(
                'https://img.dummyjson.com/product-images/1/2.webp',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const SizedBox.shrink(),
              ),
            ),
            // Dark overlay
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.bgPrimary.withValues(alpha: 0.85),
                ),
              ),
            ),
            // Content
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.spaceXXL,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: AppSizes.space3XL),

                    // Netflix logo
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'NETFLIX',
                        style: AppTextStyles.headlineLarge.copyWith(
                          color:         AppColors.netflixRed,
                          fontWeight:    FontWeight.w900,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSizes.space5XL),

                    Text(AppStrings.signIn, style: AppTextStyles.headlineMedium),
                    const SizedBox(height: AppSizes.spaceXXL),

                    // Form
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Email
                          _NetflixTextField(
                            controller:  _emailCtrl,
                            label:       AppStrings.emailHint,
                            keyboardType: TextInputType.emailAddress,
                            validator: (v) {
                              if (v == null || v.isEmpty) return 'Required';
                              if (!v.contains('@')) return AppStrings.invalidEmail;
                              return null;
                            },
                          ),
                          const SizedBox(height: AppSizes.spaceMD),

                          // Password
                          _NetflixTextField(
                            controller:  _passwordCtrl,
                            label:       AppStrings.passwordHint,
                            obscureText: _obscure,
                            suffix: IconButton(
                              icon: Icon(
                                _obscure
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: AppColors.textTertiary,
                                size:  AppSizes.iconMD,
                              ),
                              onPressed: () => setState(() => _obscure = !_obscure),
                            ),
                            validator: (v) {
                              if (v == null || v.isEmpty) return 'Required';
                              if (v.length < 6) return AppStrings.invalidPassword;
                              return null;
                            },
                          ),
                          const SizedBox(height: AppSizes.spaceSM),

                          // Remember me
                          Row(
                            children: [
                              SizedBox(
                                width: 20, height: 20,
                                child: Checkbox(
                                  value:         _rememberMe,
                                  onChanged:     (v) => setState(() => _rememberMe = v ?? false),
                                  activeColor:   AppColors.netflixRed,
                                  checkColor:    AppColors.textPrimary,
                                  side: const BorderSide(
                                    color: AppColors.textTertiary,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                              ),
                              const SizedBox(width: AppSizes.spaceXS),
                              Text(
                                AppStrings.rememberMe,
                                style: AppTextStyles.bodySmall,
                              ),
                              const Spacer(),
                              TextButton(
                                onPressed: () => context.go(RouteNames.forgotPass),
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: Size.zero,
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Text(
                                  AppStrings.forgotPassword,
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSizes.spaceXXL),

                          // Sign In button
                          BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                              final loading = state is AuthLoading;
                              return SizedBox(
                                width:  double.infinity,
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
                                          AppStrings.signIn,
                                          style: AppTextStyles.btnPrimary.copyWith(
                                            color: AppColors.textPrimary,
                                          ),
                                        ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: AppSizes.spaceXL),

                          // OR divider
                          Row(
                            children: [
                              const Expanded(child: Divider(color: AppColors.divider)),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSizes.spaceMD,
                                ),
                                child: Text(
                                  AppStrings.orContinueWith,
                                  style: AppTextStyles.labelMedium,
                                ),
                              ),
                              const Expanded(child: Divider(color: AppColors.divider)),
                            ],
                          ),
                          const SizedBox(height: AppSizes.spaceXL),

                          // Register link
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppStrings.dontHaveAccount,
                                style: AppTextStyles.bodyMedium,
                              ),
                              GestureDetector(
                                onTap: () => context.go(RouteNames.register),
                                child: Text(
                                  AppStrings.signUp,
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Reusable Netflix-styled text field ────────────────────────
class _NetflixTextField extends StatelessWidget {
  final TextEditingController  controller;
  final String                 label;
  final bool                   obscureText;
  final TextInputType?         keyboardType;
  final Widget?                suffix;
  final String? Function(String?)? validator;

  const _NetflixTextField({
    required this.controller,
    required this.label,
    this.obscureText   = false,
    this.keyboardType,
    this.suffix,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller:   controller,
      obscureText:  obscureText,
      keyboardType: keyboardType,
      validator:    validator,
      style:        AppTextStyles.inputText,
      cursorColor:  AppColors.textPrimary,
      decoration: InputDecoration(
        labelText:   label,
        suffixIcon:  suffix,
        filled:      true,
        fillColor:   AppColors.inputBg,
        labelStyle:  AppTextStyles.inputLabel,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.inputRadius),
          borderSide:   const BorderSide(color: AppColors.inputBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.inputRadius),
          borderSide:   const BorderSide(color: AppColors.inputBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.inputRadius),
          borderSide:   const BorderSide(
            color: AppColors.inputBorderFocus,
            width: AppSizes.inputBorderFocW,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.inputRadius),
          borderSide:   const BorderSide(color: AppColors.inputBorderError),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.inputRadius),
          borderSide:   const BorderSide(
            color: AppColors.inputBorderError,
            width: AppSizes.inputBorderFocW,
          ),
        ),
      ),
    );
  }
}