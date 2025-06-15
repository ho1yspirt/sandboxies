import 'dart:io' as io;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:window_manager/window_manager.dart';

/// {@template window_scope}
/// WindowScope widget.
/// {@endtemplate}
class WindowScope extends StatefulWidget {
  /// {@macro window_scope}
  const WindowScope({required this.child, super.key});

  /// The widget below this widget in the tree.
  final Widget child;

  @override
  State<WindowScope> createState() => _WindowScopeState();
}

class _WindowScopeState extends State<WindowScope> {
  @override
  Widget build(BuildContext context) =>
      kIsWeb || io.Platform.isAndroid || io.Platform.isIOS
      ? widget.child
      : Stack(
          alignment: Alignment.topCenter,
          children: [widget.child, const _WindowTitle()],
        );
}

class _WindowTitle extends StatefulWidget {
  const _WindowTitle();

  @override
  State<_WindowTitle> createState() => _WindowTitleState();
}

// ignore: prefer_mixin
class _WindowTitleState extends State<_WindowTitle> with WindowListener {
  final _isFullScreenNotifier = ValueNotifier(false);
  final _isAlwaysOnTopNotifier = ValueNotifier(false);

  @override
  void initState() {
    windowManager.addListener(this);
    super.initState();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  void onWindowEnterFullScreen() {
    super.onWindowEnterFullScreen();
    _isFullScreenNotifier.value = true;
  }

  @override
  void onWindowLeaveFullScreen() {
    super.onWindowLeaveFullScreen();
    _isFullScreenNotifier.value = false;
  }

  @override
  void onWindowFocus() => setState(() {});

  void _setAlwaysOnTop(bool value) => Future<void>(() async {
    await windowManager.setAlwaysOnTop(value);
    _isAlwaysOnTopNotifier.value = await windowManager.isAlwaysOnTop();
  }).ignore();

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 28,
    child: DragToMoveArea(
      child: _Buttons(
        isFullScreenNotifier: _isFullScreenNotifier,
        isAlwaysOnTopNotifier: _isAlwaysOnTopNotifier,
        setAlwaysOnTop: _setAlwaysOnTop,
      ),
    ),
  );
}

class _Buttons extends StatelessWidget {
  const _Buttons({
    required ValueListenable<bool> isFullScreenNotifier,
    required ValueListenable<bool> isAlwaysOnTopNotifier,
    required this.setAlwaysOnTop,
  }) : _isFullScreenNotifier = isFullScreenNotifier,
       _isAlwaysOnTopNotifier = isAlwaysOnTopNotifier;

  // ignore: unused_field
  final ValueListenable<bool> _isFullScreenNotifier;
  final ValueListenable<bool> _isAlwaysOnTopNotifier;

  final ValueChanged<bool> setAlwaysOnTop;

  @override
  Widget build(BuildContext context) => Align(
    alignment: Alignment.centerRight,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ValueListenableBuilder(
          valueListenable: _isAlwaysOnTopNotifier,
          builder: (context, isAlwaysOnTop, _) {
            return _Button(
              onPressed: () => setAlwaysOnTop(!isAlwaysOnTop),
              icon: Icon(Symbols.push_pin_rounded, fill: isAlwaysOnTop ? 1 : 0),
            );
          },
        ),
        _Button(
          onPressed: windowManager.minimize,
          icon: const Icon(Symbols.minimize_rounded),
        ),
        ValueListenableBuilder(
          valueListenable: _isFullScreenNotifier,
          builder: (_, isFullScreen, _) => _Button(
            onPressed: () => windowManager.setFullScreen(!isFullScreen),
            icon: Icon(
              isFullScreen
                  ? Symbols.fullscreen_exit_rounded
                  : Symbols.fullscreen_rounded,
            ),
          ),
        ),
        _Button(
          onPressed: windowManager.close,
          icon: const Icon(Symbols.close_rounded),
        ),
      ],
    ),
  );
}

class _Button extends StatelessWidget {
  const _Button({required this.onPressed, required this.icon});

  final VoidCallback onPressed;
  final Icon icon;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4),
    child: IconButton(
      onPressed: onPressed,
      icon: icon,
      iconSize: 16,
      splashRadius: 12,
      padding: EdgeInsets.zero,
      alignment: Alignment.center,
      constraints: const BoxConstraints.tightFor(width: 24, height: 24),
    ),
  );
}
