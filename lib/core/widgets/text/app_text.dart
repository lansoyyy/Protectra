import 'package:flutter/material.dart';
import '../../theme/app_text_styles.dart';

/// Custom App Text Widget for Simbayanan
/// Provides consistent text styling using Urbanist fonts
class AppText extends StatelessWidget {
  const AppText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.strutStyle,
    this.textDirection,
    this.locale,
    this.semanticsLabel,
    this.textHeightBehavior,
    this.textWidthBasis,
    this.selectionColor,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.letterSpacing,
    this.wordSpacing,
    this.height,
    this.decoration,
    this.decorationColor,
    this.decorationStyle,
    this.decorationThickness,
  });

  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool? softWrap;
  final StrutStyle? strutStyle;
  final TextDirection? textDirection;
  final Locale? locale;
  final String? semanticsLabel;
  final TextHeightBehavior? textHeightBehavior;
  final TextWidthBasis? textWidthBasis;
  final Color? selectionColor;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? letterSpacing;
  final double? wordSpacing;
  final double? height;
  final TextDecoration? decoration;
  final Color? decorationColor;
  final TextDecorationStyle? decorationStyle;
  final double? decorationThickness;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: _getTextStyle(),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      strutStyle: strutStyle,
      textDirection: textDirection,
      locale: locale,
      semanticsLabel: semanticsLabel,
      textHeightBehavior: textHeightBehavior,
      textWidthBasis: textWidthBasis,
      selectionColor: selectionColor,
    );
  }

  TextStyle _getTextStyle() {
    TextStyle textStyle = style ?? AppTextStyles.bodyMedium;

    if (color != null) {
      textStyle = textStyle.copyWith(color: color);
    }
    if (fontSize != null) {
      textStyle = textStyle.copyWith(fontSize: fontSize);
    }
    if (fontWeight != null) {
      textStyle = textStyle.copyWith(fontWeight: fontWeight);
    }
    if (letterSpacing != null) {
      textStyle = textStyle.copyWith(letterSpacing: letterSpacing);
    }
    if (wordSpacing != null) {
      textStyle = textStyle.copyWith(wordSpacing: wordSpacing);
    }
    if (height != null) {
      textStyle = textStyle.copyWith(height: height);
    }
    if (decoration != null) {
      textStyle = textStyle.copyWith(decoration: decoration);
    }
    if (decorationColor != null) {
      textStyle = textStyle.copyWith(decorationColor: decorationColor);
    }
    if (decorationStyle != null) {
      textStyle = textStyle.copyWith(decorationStyle: decorationStyle);
    }
    if (decorationThickness != null) {
      textStyle = textStyle.copyWith(decorationThickness: decorationThickness);
    }

    return textStyle;
  }
}

// ==================== PREDEFINED TEXT STYLES ====================

/// Display Extra Large Text
class AppDisplayLarge extends StatelessWidget {
  const AppDisplayLarge(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return AppText(
      text,
      style: AppTextStyles.displayLarge.copyWith(color: color),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

/// Display Medium Text
class AppDisplayMedium extends StatelessWidget {
  const AppDisplayMedium(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return AppText(
      text,
      style: AppTextStyles.displayMedium.copyWith(color: color),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

/// Display Small Text
class AppDisplaySmall extends StatelessWidget {
  const AppDisplaySmall(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return AppText(
      text,
      style: AppTextStyles.displaySmall.copyWith(color: color),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

/// Headline Large Text
class AppHeadlineLarge extends StatelessWidget {
  const AppHeadlineLarge(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return AppText(
      text,
      style: AppTextStyles.headlineLarge.copyWith(color: color),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

/// Headline Medium Text
class AppHeadlineMedium extends StatelessWidget {
  const AppHeadlineMedium(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return AppText(
      text,
      style: AppTextStyles.headlineMedium.copyWith(color: color),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

/// Headline Small Text
class AppHeadlineSmall extends StatelessWidget {
  const AppHeadlineSmall(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return AppText(
      text,
      style: AppTextStyles.headlineSmall.copyWith(color: color),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

/// Title Large Text
class AppTitleLarge extends StatelessWidget {
  const AppTitleLarge(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return AppText(
      text,
      style: AppTextStyles.titleLarge.copyWith(color: color),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

/// Title Medium Text
class AppTitleMedium extends StatelessWidget {
  const AppTitleMedium(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return AppText(
      text,
      style: AppTextStyles.titleMedium.copyWith(color: color),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

/// Title Small Text
class AppTitleSmall extends StatelessWidget {
  const AppTitleSmall(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return AppText(
      text,
      style: AppTextStyles.titleSmall.copyWith(color: color),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

/// Body Large Text
class AppBodyLarge extends StatelessWidget {
  const AppBodyLarge(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return AppText(
      text,
      style: AppTextStyles.bodyLarge.copyWith(color: color),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

/// Body Medium Text
class AppBodyMedium extends StatelessWidget {
  const AppBodyMedium(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return AppText(
      text,
      style: AppTextStyles.bodyMedium.copyWith(color: color),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

/// Body Small Text
class AppBodySmall extends StatelessWidget {
  const AppBodySmall(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return AppText(
      text,
      style: AppTextStyles.bodySmall.copyWith(color: color),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

/// Label Large Text
class AppLabelLarge extends StatelessWidget {
  const AppLabelLarge(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return AppText(
      text,
      style: AppTextStyles.labelLarge.copyWith(color: color),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

/// Label Medium Text
class AppLabelMedium extends StatelessWidget {
  const AppLabelMedium(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return AppText(
      text,
      style: AppTextStyles.labelMedium.copyWith(color: color),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

/// Label Small Text
class AppLabelSmall extends StatelessWidget {
  const AppLabelSmall(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return AppText(
      text,
      style: AppTextStyles.labelSmall.copyWith(color: color),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

/// Caption Text
class AppCaption extends StatelessWidget {
  const AppCaption(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.bold = false,
  });

  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    final style = bold ? AppTextStyles.captionBold : AppTextStyles.caption;
    return AppText(
      text,
      style: style.copyWith(color: color),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

/// Overline Text
class AppOverline extends StatelessWidget {
  const AppOverline(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return AppText(
      text,
      style: AppTextStyles.overline.copyWith(color: color),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
