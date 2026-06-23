// ============================================================
//  router_transitions.dart
//  lib/core/router/router_transitions.dart
//
//  Custom page transitions for GoRouter
//  Netflix uses:
//   - fade       → splash, login, who-is-watching
//   - slideUp    → detail pages (bottom sheet feel)
//   - slide      → nested / sub pages (left→right)
//   - noTransition → bottom nav tabs, player
// ============================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants/app_durations.dart';

class RouterTransitions {
  RouterTransitions._();

  // ── Fade ─────────────────────────────────────────────────
  static CustomTransitionPage<void> fade({
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage<void>(
      key:          state.pageKey,
      child:        child,
      transitionDuration: AppDurations.pageTransition,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve:  Curves.easeInOut,
          ),
          child: child,
        );
      },
    );
  }

  // ── Slide (left → right, standard push) ──────────────────
  static CustomTransitionPage<void> slide({
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage<void>(
      key:          state.pageKey,
      child:        child,
      transitionDuration: AppDurations.pageTransition,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end:   Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve:  Curves.easeOutCubic,
          )),
          child: child,
        );
      },
    );
  }

  // ── Slide Up (bottom → top, detail/modal feel) ───────────
  static CustomTransitionPage<void> slideUp({
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage<void>(
      key:          state.pageKey,
      child:        child,
      transitionDuration: AppDurations.modalTransition,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 1.0),
            end:   Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve:  Curves.easeOutCubic,
          )),
          child: child,
        );
      },
    );
  }

  // ── Fade + Scale (like iOS sheet) ────────────────────────
  static CustomTransitionPage<void> fadeScale({
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage<void>(
      key:          state.pageKey,
      child:        child,
      transitionDuration: AppDurations.pageTransition,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: Curves.easeIn),
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.95, end: 1.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
            ),
            child: child,
          ),
        );
      },
    );
  }

  // ── No Transition (bottom nav tabs, player) ──────────────
  static NoTransitionPage<void> noTransition({
    required GoRouterState state,
    required Widget child,
  }) {
    return NoTransitionPage<void>(
      key:   state.pageKey,
      child: child,
    );
  }
}