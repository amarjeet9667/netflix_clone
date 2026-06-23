import 'package:flutter/material.dart';
import 'package:netflix_clone/core/constants/app_colors.dart';


// ============================================================
//  AppTextStyles — Typography system
//  Font: Netflix Sans (fallback: Helvetica Neue → sans-serif)
//  All sizes follow the type scale below
// ============================================================

class AppTextStyles {
  AppTextStyles._();

  // ══ Font Family ══════════════════════════════════════════
  static const String _fontFamily = 'NetflixSans'; // add to pubspec assets

  // ══ Type Scale ═══════════════════════════════════════════
  // Display  36 / 42 / 48  — hero banner title
  // Headline 24 / 28 / 32  — section titles, detail page titles
  // Title    18 / 20       — card titles, row labels
  // Body     14 / 16       — descriptions, overviews
  // Label    12 / 13       — meta, badges, captions
  // Micro    10 / 11       — legal, timestamps

  // ── Display ──────────────────────────────────────────────
  static const TextStyle displayLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 48,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -1.0,
    height: 1.1,
  );

  static const TextStyle displayMedium = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 42,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.8,
    height: 1.15,
  );

  static const TextStyle displaySmall = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 36,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
    height: 1.2,
  );

  // ── Headline ─────────────────────────────────────────────
  static const TextStyle headlineLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
    height: 1.25,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: -0.3,
    height: 1.3,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: -0.2,
    height: 1.3,
  );

  // ── Title ─────────────────────────────────────────────────
  static const TextStyle titleLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: 0,
    height: 1.4,
  );

  static const TextStyle titleMedium = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: 0,
    height: 1.4,
  );

  static const TextStyle titleSmall = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: 0.1,
    height: 1.4,
  );

  // ── Body ──────────────────────────────────────────────────
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    letterSpacing: 0.1,
    height: 1.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    letterSpacing: 0.1,
    height: 1.5,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    letterSpacing: 0.2,
    height: 1.5,
  );

  // ── Label ─────────────────────────────────────────────────
  static const TextStyle labelLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    letterSpacing: 0.1,
    height: 1.4,
  );

  static const TextStyle labelMedium = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    letterSpacing: 0.5,
    height: 1.4,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: AppColors.textTertiary,
    letterSpacing: 0.5,
    height: 1.4,
  );

  // ── Micro ─────────────────────────────────────────────────
  static const TextStyle micro = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: AppColors.textTertiary,
    letterSpacing: 0.5,
    height: 1.4,
  );

  // ══ Semantic / Usage-specific aliases ════════════════════

  // Home row section title ("Trending Now", "Top 10 in India")
  static const TextStyle rowTitle = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: 0,
  );

  // Hero banner main title
  static const TextStyle heroBannerTitle = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 40,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
    letterSpacing: -1.0,
    height: 1.1,
    shadows: [Shadow(color: AppColors.black60, blurRadius: 8)],
  );

  // Hero banner genre tags ("Sci-Fi • Horror • Drama")
  static const TextStyle heroBannerGenre = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    letterSpacing: 0.2,
  );

  // Movie overview / description text
  static const TextStyle overview = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.6,
    letterSpacing: 0.1,
  );

  // Maturity rating badge ("TV-MA", "PG-13")
  static const TextStyle maturityBadge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 11,
    fontWeight: FontWeight.w600,
    color: AppColors.maturityText,
    letterSpacing: 0.5,
  );

  // Match score ("97% Match")
  static const TextStyle matchScore = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 13,
    fontWeight: FontWeight.w700,
    color: AppColors.matchScore,
    letterSpacing: 0,
  );

  // Top-10 large number overlay
  static const TextStyle top10Number = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 96,
    fontWeight: FontWeight.w900,
    color: AppColors.textPrimary,
    letterSpacing: -4.0,
    height: 1.0,
  );

  // Button label — primary
  static const TextStyle btnPrimary = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: AppColors.btnPlayText,
    letterSpacing: 0.2,
  );

  // Button label — secondary / ghost
  static const TextStyle btnSecondary = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: 0.2,
  );

  // Nav bar label
  static const TextStyle navLabel = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.3,
  );

  // Input field text
  static const TextStyle inputText = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  // Input label (floating)
  static const TextStyle inputLabel = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.inputLabelFloat,
  );

  // Error text under inputs
  static const TextStyle inputError = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.error,
    height: 1.4,
  );

  // Episode number + duration
  static const TextStyle episodeMeta = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.textTertiary,
    letterSpacing: 0.2,
  );

  // Cast name
  static const TextStyle castName = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  // Section "See All" link
  static const TextStyle seeAll = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textTertiary,
    letterSpacing: 0.2,
  );
}