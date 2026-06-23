// ============================================================
//  AppDurations — All animation & transition durations
//  Never hardcode Duration() values in widgets
// ============================================================

class AppDurations {
  AppDurations._();

  // ── Micro interactions ───────────────────────────────────
  static const Duration instant        = Duration(milliseconds: 0);
  static const Duration ultraFast      = Duration(milliseconds: 100);
  static const Duration fast           = Duration(milliseconds: 150);
  static const Duration normal         = Duration(milliseconds: 250);  // default
  static const Duration medium         = Duration(milliseconds: 350);
  static const Duration slow           = Duration(milliseconds: 500);
  static const Duration slower         = Duration(milliseconds: 700);
  static const Duration slowest        = Duration(milliseconds: 1000);

  // ── Page / Route transitions ─────────────────────────────
  static const Duration pageTransition     = Duration(milliseconds: 300);
  static const Duration modalTransition    = Duration(milliseconds: 350);
  static const Duration bottomSheetSlide   = Duration(milliseconds: 300);

  // ── Hero Banner ──────────────────────────────────────────
  static const Duration bannerAutoScroll   = Duration(seconds: 6);
  static const Duration bannerTransition   = Duration(milliseconds: 600);
  static const Duration bannerFadeIn       = Duration(milliseconds: 400);

  // ── Card expand (hover pop) ──────────────────────────────
  static const Duration cardExpand         = Duration(milliseconds: 200);
  static const Duration cardCollapse       = Duration(milliseconds: 150);

  // ── Shimmer / Skeleton ───────────────────────────────────
  static const Duration shimmerCycle       = Duration(milliseconds: 1500);

  // ── Player controls ──────────────────────────────────────
  static const Duration controlsFadeOut    = Duration(seconds: 3);
  static const Duration controlsFadeAnim   = Duration(milliseconds: 300);
  static const Duration seekDebounce       = Duration(milliseconds: 500);

  // ── Splash ───────────────────────────────────────────────
  static const Duration splashMinDisplay   = Duration(seconds: 2);
  static const Duration splashLogoAnim     = Duration(milliseconds: 800);

  // ── Snackbar / Toast ─────────────────────────────────────
  static const Duration snackBarDisplay    = Duration(seconds: 3);
  static const Duration toastDisplay       = Duration(seconds: 2);

  // ── Search debounce ──────────────────────────────────────
  static const Duration searchDebounce     = Duration(milliseconds: 400);

  // ── Notification badge ───────────────────────────────────
  static const Duration badgePulse         = Duration(milliseconds: 800);
}