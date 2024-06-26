import 'package:flutter/material.dart';
import '../../../tdesign_flutter.dart';

class IndexesItemProps {
  const IndexesItemProps({
    this.label = '',
    this.value,
  });

  final String label;
  final String? value;
}

class TDIndexesItem extends StatefulWidget {
  const TDIndexesItem({
    super.key,
    this.header,
    this.showHeader = true,
    this.divider = true,
    this.children = const [],
  });

  /// 列表头部
  final String? header;

  /// 显示头
  final bool showHeader;

  /// 分割线
  final bool divider;

  /// 项
  final List<IndexesItemProps> children;

  @override
  State<TDIndexesItem> createState() => _TDIndexesItemState();
}

class _TDIndexesItemState extends State<TDIndexesItem> {
  Widget _getHeaderChild() {
    if (widget.showHeader) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: TDText(
          widget.header ?? '',
          font: Font(size: 14, lineHeight: 22),
        ),
      );
    }
    return Container();
  }

  Widget _getItemBody() {
    var children = <Widget>[];
    var length = widget.children.length;
    for (var i = 0; i < length; i++) {
      var item = widget.children[i];
      children.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: TDText(item.label, font: Font(size: 16, lineHeight: 24)),
        ),
      );

      if (i < length - 1 && widget.divider) {
        children.add(const TDDivider());
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_getHeaderChild(), _getItemBody()],
    );
  }
}

class TDIndexesItemUtils {
  static double _getHeaderHeight(TDIndexesItem widget) {
    if (widget.showHeader) {
      return 30.0;
    }
    return 0.0;
  }

  static double _getItemBodyHeight(TDIndexesItem widget) {
    var dividerHeight =
        widget.divider ? 1.0 * (widget.children.length - 1) : 0.0;
    return 56.0 * widget.children.length + dividerHeight;
  }

  static double height(TDIndexesItem widget) {
    return _getHeaderHeight(widget) + _getItemBodyHeight(widget);
  }
}
