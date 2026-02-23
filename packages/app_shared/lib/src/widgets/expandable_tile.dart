import 'package:flutter/material.dart';

/// {@template expandable_tile}
/// ExpandableTile widget.
/// {@endtemplate}
class ExpandableTile extends StatefulWidget {
  /// {@macro expandable_tile}
  const ExpandableTile({
    super.key,
    required this.title,
    required this.children,
    this.initiallyExpanded = false,
    this.minTileHeight = 56,
    this.expandedIcon = Icons.arrow_drop_up_rounded,
    this.collapsedIcon = Icons.arrow_drop_down_rounded,
    this.tilePadding = const EdgeInsets.symmetric(horizontal: 16.0),
    this.childrenPadding = EdgeInsets.zero,
  });

  final Widget title;
  final List<Widget> children;
  final bool initiallyExpanded;
  final double minTileHeight;
  final IconData expandedIcon;
  final IconData collapsedIcon;
  final EdgeInsets tilePadding;
  final EdgeInsets childrenPadding;

  @override
  State<ExpandableTile> createState() => _ExpandableTileState();
}

class _ExpandableTileState extends State<ExpandableTile> {
  late bool _isExpanded = widget.initiallyExpanded;

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      InkWell(
        onTap: _onTapExpand,
        customBorder: const StadiumBorder(),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: widget.minTileHeight),
          child: Padding(
            padding: widget.tilePadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: widget.title),
                Icon(
                  _isExpanded ? widget.expandedIcon : widget.collapsedIcon,
                  color: ColorScheme.of(context).onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      ),
      if (_isExpanded)
        Padding(
          key: ValueKey(_isExpanded),
          padding: widget.childrenPadding,
          child: Column(children: widget.children),
        ),
    ],
  );

  void _onTapExpand() => setState(() => _isExpanded = !_isExpanded);
}
