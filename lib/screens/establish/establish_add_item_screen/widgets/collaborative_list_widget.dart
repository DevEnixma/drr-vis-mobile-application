import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../utils/constants/color_app.dart';
import '../../../../utils/constants/text_style.dart';
import '../../../../utils/widgets/custom_button.dart';
import '../../widgets/collaborative_widget.dart';

class CollaborativeListWidget extends StatefulWidget {
  const CollaborativeListWidget({
    super.key,
    required this.data_list,
    required this.scrollController,
    required this.title,
    required this.onClose,
    this.label,
    this.onSearchFocused,
  });

  final List data_list;
  final ScrollController scrollController;
  final String title;
  final Function(String result) onClose;
  final String? label;
  final Function(bool isFocused)? onSearchFocused;

  @override
  State<CollaborativeListWidget> createState() => _CollaborativeListWidgetState();
}

class _CollaborativeListWidgetState extends State<CollaborativeListWidget> {
  TextEditingController controllerTextField = TextEditingController();
  List filteredDataList = [];

  @override
  void initState() {
    super.initState();
    filteredDataList = widget.data_list; // ตั้งค่าเริ่มต้นให้แสดงข้อมูลทั้งหมด
  }

  void onChangedText(String value) {
    setState(() {
      if (value.isEmpty) {
        filteredDataList = widget.data_list;
      } else {
        filteredDataList = widget.data_list.where((item) {
          return item.colname.contains(value);
        }).toList();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    controllerTextField.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        boxShadow: [
          BoxShadow(
            color: ColorApps.colorMain,
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 5,
            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Row(
            children: [
              SizedBox(width: 16),
              Text(
                widget.title,
                style: AppTextStyle.title18bold(),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onTertiaryContainer,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/svg/ri_search-line.svg',
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Focus(
                    onFocusChange: (isFocused) {
                      if (widget.onSearchFocused != null) {
                        widget.onSearchFocused!(isFocused);
                      }
                    },
                    child: TextField(
                      controller: controllerTextField,
                      onChanged: onChangedText,
                      decoration: InputDecoration(
                        hintText: 'ค้นหา${widget.title}...',
                        hintStyle: AppTextStyle.title16normal(color: ColorApps.colorGray),
                        border: InputBorder.none,
                      ),
                      style: AppTextStyle.title18bold(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => Divider(
                color: Theme.of(context).colorScheme.tertiaryContainer,
                height: 1,
                indent: 20,
                endIndent: 20,
              ),
              controller: widget.scrollController,
              itemCount: filteredDataList.length,
              itemBuilder: (context, index) {
                var item = filteredDataList[index];
                return CollaborativeWidget(
                  collaborative: item,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: CustomeButton(
              text: 'ยืนยัน',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          SizedBox(height: 12.w),
        ],
      ),
    );
  }
}
