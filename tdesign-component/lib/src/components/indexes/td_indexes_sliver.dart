import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../tdesign_flutter.dart';

/// 索引列表
class TDIndexesSliver extends StatefulWidget {
  const TDIndexesSliver({
    super.key,
    this.children = const [],
    this.onChange,
  });

  /// 索引列表项
  final List<String> children;

  /// 索引改变事件
  final Function(String key)? onChange;
  @override
  State<TDIndexesSliver> createState() => _TDIndexesSliverState();
}

class _TDIndexesSliverState extends State<TDIndexesSliver> {
  final sliverContainerKey = GlobalKey();
  final int _sliverItemHeight = 20;

  /// 游标偏移
  double _reminderOffsetY = 0.0;

  /// 当前激活索引
  int _currentActiveIndex = -1;
  @override
  void initState() {
    super.initState();
    _currentActiveIndex = -1;
    _reminderOffsetY = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // 游标
        _reminderChild(context),

        /// 字母列表
        _getLetterList(context)
      ],
    );
  }

  /// 获取字母列表
  Widget _getLetterList(BuildContext context) {
    var children = <Widget>[];
    for (var i = 0; i < widget.children.length; i++) {
      children.add(
        Container(
          width: 20,
          height: 20,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _currentActiveIndex == i
                ? TDTheme.of(context).brandNormalColor
                : Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          child: TDText(
            widget.children[i],
            textColor: _currentActiveIndex == i
                ? TDTheme.of(context).whiteColor1
                : Colors.black,
            font: Font(size: 12, lineHeight: _sliverItemHeight),
            fontWeight:
                _currentActiveIndex == i ? FontWeight.w700 : FontWeight.w400,
          ),
        ),
      );
    }

    return GestureDetector(
      onVerticalDragDown: _onVerticalDragDownSliverItem,
      onVerticalDragUpdate: _onVerticalDragDownSliverItem,
      onVerticalDragEnd: _onVerticalDragEndSliverItem,
      onTapUp: (details) {
        setState(() {
          _currentActiveIndex = -1;
          _reminderOffsetY = 0;
        });
      },
      child: Container(
        alignment: Alignment.centerRight,
        height: widget.children.length * _sliverItemHeight * 1.0,
        child: Column(
          key: sliverContainerKey,
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        ),
      ),
    );
  }

  Widget _reminderChild(BuildContext context) {
    if (_currentActiveIndex == -1) {
      return Container();
    }
    return Container(
      height: reminderHeight,
      alignment: Alignment(0.0, _reminderOffsetY),
      child: Padding(
        padding: const EdgeInsets.only(right: 8),
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: TDTheme.of(context).brandColor3,
            borderRadius: const BorderRadius.all(Radius.circular(999)),
          ),
          child: Center(
            child: TDText(
              widget.children[_currentActiveIndex],
              textColor: TDTheme.of(context).whiteColor1,
            ),
          ),
        ),
      ),
    );
  }

  void _onVerticalDragDownSliverItem(dynamic details) async {
    _reminderOffsetY = details.localPosition.dy; // 记录手指按下时的位置

    var index = (_reminderOffsetY ~/ _sliverItemHeight)
        .clamp(0, widget.children.length - 1);
    var letter = widget.children[index];
    var offset = index / max(widget.children.length - 1, 1) * 2 - 1;
    setState(() {
      _currentActiveIndex = index;
      _reminderOffsetY = offset;
    });
    widget.onChange?.call(letter);
  }

  void _onVerticalDragEndSliverItem(details) {
    setState(() {
      _currentActiveIndex = -1;
      _reminderOffsetY = 0;
    });
  }

  get reminderHeight => 1.0 * widget.children.length * _sliverItemHeight + 28;
}