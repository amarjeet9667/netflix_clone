// lib/features/auth/presentation/pages/splash_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:netflix_clone/core/constants/app_colors.dart';
import 'package:netflix_clone/core/constants/app_durations.dart';
import 'package:netflix_clone/core/router/route_names.dart';
import '../bloc/auth_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double>   _scale;
  late final Animation<double>   _fade;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync:    this,
      duration: AppDurations.splashLogoAnim,
    );
    _scale = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOutBack),
    );
    _fade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeIn),
    );
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _navigate(BuildContext context, AuthState state) {
    if (state is AuthAuthenticated) {
      context.go(RouteNames.whoIsWatching);
    } else if (state is AuthUnauthenticated) {
      context.go(RouteNames.onboarding);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) => _navigate(context, state),
      child: Scaffold(
        backgroundColor: AppColors.bgSplash,
        body: Center(
          child: AnimatedBuilder(
            animation: _ctrl,
            builder: (_, __) => FadeTransition(
              opacity: _fade,
              child:   ScaleTransition(
                scale: _scale,
                child: const _NetflixWordmark(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NetflixWordmark extends StatelessWidget {
  const _NetflixWordmark();
  @override
  Widget build(BuildContext context) {
    return Text(
      'NETFLIX',
      style: TextStyle(
        fontFamily:     'NetflixSans',
        fontSize:       52,
        fontWeight:     FontWeight.w900,
        color:          AppColors.netflixRed,
        letterSpacing:  4,
      ),
    );
  }
}