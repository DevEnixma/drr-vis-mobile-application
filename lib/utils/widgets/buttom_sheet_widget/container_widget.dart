import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../blocs/master_data/province_master/province_master_bloc.dart';
import '../../constants/color_app.dart';
import '../../constants/text_style.dart';

class ContainerWidget extends StatefulWidget {
  const ContainerWidget({
    super.key,
    required this.data_list,
    required this.scrollController,
    required this.title,
    required this.onClose,
    this.label,
  });

  final List data_list;
  final ScrollController scrollController;
  final String title;
  final Function(String result) onClose;
  final String? label;

  @override
  State<ContainerWidget> createState() => _ListItemWidgetState();
}

class _ListItemWidgetState extends State<ContainerWidget> {
  TextEditingController controllerTextField = TextEditingController();
  List filteredDataList = [];

  @override
  void initState() {
    super.initState();
    filteredDataList = widget.data_list; // ตั้งค่าเริ่มต้นให้แสดงข้อมูลทั้งหมด
  }

  void onChangedSearch(String value) {
    setState(() {
      filteredDataList = widget.data_list;
    });
    if (widget.label == 'provinceMasterData') {
      getProvince(value);
    }
  }

  void getProvince(String value) {
    context.read<ProvinceMasterBloc>().add(GetProvinceMaster(value));
  }

  void onSelected(dynamic value) {}

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
                          onChanged: onChangedSearch,
                          decoration: InputDecoration(
                            hintText: 'ค้นหา${widget.title}',
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
                return ListTile(
                  onTap: () {
                    widget.onClose('test');
                    onSelected(item);
                  },
                  title: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.h),
                      child: Text(
                        widget.label == 'provinceMasterData' ? item.nameTh ?? '' : '',
                        style: AppTextStyle.title16normal(),
                      )),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
