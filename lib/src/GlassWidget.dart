import 'package:flutter/material.dart';
import 'dart:ui';

extension GlassWidget<T extends Widget> on T {
  /// .asGlass(): Converts the calling widget into a glass widget.
  ///
  /// Parameters:
  /// * [shape]: Pass the shape of the theme element or custom, default RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)).
  /// * [blurX]: Amount of blur in the direction of the X axis, defaults to 10.0.
  /// * [blurY]: Amount of blur in the direction of the Y axis, defaults to 10.0.
  /// * [tintColor]: Tint color for the glass (defaults to Colors.black).
  /// * [frosted]: Whether this glass should be frosted or not (defaults to false).
  /// * [clipBorderRadius]: The border radius of the rounded corners.
  ///   Values are clamped so that horizontal and vertical radii sums do not exceed width/height.
  ///   This value is ignored if clipper is non-null.
  /// * [clipBehaviour]: Defaults to [Clip.antiAlias].
  /// * [tileMode]: Defines what happens at the edge of a gradient or the sampling of a source image in an [ImageFilter].
  /// * [clipper]: If non-null, determines which clip to use.
  /// 
  Widget asGlass(BuildContext context,{
    bool enable = true,
    ShapeBorder? shape,
    double blurX = 10.0,
    double blurY = 10.0,
    Color tintColor = Colors.white,
    bool frosted = false,
    //BorderRadius? clipBorderRadius = BorderRadius.zero,
    Clip clipBehaviour = Clip.antiAlias,
    TileMode tileMode = TileMode.clamp,
    //CustomClipper<RRect>? clipper,
  }) {
    return 
    // ClipRRect(
    //   clipper: clipper,
    //   clipBehavior: clipBehaviour,
    //   borderRadius: clipBorderRadius,

    Container(
      clipBehavior: clipBehaviour,
      decoration: ShapeDecoration(shape: shape 
      ?? Theme.of(context).cardTheme.shape 
      ?? RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))), //default card theme shape, mostly used behind neary hald transparent cards
     child: BackdropFilter(
        filter: new ImageFilter.blur(
          sigmaX: enable ? blurX : 0.0,
          sigmaY: enable ? blurY : 0.0,
          tileMode: tileMode,
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: (tintColor != Colors.transparent) && enable
                ? LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      tintColor.withOpacity(0.1),
                      tintColor.withOpacity(.05),
                    ],
                  )
                : null,
            image: frosted
                ? DecorationImage(
                    image: AssetImage('images/noise.png', package: 'glass'),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: this,
        ),
      ),
    );
  }
}
