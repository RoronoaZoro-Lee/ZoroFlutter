import 'package:flutter/cupertino.dart';
import 'package:zoro_flutter/common/common.dart';
import 'package:zoro_flutter/ui/main_page/widget_detail_handle.dart';
import 'package:zoro_flutter/widget/model/widget_model.dart';
import 'package:zoro_flutter/widget/widget_data_manage.dart';

///详情
class WidgetDetailPage extends StatefulWidget {
  static final route = 'WidgetDetailPage';
  final String widgetName;

  const WidgetDetailPage({
    Key key,
    @required this.widgetName,
  }) : super(key: key);

  @override
  _WidgetDetailPageState createState() => _WidgetDetailPageState();
}

class _WidgetDetailPageState extends State<WidgetDetailPage> {
  String get _widgetName => widget.widgetName;
  WidgetModel _widgetModel;

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top + 10),
          _buildBar(),
          _buildHead(),
          _buildDivider(),
          _buildDemo(),
          _buildDivider(),
          _buildInfo(),
        ],
      ),
    );
  }

  ///bar
  Widget _buildBar() => Container(
        width: double.maxFinite,
        padding: commonPadding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Icon(Icons.arrow_back_ios, size: 20),
            ),
            Row(
              children: [
                InkWell(
                  onTap: _collection,
                  child: Icon(Icons.star_border, size: 20),
                ),
                SizedBox(width: Width.w_16),
                InkWell(
                  onTap: _code,
                  child: Icon(Icons.code, size: 20),
                ),
                SizedBox(width: Width.w_16),
                InkWell(
                  onTap: _share,
                  child: Icon(Icons.share, size: 20),
                ),
              ],
            )
          ],
        ),
      );

  Widget _buildHead() => Container(
        padding: commonPadding,
        margin: commonPadding,
        decoration: BoxDecoration(
          color: MyColors.green_100,
          borderRadius: commonRadius,
        ),
        child: Row(
          children: [
            Hero(
                tag: _widgetName,
                child: ClipRRect(
                  borderRadius: commonLittleRadius,
                  child: Container(
                    width: 50,
                    height: 50,
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: Text("未定"),
                  ),
                )),
            SizedBox(width: Width.w_16),
            ConstrainedBox(
              constraints: BoxConstraints(minHeight: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Text(_widgetModel?.name ?? ''),
                      SizedBox(width: Width.w_10),
                      Text(_widgetModel?.nameCN ?? ''),
                    ],
                  ),
                  SizedBox(height: Height.h_5),
                  Text(_widgetModel?.desc ?? ''),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _buildDivider() => Container(
        width: double.maxFinite,
        child: Divider(),
      );

  ///具体demo
  Widget _buildDemo() => Container(
        padding: EdgeInsets.symmetric(vertical: Height.h_5),
        child: WidgetDetailHandle().getDemo(_widgetName),
      );

  Widget _buildInfo() => Container(
        padding: commonPaddingHorizontal,
        color: Colors.grey.shade100,
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: (_widgetModel?.info ?? [])
              .map((e) => Padding(
                    padding: EdgeInsets.only(top: Height.h_10),
                    child: Text(e),
                  ))
              .toList(),
        ),
      );

  void _collection() {}

  void _code() {}

  void _share() {}

  //初始化数据
  void _init() {
    if (WidgetDataManage.widgetMap != null &&
        WidgetDataManage.widgetMap[_widgetName] != null) {
      _widgetModel =
          WidgetModel.fromJson(WidgetDataManage.widgetMap[_widgetName]);
    }
    if (mounted) setState(() {});
  }
}
