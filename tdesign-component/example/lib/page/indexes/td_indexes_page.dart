import 'package:flutter/material.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../annotation/demo.dart';
import '../../base/example_widget.dart';

///
/// TDIndexesPage演示
///
class TDIndexesPage extends StatefulWidget {
  const TDIndexesPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TDIndexesPageState();
  }
}

class TDIndexesPageState extends State<TDIndexesPage> {
  @override
  Widget build(BuildContext context) {
    var current = buildWidget(context);
    return current;
  }

  Widget buildWidget(BuildContext context) {
    return ExamplePage(
        title: tdTitle(),
        exampleCodeGroup: 'sideBar',
        desc: '用于页面中信息快速检索，可以根据目录中的页码快速找到所需的内容。',
        children: [
          ExampleModule(title: '组件类型', children: [
            ExampleItem(
                desc: '索引用法',
                ignoreCode: true,
                builder: _buildNavigatorSideBar),
          ]),
        ]);
  }

  Widget _buildNavigatorSideBar(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            CodeWrapper(
              builder: (_) => getCustomButton(context, '字母索引', 'indexesLetter'),
              methodName: '_buildIndexesLetter',
            ),
          ],
        ));
  }

  TDButton getCustomButton(
      BuildContext context, String text, String routeName) {
    return TDButton(
      text: text,
      width: MediaQuery.of(context).size.width - 16 * 2,
      size: TDButtonSize.large,
      type: TDButtonType.outline,
      shape: TDButtonShape.rectangle,
      theme: TDButtonTheme.primary,
      onTap: () {
        Navigator.pushNamed(context,
            PlatformUtil.isWeb ? routeName : '$routeName?showAction=1');
      },
    );
  }
}
