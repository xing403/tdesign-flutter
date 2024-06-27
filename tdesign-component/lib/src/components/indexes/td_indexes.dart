import 'package:flutter/material.dart';

import '../../../tdesign_flutter.dart';
import 'td_indexes_item.dart';
import 'td_indexes_sliver.dart';

class TDIndexes extends StatefulWidget {
  const TDIndexes({
    Key? key,
    this.children = const [],
  }) : super(key: key);

  final List<IndexesItemProps> children;
  @override
  State<TDIndexes> createState() => _TDIndexesState();
}

class _TDIndexesState extends State<TDIndexes> {
  List<TDIndexesItem> _children = [];
  List<String> _sliverChildren = [];
  String _currentValue = '';
  // static const threshold = 50;
  // 滚动视图对应的 controller
  ScrollController _scrollController = ScrollController();
  bool isScroll = false;
  @override
  void initState() {
    super.initState();
    _children = _getChildren();
    _sliverChildren = _getSliverChildren();
    _currentValue = _sliverChildren[0];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: ConstrainedBox(
        constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            removeBottom: true,
            child: Stack(
              children: [
                ListView.builder(
                  // physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _children.length,
                  itemBuilder: ((context, index) => _children[index]),
                ),
                Positioned(
                  top: 0,
                  bottom: 0,
                  right: 8,
                  child: TDIndexesSliver(
                    children: _sliverChildren,
                    onChange: onChanged,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onChanged(String value) async {
    if (_currentValue != value) {
      setState(() {
        _currentValue = value;
      });

      var i = 0;
      var offset = 0.0;

      while (i < _sliverChildren.length) {
        if (_sliverChildren[i] == value) {
          break;
        }
        offset += TDIndexesItemUtils.height(_children[i]);
        i++;
      }
      if (i >= _sliverChildren.length) {
        return;
      }

      print('你需要滚动到 $offset');
      await _scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeIn,
      );
    }
  }

  ///  获取生成的全部索引块
  List<TDIndexesItem> _getChildren() {
    var list = widget.children;
    var currentTitle = '';
    var children = <TDIndexesItem>[];
    var temp = <IndexesItemProps>[];

    list.sort((a, b) => a.label.compareTo(b.label));

    for (var i = 0; i < list.length; i++) {
      var el = list[i];
      if (i == 0) {
        currentTitle = el.label[0];
      } else {
        if (el.label[0] != currentTitle) {
          children.add(TDIndexesItem(header: currentTitle, children: temp));
          currentTitle = el.label[0];
          temp = [];
        }
      }
      temp.add(el);
    }
    children.add(TDIndexesItem(header: currentTitle, children: temp));

    return children;
  }

  List<String> _getSliverChildren() {
    var children = <String>[];
    for (var i = 0; i < widget.children.length; i++) {
      var child = widget.children[i];
      children.add(child.label[0]);
    }
    children.sort();
    return children.toSet().toList();
  }
}
