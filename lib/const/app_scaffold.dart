import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'ar_color.dart';
import 'ar_theme.dart';

enum StatusBarIconStyle { light, dark, background }

class AppScaffold extends StatefulWidget {
  const AppScaffold({
    super.key,
    this.appBar,
    this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.persistentFooterAlignment = AlignmentDirectional.centerEnd,
    this.drawer,
    this.onDrawerChanged,
    this.endDrawer,
    this.onEndDrawerChanged,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.backgroundColor,
    this.resizeToAvoidBottomInset,
    this.primary = true,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.drawerScrimColor,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
    this.restorationId,
    this.statusBarIconStyle = StatusBarIconStyle.dark,
    this.isHideStatus = false,
  });

  final Widget? floatingActionButton;
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final List<Widget>? persistentFooterButtons;
  final AlignmentDirectional persistentFooterAlignment;
  final Widget? drawer;
  final void Function(bool)? onDrawerChanged;
  final Widget? endDrawer;
  final void Function(bool)? onEndDrawerChanged;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;
  final Color? backgroundColor;
  final bool? resizeToAvoidBottomInset;
  final bool primary;
  final DragStartBehavior drawerDragStartBehavior;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final Color? drawerScrimColor;
  final double? drawerEdgeDragWidth;
  final bool drawerEnableOpenDragGesture;
  final bool endDrawerEnableOpenDragGesture;
  final dynamic restorationId;
  final StatusBarIconStyle? statusBarIconStyle;
  final bool? isHideStatus;

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: DefaultTextStyle(
        style: OneTheme.of(context).body2,
        child: Scaffold(
          key: widget.key,
          appBar:
              widget.isHideStatus == true
                  ? null
                  : widget.appBar ??
                      AppBar(
                        toolbarHeight: 0,
                        elevation: 0,
                        backgroundColor:
                            widget.statusBarIconStyle == StatusBarIconStyle.dark
                                ? OneColors.white
                                : widget.statusBarIconStyle ==
                                    StatusBarIconStyle.light
                                ? OneColors.brandVNP
                                : OneColors.background,
                        systemOverlayStyle: SystemUiOverlayStyle(
                          statusBarColor: Colors.transparent,
                          systemNavigationBarIconBrightness: Brightness.dark,
                          systemNavigationBarColor: Colors.transparent,
                          statusBarIconBrightness:
                              widget.statusBarIconStyle ==
                                      StatusBarIconStyle.light
                                  ? Brightness.light
                                  : Brightness.dark,
                          statusBarBrightness:
                              widget.statusBarIconStyle ==
                                      StatusBarIconStyle.light
                                  ? Brightness.dark
                                  : Brightness.light,
                        ),
                      ),
          body: widget.body,
          floatingActionButton: widget.floatingActionButton,
          floatingActionButtonLocation: widget.floatingActionButtonLocation,
          floatingActionButtonAnimator: widget.floatingActionButtonAnimator,
          persistentFooterButtons: widget.persistentFooterButtons,
          persistentFooterAlignment: widget.persistentFooterAlignment,
          drawer: widget.drawer,
          onDrawerChanged: widget.onDrawerChanged,
          endDrawer: widget.endDrawer,
          onEndDrawerChanged: widget.onEndDrawerChanged,
          bottomNavigationBar: widget.bottomNavigationBar,
          bottomSheet: widget.bottomSheet,
          backgroundColor: widget.backgroundColor,
          resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
          primary: widget.primary,
          drawerDragStartBehavior: widget.drawerDragStartBehavior,
          extendBody: widget.extendBody,
          extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
          drawerScrimColor: widget.drawerScrimColor,
          drawerEdgeDragWidth: widget.drawerEdgeDragWidth,
          drawerEnableOpenDragGesture: widget.drawerEnableOpenDragGesture,
          endDrawerEnableOpenDragGesture: widget.endDrawerEnableOpenDragGesture,
          restorationId: widget.restorationId,
        ),
      ),
    );
  }
}
