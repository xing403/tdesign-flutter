import 'package:flutter/material.dart';

import '../../../tdesign_flutter.dart';
import '../../theme/td_theme.dart';

class IndexesItemProps {
  const IndexesItemProps({
    this.label = '',
    this.value,
  });

  final String label;
  final String? value;
}

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
  List<Widget> _children = [];
  List<String> _sliverChildren = [];
  @override
  void initState() {
    super.initState();
    _children = _getChildren();
    _sliverChildren = _getSliverChildren();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          itemCount: _children.length,
          itemBuilder: (BuildContext context, int index) {
            return _children[index];
          },
        ),
        Container()
      ],
    );
  }

  ///  获取生成的全部索引块
  List<Widget> _getChildren() {
    var list = <IndexesItemProps>[];
    var currentTitle = '';
    var children = <Widget>[];
    widget.children.sort((a, b) => a.label.compareTo(b.label));
    for (var i = 0; i < widget.children.length; i++) {
      var el = widget.children[i];
      if (i == 0) {
        currentTitle = el.label[0];
      } else {
        if (el.label[0] != currentTitle) {
          children.add(_generateIndexBlock(currentTitle, list));
          currentTitle = el.label[0];
          list = [];
        }
      }
      list.add(el);
    }
    children.add(_generateIndexBlock(currentTitle, list));
    return children;
  }

  /// 把相同前缀名 item生成为同一个widget
  Widget _generateIndexBlock(String title, List<IndexesItemProps> list) {
    var children = <Widget>[];
    for (var i = 0; i < list.length; i++) {
      var item = list[i];

      children.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(children: [TDText(item.label)]),
      ));

      if (i < list.length - 1) {
        children.add(const TDDivider());
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: TDText(title),
        ),
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

  List<String> _getSliverChildren() {
    var children = <String>[];
    for (var i = 0; i < widget.children.length; i++) {
      var child = widget.children[i];
      children.add(child.label[0]);
    }
    children.sort();
    return children;
  }
}
