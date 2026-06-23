import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:netflix_clone/core/constants/app_text_style.dart';

import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';

// ============================================================
//  AppTheme — Netflix dark theme
//  All Flutter widget themes are set here so widgets
//  automatically match the design without manual styling
// ============================================================

class AppTheme {
  AppTheme._();

  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        fontFamily: 'NetflixSans',

        // ── Color Scheme ───────────────────────────────────
        colorScheme: const ColorScheme.dark(
          primary:          AppColors.netflixRed,
          onPrimary:        AppColors.textPrimary,
          secondary:        AppColors.bgSecondary,
          onSecondary:      AppColors.textPrimary,
          surface:          AppColors.bgSecondary,
          onSurface:        AppColors.textPrimary,
          error:            AppColors.error,
          onError:          AppColors.textPrimary,
          outline:          AppColors.divider,
          surfaceContainerHighest: AppColors.bgTertiary,
        ),

        // ── Scaffold ───────────────────────────────────────
        scaffoldBackgroundColor: AppColors.bgPrimary,

        // ── App Bar ────────────────────────────────────────
        appBarTheme: const AppBarTheme(
          backgroundColor:  Colors.transparent,
          elevation:        0,
          scrolledUnderElevation: 0,
          centerTitle:      false,
          titleSpacing:     AppSizes.screenPaddingH,
          iconTheme:        IconThemeData(
            color: AppColors.textPrimary,
            size:  AppSizes.iconLG,
          ),
          actionsIconTheme: IconThemeData(
            color: AppColors.textPrimary,
            size:  AppSizes.iconLG,
          ),
          titleTextStyle:   AppTextStyles.titleLarge,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor:           Colors.transparent,
            statusBarIconBrightness:  Brightness.light,
          ),
        ),

        // ── Bottom Navigation Bar ──────────────────────────
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor:      AppColors.bgPrimary,
          selectedItemColor:    AppColors.navIconActive,
          unselectedItemColor:  AppColors.navIconInactive,
          showSelectedLabels:   true,
          showUnselectedLabels: true,
          type:                 BottomNavigationBarType.fixed,
          elevation:            0,
          selectedLabelStyle:   AppTextStyles.navLabel,
          unselectedLabelStyle: AppTextStyles.navLabel,
        ),

        // ── Text ───────────────────────────────────────────
        textTheme: const TextTheme(
          displayLarge:   AppTextStyles.displayLarge,
          displayMedium:  AppTextStyles.displayMedium,
          displaySmall:   AppTextStyles.displaySmall,
          headlineLarge:  AppTextStyles.headlineLarge,
          headlineMedium: AppTextStyles.headlineMedium,
          headlineSmall:  AppTextStyles.headlineSmall,
          titleLarge:     AppTextStyles.titleLarge,
          titleMedium:    AppTextStyles.titleMedium,
          titleSmall:     AppTextStyles.titleSmall,
          bodyLarge:      AppTextStyles.bodyLarge,
          bodyMedium:     AppTextStyles.bodyMedium,
          bodySmall:      AppTextStyles.bodySmall,
          labelLarge:     AppTextStyles.labelLarge,
          labelMedium:    AppTextStyles.labelMedium,
          labelSmall:     AppTextStyles.labelSmall,
        ),

        // ── Elevated Button (Play button style) ────────────
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor:  AppColors.btnPlayBg,
            foregroundColor:  AppColors.btnPlayText,
            minimumSize:      const Size(AppSizes.btnMinWidth, AppSizes.btnHeightLG),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.spaceXL,
              vertical:   AppSizes.spaceSM,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusSM),
            ),
            textStyle:      AppTextStyles.btnPrimary,
            elevation:      0,
          ),
        ),

        // ── Outlined Button (More Info / ghost style) ──────
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor:  AppColors.textPrimary,
            backgroundColor:  AppColors.btnSecondaryBg,
            minimumSize:      const Size(AppSizes.btnMinWidth, AppSizes.btnHeightLG),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.spaceXL,
              vertical:   AppSizes.spaceSM,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusSM),
            ),
            side:       const BorderSide(color: Colors.transparent),
            textStyle:  AppTextStyles.btnSecondary,
          ),
        ),

        // ── Text Button ────────────────────────────────────
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor:  AppColors.textPrimary,
            textStyle:        AppTextStyles.btnSecondary,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.spaceMD,
              vertical:   AppSizes.spaceXS,
            ),
          ),
        ),

        // ── Icon Button ────────────────────────────────────
        iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
            foregroundColor: AppColors.textPrimary,
            iconSize:        AppSizes.iconLG,
          ),
        ),

        // ── Input / TextField ──────────────────────────────
        inputDecorationTheme: InputDecorationTheme(
          filled:           true,
          fillColor:        AppColors.inputBg,
          hintStyle:        AppTextStyles.bodyMedium.copyWith(
            color: AppColors.inputHintText,
          ),
          labelStyle:       AppTextStyles.inputLabel,
          floatingLabelStyle: AppTextStyles.inputLabel.copyWith(
            color: AppColors.textSecondary,
          ),
          errorStyle: AppTextStyles.inputError,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSizes.spaceMD,
            vertical:   AppSizes.spaceMD,
          ),
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

        // ── Card ───────────────────────────────────────────
        cardTheme: CardThemeData(
          color:        AppColors.cardBg,
          elevation:    AppSizes.cardElevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusMD),
          ),
          margin: EdgeInsets.zero,
        ),

        // ── Chip ───────────────────────────────────────────
        chipTheme: ChipThemeData(
          backgroundColor:        AppColors.bgTertiary,
          selectedColor:          AppColors.netflixRed,
          labelStyle:             AppTextStyles.labelMedium,
          secondaryLabelStyle:    AppTextStyles.labelMedium.copyWith(
            color: AppColors.textPrimary,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.spaceSM,
            vertical:   AppSizes.spaceXXS,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusXXL),
            side:         const BorderSide(color: AppColors.divider),
          ),
        ),

        // ── Dialog ─────────────────────────────────────────
        dialogTheme: DialogThemeData(
          backgroundColor:  AppColors.bgModal,
          elevation:        16,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusXL),
          ),
          titleTextStyle:   AppTextStyles.titleLarge,
          contentTextStyle: AppTextStyles.bodyMedium,
        ),

        // ── Bottom Sheet ───────────────────────────────────
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor:      AppColors.bgModal,
          modalBackgroundColor: AppColors.bgModal,
          elevation:            0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppSizes.radiusXL),
            ),
          ),
          showDragHandle:       true,
          dragHandleColor:      AppColors.dividerLight,
          dragHandleSize:       Size(AppSizes.sheetHandleW, AppSizes.sheetHandleH),
        ),

        // ── Snack Bar ──────────────────────────────────────
        snackBarTheme: SnackBarThemeData(
          backgroundColor:  AppColors.bgTertiary,
          contentTextStyle: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textPrimary,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusSM),
          ),
          behavior:       SnackBarBehavior.floating,
          elevation:      4,
          actionTextColor: AppColors.netflixRed,
        ),

        // ── Divider ────────────────────────────────────────
        dividerTheme: const DividerThemeData(
          color:     AppColors.divider,
          thickness: AppSizes.dividerH,
          space:     0,
        ),

        // ── Progress Indicator ─────────────────────────────
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color:             AppColors.netflixRed,
          linearTrackColor:  AppColors.progressBg,
          linearMinHeight:   AppSizes.progressBarH,
        ),

        // ── Slider (player scrubber) ───────────────────────
        sliderTheme: SliderThemeData(
          activeTrackColor:   AppColors.netflixRed,
          inactiveTrackColor: AppColors.progressBg,
          thumbColor:         AppColors.textPrimary,
          overlayColor:       AppColors.white20,
          trackHeight:        AppSizes.progressBarHLg,
          thumbShape: const RoundSliderThumbShape(
            enabledThumbRadius: AppSizes.progressThumbR,
          ),
        ),

        // ── Switch ─────────────────────────────────────────
        switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.textPrimary;
            }
            return AppColors.textTertiary;
          }),
          trackColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.netflixRed;
            }
            return AppColors.bgTertiary;
          }),
        ),

        // ── List Tile ──────────────────────────────────────
        listTileTheme: const ListTileThemeData(
          tileColor:        Colors.transparent,
          iconColor:        AppColors.textSecondary,
          textColor:        AppColors.textPrimary,
          contentPadding:   EdgeInsets.symmetric(
            horizontal: AppSizes.screenPaddingH,
          ),
          minVerticalPadding: AppSizes.spaceSM,
        ),

        // ── Tab Bar ────────────────────────────────────────
        tabBarTheme: TabBarThemeData(
          labelColor:         AppColors.textPrimary,
          unselectedLabelColor: AppColors.textTertiary,
          labelStyle:         AppTextStyles.labelLarge,
          unselectedLabelStyle: AppTextStyles.labelLarge.copyWith(
            fontWeight: FontWeight.w400,
          ),
          indicatorColor:     AppColors.netflixRed,
          indicatorSize:      TabBarIndicatorSize.label,
          dividerColor:       AppColors.divider,
        ),

        // ── Popup Menu ─────────────────────────────────────
        popupMenuTheme: PopupMenuThemeData(
          color:    AppColors.bgModal,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusMD),
          ),
          textStyle: AppTextStyles.bodyMedium,
          elevation: 8,
        ),

        // ── Tooltip ────────────────────────────────────────
        tooltipTheme: TooltipThemeData(
          decoration: BoxDecoration(
            color:        AppColors.bgTertiary,
            borderRadius: BorderRadius.circular(AppSizes.radiusXS),
          ),
          textStyle: AppTextStyles.labelSmall.copyWith(
            color: AppColors.textPrimary,
          ),
        ),

        // ── Scroll ─────────────────────────────────────────
        scrollbarTheme: ScrollbarThemeData(
          thumbColor: WidgetStateProperty.all(AppColors.textTertiary),
          radius: const Radius.circular(AppSizes.radiusFull),
          thickness: WidgetStateProperty.all(3.0),
        ),
      );
}