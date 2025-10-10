import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../blocs/master_data/province_master/province_master_bloc.dart';
import '../../constants/color_app.dart';
import '../../constants/text_style.dart';

class CustomModalBottomSheet2 extends StatefulWidget {
  const CustomModalBottomSheet2({
    super.key,
    required this.data_list,
    required this.scrollController,
    required this.title,
    required this.onClose,
    required this.onSelectItem,
    this.label,
    this.keyRelation,
  });

  final List data_list;
  final ScrollController scrollController;
  final String title;
  final Function(String result) onClose;
  final Function(dynamic, String) onSelectItem;
  final String? label;
  final String? keyRelation;

  @override
  State<CustomModalBottomSheet2> createState() => _CustomModalBottomSheetState();
}

class _CustomModalBottomSheetState extends State<CustomModalBottomSheet2> {
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
          if (widget.label == 'provinceMasterData') {
            return item.nameTh.contains(value);
          }
          if (widget.label == 'disctrictMasterData') {
            return item.nameTh.contains(value);
          }
          if (widget.label == 'subDisctrictMasterData') {
            return item.nameTh.contains(value);
          }
          return false;
        }).toList();
      }
    });

    if (widget.label == 'provinceMasterData') {
      context.read<ProvinceMasterBloc>().add(GetProvinceMaster(value));
    }

    if (widget.label == 'disctrictMasterData') {
      context.read<ProvinceMasterBloc>().add(GetDistrictMaster(value, widget.keyRelation!));
    }

    if (widget.label == 'subDisctrictMasterData') {
      context.read<ProvinceMasterBloc>().add(GetSubDistrictMaster(value, widget.keyRelation!));
    }
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
            color: Theme.of(context).colorScheme.tertiaryFixed,
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Wraps content height
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
          SizedBox(height: 12.h),
          Row(
            children: [
              SizedBox(width: 22.h),
              Text(
                widget.title,
                style: AppTextStyle.title18bold(),
              ),
            ],
          ),
          // Search Bar
          widget.title == 'ประเภทรถบรรทุก'
              ? SizedBox.shrink()
              : Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onTertiaryContainer,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: controllerTextField,
                          onChanged: onChangedText,
                          decoration: InputDecoration(
                            hintText: 'ค้นหา${widget.title}...',
                            hintStyle: AppTextStyle.title16normal(color: ColorApps.colorGray),
                            border: InputBorder.none,
                          ),
                          style: AppTextStyle.title16normal(),
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
                var itemString = filteredDataList[index].toString();

                // กำหนดข้อความที่จะแสดงตามเงื่อนไข
                final String displayText;
                if (widget.label == 'provinceMasterData') {
                  displayText = item.nameTh ?? '';
                } else if (widget.label == 'disctrictMasterData') {
                  displayText = item.nameTh ?? '';
                } else if (widget.label == 'subDisctrictMasterData') {
                  displayText = item.nameTh ?? '';
                } else {
                  displayText = '';
                }
                return ListTile(
                  onTap: () {
                    widget.onClose('test');
                    widget.onSelectItem(item, widget.label!);
                  },
                  title: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.h),
                    child: Text(
                      displayText,
                      style: AppTextStyle.title16normal(),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
