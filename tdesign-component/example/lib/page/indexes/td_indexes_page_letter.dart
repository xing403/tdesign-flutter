import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../annotation/demo.dart';
import '../../base/example_widget.dart';

///
/// TDIndexesLetterPage
///
class TDIndexesLetterPage extends StatefulWidget {
  const TDIndexesLetterPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TDSideBarAnchorPageState();
  }
}

class TDSideBarAnchorPageState extends State<TDIndexesLetterPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var current = buildWidget(context);
    return current;
  }

  Widget buildWidget(BuildContext context) {
    return ExamplePage(
        title: 'Indexes 字母索引',
        exampleCodeGroup: 'indexes',
        showSingleChild: true,
        singleChild: CodeWrapper(
          isCenter: false,
          builder: _buildIndexesLetter,
        ));
  }

  @Demo(group: 'indexes')
  Widget _buildIndexesLetter(BuildContext context) {
    final list = List.generate(5 * 26, (i) {
      var letter = String.fromCharCode((65 + (i / 5).floor()));
      var str = '$letter Item${(i % 5) + 1}';

      return IndexesItemProps(
        label: str,
        value: str,
      );
    });
    return TDIndexes(
      children: list,
    );
  }
}
