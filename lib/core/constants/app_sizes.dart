// ============================================================
//  AppSizes — Spacing, radius, icon, font size constants
//  Use these everywhere — never hardcode raw numbers in UI
//  Based on an 4pt base grid (4, 8, 12, 16, 20, 24 …)
// ============================================================

class AppSizes {
  AppSizes._();

  // ══ Base Grid (4pt) ══════════════════════════════════════
  static const double _base = 4.0;

  // ══ Spacing ══════════════════════════════════════════════
  static const double spaceXXS  =  _base * 1;   //  4
  static const double spaceXS   =  _base * 2;   //  8
  static const double spaceSM   =  _base * 3;   // 12
  static const double spaceMD   =  _base * 4;   // 16  ← default padding
  static const double spaceLG   =  _base * 5;   // 20
  static const double spaceXL   =  _base * 6;   // 24
  static const double spaceXXL  =  _base * 8;   // 32
  static const double space3XL  =  _base * 10;  // 40
  static const double space4XL  =  _base * 12;  // 48
  static const double space5XL  =  _base * 16;  // 64
  static const double space6XL  =  _base * 20;  // 80

  // ══ Screen / Section Padding ═════════════════════════════
  static const double screenPaddingH    = spaceMD;   // 16  horizontal
  static const double screenPaddingV    = spaceMD;   // 16  vertical
  static const double sectionSpacing    = space3XL;  // 40  between home rows
  static const double rowTitlePaddingH  = spaceMD;   // 16
  static const double rowTitlePaddingB  = spaceXS;   //  8  below row title

  // ══ Border Radius ════════════════════════════════════════
  static const double radiusXS   =  4.0;   // tags, badges
  static const double radiusSM   =  6.0;   // small cards
  static const double radiusMD   =  8.0;   // standard cards
  static const double radiusLG   = 12.0;   // large cards, sheets
  static const double radiusXL   = 16.0;   // modal bottom sheets
  static const double radiusXXL  = 24.0;   // pill buttons
  static const double radiusFull = 999.0;  // fully circular

  // ══ Icon Sizes ═══════════════════════════════════════════
  static const double iconXS    = 12.0;
  static const double iconSM    = 16.0;
  static const double iconMD    = 20.0;   // nav bar icons (inactive)
  static const double iconLG    = 24.0;   // nav bar icons (active), toolbar
  static const double iconXL    = 28.0;
  static const double iconXXL   = 32.0;
  static const double icon3XL   = 40.0;
  static const double icon4XL   = 48.0;   // play FAB
  static const double icon5XL   = 56.0;   // hero play button

  // ══ Avatar / Profile ═════════════════════════════════════
  static const double avatarSM  = 32.0;
  static const double avatarMD  = 48.0;
  static const double avatarLG  = 72.0;   // profile picker
  static const double avatarXL  = 96.0;   // profile edit page

  // ══ Button Sizes ═════════════════════════════════════════
  static const double btnHeightSM      = 32.0;
  static const double btnHeightMD      = 40.0;  // default
  static const double btnHeightLG      = 48.0;  // primary CTA
  static const double btnHeightXL      = 56.0;  // auth pages
  static const double btnMinWidth      = 120.0;
  static const double btnBorderWidth   = 1.5;
  static const double btnIconSpacing   = spaceXS; // gap between icon + label

  // ══ Card Sizes ═══════════════════════════════════════════
  // Portrait card  (2:3 ratio — movie poster)
  static const double cardPortraitW    = 110.0;
  static const double cardPortraitH    = 165.0;

  // Landscape card (16:9 ratio — episode / banner thumb)
  static const double cardLandscapeW   = 240.0;
  static const double cardLandscapeH   = 135.0;

  // Large portrait (Netflix Originals row)
  static const double cardPortraitLgW  = 140.0;
  static const double cardPortraitLgH  = 210.0;

  // Top-10 card (numbered, extra wide)
  static const double cardTop10W       = 280.0;
  static const double cardTop10H       = 157.0;

  // Continue watching card
  static const double cardContinueW    = 240.0;
  static const double cardContinueH    = 140.0;

  // Card spacing inside horizontal ListView
  static const double cardSpacing      = spaceXS;   //  8
  static const double cardElevation    = 4.0;

  // ══ Hero Banner ══════════════════════════════════════════
  static const double heroBannerH      = 500.0;  // full bleed height
  static const double heroBannerMinH   = 400.0;
  static const double heroBannerLogoH  = 80.0;   // title logo image
  static const double heroBannerLogoW  = 220.0;

  // ══ App Bar / Nav Bar ════════════════════════════════════
  static const double appBarH          = 56.0;
  static const double bottomNavH       = 60.0;
  static const double bottomNavIconH   = 24.0;
  static const double netflixLogoW     = 80.0;
  static const double netflixLogoH     = 24.0;

  // ══ Input Fields ═════════════════════════════════════════
  static const double inputH           = 52.0;   // standard text field height
  static const double inputBorderW     = 1.0;
  static const double inputBorderFocW  = 2.0;
  static const double inputRadius      = radiusMD;

  // ══ Progress Bar ═════════════════════════════════════════
  static const double progressBarH     = 3.0;    // card bottom bar
  static const double progressBarHLg   = 4.0;    // player scrubber
  static const double progressThumbR   = 6.0;    // player scrubber thumb

  // ══ Shimmer / Skeleton ═══════════════════════════════════
  static const double skeletonRadius   = radiusMD;

  // ══ Bottom Sheet ═════════════════════════════════════════
  static const double sheetHandleW     = 40.0;
  static const double sheetHandleH     = 4.0;
  static const double sheetHandleRadius= radiusFull;
  static const double sheetPaddingH    = spaceMD;
  static const double sheetPaddingV    = spaceXL;
  static const double sheetMinH        = 300.0;

  // ══ Player Controls ══════════════════════════════════════
  static const double playerControlsH  = 80.0;
  static const double playerPlayBtnR   = 36.0;   // radius of play circle
  static const double playerSeekBtnSz  = 48.0;

  // ══ Divider ══════════════════════════════════════════════
  static const double dividerH         = 1.0;
  static const double dividerHeavy     = 2.0;
  static const double dividerIndent    = spaceMD;

  // ══ Notification / Badge ═════════════════════════════════
  static const double badgeSize        = 18.0;
  static const double badgeRadius      = radiusFull;
  static const double badgeFontSize    = 10.0;

  // ══ Maturity Rating Badge ════════════════════════════════
  static const double maturityBadgeH   = 20.0;
  static const double maturityBadgePH  = 4.0;   // padding horizontal
  static const double maturityBorderW  = 1.0;

  // ══ Dot Indicator (banner pagination) ════════════════════
  static const double dotActive        = 8.0;
  static const double dotInactive      = 6.0;
  static const double dotSpacing       = spaceXXS;

  // ══ Download Badge ═══════════════════════════════════════
  static const double downloadIconSz   = 20.0;
  static const double downloadBadgePad = spaceXXS;

  // ══ Top-10 Number Overlay ════════════════════════════════
  static const double top10NumFontSz   = 96.0;
  static const double top10NumOffsetX  = -16.0;  // bleed left of card

  // ══ Responsive Breakpoints ═══════════════════════════════
  static const double bpMobile  = 480.0;
  static const double bpTablet  = 768.0;
  static const double bpDesktop = 1024.0;
  static const double bpWide    = 1440.0;
}