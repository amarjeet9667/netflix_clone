import 'package:flutter/material.dart';

// ============================================================
//  AppColors — Single source of truth for every color
//  Netflix design system — always dark theme
//  Never use Color() or Colors.* anywhere else in the app
// ============================================================

class AppColors {
  AppColors._();

  // ══ Brand ════════════════════════════════════════════════
  static const Color netflixRed       = Color(0xFFE50914); // primary brand
  static const Color netflixRedDark   = Color(0xFFB20710); // pressed / hover
  static const Color netflixRedLight  = Color(0xFFFF1E2D); // highlight

  // ══ Backgrounds ══════════════════════════════════════════
  static const Color bgPrimary        = Color(0xFF141414); // main scaffold
  static const Color bgSecondary      = Color(0xFF1F1F1F); // cards, sheets
  static const Color bgTertiary       = Color(0xFF2D2D2D); // elevated surfaces
  static const Color bgModal          = Color(0xFF242424); // bottom sheets / dialogs
  static const Color bgOverlay        = Color(0xFF000000); // scrim base
  static const Color bgSplash         = Color(0xFF000000); // splash screen

  // ══ Text ════════════════════════════════════════════════
  static const Color textPrimary      = Color(0xFFFFFFFF); // headings, titles
  static const Color textSecondary    = Color(0xFFB3B3B3); // subtitles, meta
  static const Color textTertiary     = Color(0xFF737373); // hints, placeholders
  static const Color textDisabled     = Color(0xFF4D4D4D); // disabled state
  static const Color textInverse      = Color(0xFF000000); // on light backgrounds
  static const Color textLink         = Color(0xFF0071EB); // hyperlinks

  // ══ Buttons ══════════════════════════════════════════════
  // Play button (white — Netflix standard)
  static const Color btnPlayBg        = Color(0xFFFFFFFF);
  static const Color btnPlayText      = Color(0xFF000000);
  static const Color btnPlayHover     = Color(0xFFE6E6E6);

  // More Info button (semi-transparent grey)
  static const Color btnSecondaryBg   = Color(0xFF6D6D6EB3); // 70% opacity grey
  static const Color btnSecondaryText = Color(0xFFFFFFFF);

  // Primary action (red)
  static const Color btnPrimaryBg     = netflixRed;
  static const Color btnPrimaryText   = Color(0xFFFFFFFF);
  static const Color btnPrimaryHover  = netflixRedDark;

  // Ghost / outline button
  static const Color btnGhostBorder   = Color(0xFFFFFFFF);
  static const Color btnGhostText     = Color(0xFFFFFFFF);

  // ══ Navigation ═══════════════════════════════════════════
  static const Color navBarBg         = Color(0xFF000000);
  static const Color navBarBgTop      = Color(0x00000000); // transparent at top
  static const Color navIconActive    = Color(0xFFFFFFFF);
  static const Color navIconInactive  = Color(0xFF808080);
  static const Color navLabelActive   = Color(0xFFFFFFFF);
  static const Color navLabelInactive = Color(0xFF808080);

  // ══ Cards ════════════════════════════════════════════════
  static const Color cardBg           = Color(0xFF1A1A1A);
  static const Color cardBorder       = Color(0xFF333333);
  static const Color cardShadow       = Color(0x99000000); // 60% black
  static const Color cardHover        = Color(0xFF2A2A2A);

  // ══ Inputs / Forms ═══════════════════════════════════════
  static const Color inputBg          = Color(0xFF333333);
  static const Color inputBgFocused   = Color(0xFF454545);
  static const Color inputBorder      = Color(0xFF808080);
  static const Color inputBorderFocus = Color(0xFFFFFFFF);
  static const Color inputBorderError = Color(0xFFE87C03); // Netflix orange error
  static const Color inputHintText    = Color(0xFF8C8C8C);
  static const Color inputLabelFloat  = Color(0xFF8C8C8C);

  // ══ Status / Feedback ════════════════════════════════════
  static const Color success          = Color(0xFF46D369); // Netflix green (downloads)
  static const Color successLight     = Color(0xFF46D36933);
  static const Color warning          = Color(0xFFE87C03); // Netflix orange
  static const Color warningLight     = Color(0xFFE87C0333);
  static const Color error            = Color(0xFFE50914);
  static const Color errorLight       = Color(0xFFE5091433);
  static const Color info             = Color(0xFF0071EB);
  static const Color infoLight        = Color(0xFF0071EB33);

  // ══ Progress / Rating ════════════════════════════════════
  static const Color progressBar      = Color(0xFFE50914); // red scrubber
  static const Color progressBg       = Color(0xFF4D4D4D); // unfilled track
  static const Color progressLoaded   = Color(0xFF737373); // buffered
  static const Color ratingStarFill   = Color(0xFFFFB800);
  static const Color ratingStarEmpty  = Color(0xFF4D4D4D);
  static const Color matchScore       = Color(0xFF46D369); // "97% Match" green

  // ══ Maturity Rating Badges ═══════════════════════════════
  static const Color maturityBorder   = Color(0xFF808080);
  static const Color maturityText     = Color(0xFF808080);

  // ══ Shimmer / Skeleton ═══════════════════════════════════
  static const Color shimmerBase      = Color(0xFF1A1A1A);
  static const Color shimmerHighlight = Color(0xFF2D2D2D);

  // ══ Dividers / Separators ════════════════════════════════
  static const Color divider          = Color(0xFF2D2D2D);
  static const Color dividerLight     = Color(0xFF3D3D3D);

  // ══ Gradients ════════════════════════════════════════════
  // Hero banner bottom fade (title + buttons legible over image)
  static const LinearGradient heroBannerGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0x00141414), Color(0xFF141414)],
    stops: [0.4, 1.0],
  );

  // Hero banner left fade (for landscape detail layout)
  static const LinearGradient heroBannerGradientLeft = LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: [Color(0x00141414), Color(0xFF141414)],
    stops: [0.0, 0.7],
  );

  // Top nav fade (so nav blends into banner image)
  static const LinearGradient navTopGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xCC000000), Color(0x00000000)],
    stops: [0.0, 1.0],
  );

  // Card hover expand gradient
  static const LinearGradient cardExpandGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0x00000000), Color(0xFF000000)],
    stops: [0.4, 1.0],
  );

  // Netflix splash gradient
  static const LinearGradient splashGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF000000), Color(0xFF141414)],
  );

  // Download badge gradient
  static const LinearGradient downloadGradient = LinearGradient(
    colors: [Color(0xFF0071EB), Color(0xFF46D369)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ══ Opacity Helpers ══════════════════════════════════════
  static Color withOpacity(Color color, double opacity) =>
      color.withValues(alpha: opacity);

  static const Color black10  = Color(0x1A000000);
  static const Color black20  = Color(0x33000000);
  static const Color black40  = Color(0x66000000);
  static const Color black60  = Color(0x99000000);
  static const Color black80  = Color(0xCC000000);
  static const Color white10  = Color(0x1AFFFFFF);
  static const Color white20  = Color(0x33FFFFFF);
  static const Color white40  = Color(0x66FFFFFF);
  static const Color white60  = Color(0x99FFFFFF);
  static const Color white80  = Color(0xCCFFFFFF);
}