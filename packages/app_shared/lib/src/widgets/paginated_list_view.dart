import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

Widget _defaultProgressIndicator(BuildContext context) => const Center(
  child: Padding(
    padding: EdgeInsets.symmetric(vertical: 8),
    child: CircularProgressIndicator(),
  ),
);

Widget _defaultErrorBuilder(BuildContext context) => const Center(
  child: Padding(
    padding: EdgeInsets.symmetric(vertical: 8),
    child: Icon(Symbols.error_rounded),
  ),
);

/// {@template paginated_list_view}
/// PaginatedListView widget.
/// {@endtemplate}
class PaginatedListView extends StatefulWidget {
  /// {@macro paginated_list_view}
  const PaginatedListView.builder({
    super.key,
    required this.controller,
    required this.isInProgress,
    required this.hasReachedMax,
    this.scrollThreshold = 0.9,
    required this.onScrollEnd,
    this.onRefresh,
    required this.itemCount,
    required this.itemBuilder,
    this.padding,
    this.progressIndicatorBuilder = _defaultProgressIndicator,
    this.errorBuilder = _defaultErrorBuilder,
  });

  final ScrollController controller;

  final bool isInProgress;

  final bool hasReachedMax;

  final double scrollThreshold;

  final VoidCallback onScrollEnd;

  final RefreshCallback? onRefresh;

  final int itemCount;

  final Widget Function(BuildContext context, int index) itemBuilder;

  final WidgetBuilder progressIndicatorBuilder;

  final WidgetBuilder errorBuilder;

  final EdgeInsetsGeometry? padding;

  @override
  State<PaginatedListView> createState() => _PaginatedListViewState();
}

/// State for widget PaginatedListView.
class _PaginatedListViewState extends State<PaginatedListView> {
  /* #region Lifecycle */
  @override
  void initState() {
    super.initState();
    // Initial state initialization
    widget.controller.addListener(_onScroll);
  }

  @override
  void didUpdateWidget(covariant PaginatedListView oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Widget configuration changed,
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller.removeListener(_onScroll);
      widget.controller.addListener(_onScroll);
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(widget.onScrollEnd);
    // Permanent removal of a tree stent
    super.dispose();
  }
  /* #endregion */

  /// Handles scroll events and triggers [onScrollEnd] if threshold is met.
  void _onScroll() {
    if (!widget.controller.hasClients) return; // Ensure controller is attached

    final maxScroll = widget.controller.position.maxScrollExtent;
    final currentScroll = widget.controller.position.pixels;
    if (currentScroll >= (maxScroll * widget.scrollThreshold)) {
      // Only trigger onScrollEnd if not already reached max
      if (!widget.isInProgress && !widget.hasReachedMax) {
        widget.onScrollEnd();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final showProgressIndicator = !widget.hasReachedMax && widget.isInProgress;
    final listView = ListView.builder(
      controller: widget.controller,
      itemCount: widget.itemCount + (showProgressIndicator ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= widget.itemCount) {
          return widget.progressIndicatorBuilder(context);
        }
        return widget.itemBuilder(context, index);
      },
      padding: widget.padding,
    );

    final onRefresh = widget.onRefresh;
    if (onRefresh != null) {
      return RefreshIndicator(onRefresh: onRefresh, child: listView);
    }

    return listView;
  }
}
