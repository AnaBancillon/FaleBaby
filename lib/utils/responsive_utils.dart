import 'package:flutter/cupertino.dart';

extension ReponsiveDouble on num {
  double get w => ResponsiveUtils.I.getProportionalWidth(this);
  double get h => ResponsiveUtils.I.getProportionalHeight(this);
}

abstract class ResponsiveUtils {
  static ResponsiveUtils? _instance;

  factory ResponsiveUtils() => instance;

  static ResponsiveUtils get instance {
    return _instance ??= _ResponsiveUtilsImpl();
  }

  static ResponsiveUtils get I => instance;

  void init(BuildContext context);
  bool isSmallScreen();
  bool isMediumScreen();
  double getProportionalWidth(num staticWidth);
  double getProportionalHeight(num staticHeight);
}

class _ResponsiveUtilsImpl implements ResponsiveUtils {
  final _sizeReference = const Size(372, 812);
  late Size _currentScreenSize;

  // Based on legacy code
  //! TODO: Verify in which screen is based
  final smallSize = const Size(360, 640);

  // Based on iphone 8 screen
  final mediumSize = const Size(375, 667);

  @override
  void init(BuildContext context) {
    _currentScreenSize = MediaQuery.of(context).size;
    print(_currentScreenSize);
  }

  @override
  bool isSmallScreen() {
    return _currentScreenSize.width <= smallSize.width ||
        _currentScreenSize.height <= smallSize.height;
  }

  @override
  bool isMediumScreen() {
    if (isSmallScreen()) return false;

    return _currentScreenSize.width <= mediumSize.width ||
        _currentScreenSize.height <= mediumSize.height;
  }

  /// Calculates width proportional to current screen
  /// [staticWidth] is the expected width for [_sizeReference]
  @override
  double getProportionalWidth(num staticWidth) {
    final widthInPercent = staticWidth / _sizeReference.width;
    return _currentScreenSize.width * widthInPercent;
  }

  /// Calculates height proportional to current screen
  /// [staticHeight] is the expected height for [_sizeReference]
  @override
  double getProportionalHeight(num staticHeight) {
    final widthInPercent = staticHeight / _sizeReference.height;
    return _currentScreenSize.height * widthInPercent;
  }
}
