import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wts_bloc/blocs/materials/materials_bloc.dart';
import 'package:wts_bloc/blocs/province/province_bloc.dart';
import 'package:wts_bloc/blocs/vehicle_car/vehicle_car_bloc.dart';

import '../../../../data/models/master_data/material/material_model_req.dart';
import '../../../../utils/constants/color_app.dart';
import '../../../../utils/constants/text_style.dart';

class CustomModalBottomSheet extends StatefulWidget {
  const CustomModalBottomSheet({
    super.key,
    required this.data_list,
    required this.scrollController,
    required this.title,
    required this.onClose,
    this.label,
    this.onSelectItem,
    this.isUseSearch,
  });

  final List data_list;
  final ScrollController scrollController;
  final String title;
  final Function(String result) onClose;
  final String? label;
  final Function(dynamic, String)? onSelectItem;
  final bool? isUseSearch;

  @override
  State<CustomModalBottomSheet> createState() => _CustomModalBottomSheetState();
}

class _CustomModalBottomSheetState extends State<CustomModalBottomSheet> {
  TextEditingController controllerTextField = TextEditingController();
  List filteredDataList = [];

  @override
  void initState() {
    super.initState();
    filteredDataList = widget.data_list; // ตั้งค่าเริ่มต้นให้แสดงข้อมูลทั้งหมด
  }

  @override
  void didUpdateWidget(CustomModalBottomSheet oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.data_list != widget.data_list) {
      setState(() {
        filteredDataList = widget.data_list;
      });
    }
  }

  void onChangedText(String value) {
    setState(() {
      if (value.isEmpty) {
        filteredDataList = widget.data_list;
      } else {
        filteredDataList = widget.data_list.where((item) {
          if (widget.title == 'จังหวัด' || widget.title == 'จังหวัดหางลาก') {
            return item.name?.contains(value) ?? false;
          } else if (widget.title == 'สิ่งของบรรทุก' || widget.title == 'บรรทุกสินค้าประเภท') {
            return item.goodsName?.contains(value) ?? false;
          } else if (widget.title == 'ประเภทรถบรรทุก') {
            return item.vehicleClassDesc?.contains(value) ?? false;
          }
          return false;
        }).toList();
      }
    });

    if (widget.title == 'จังหวัด') {
      context.read<ProvinceBloc>().add(GetProvince(value));
    }
    if (widget.title == 'สิ่งของบรรทุก') {
      var payload = MaterialModelReq(
        search: value,
        page: 1,
        pageSize: 20,
      );
      context.read<MaterialsBloc>().add(GetMaterialsEvent(payload));
    }

    if (widget.title == 'บรรทุกสินค้าประเภท') {
      var payload = MaterialModelReq(
        search: value,
        page: 1,
        pageSize: 20,
      );
      context.read<MaterialsBloc>().add(GetMaterialsEvent(payload));
    }
  }

  String _getItemDisplayText(dynamic item) {
    if (widget.title == 'ประเภทรถบรรทุก') {
      return item.vehicleClassDesc ?? '';
    } else if (widget.title == 'จังหวัด' || widget.title == 'จังหวัดหางลาก') {
      return item.name ?? '';
    } else if (widget.label == 'arrest' || widget.label == 'police') {
      return item.name ?? '';
    } else if (widget.title == 'สิ่งของบรรทุก' || widget.title == 'บรรทุกสินค้าประเภท') {
      return item.goodsName ?? 'ไม่มีชื่อสินค้า';
    } else {
      return item.name ?? item.toString();
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
          widget.isUseSearch != null
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
                          style: AppTextStyle.title16normal(color: ColorApps.colorText),
                          decoration: InputDecoration(
                            hintText: 'ค้นหา${widget.title}...',
                            hintStyle: AppTextStyle.title16normal(color: ColorApps.colorGray),
                            border: InputBorder.none,
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

                return ListTile(
                  onTap: () {
                    widget.onClose('test');

                    // จัดการการเลือก item ตาม title
                    if (widget.title == 'ประเภทรถบรรทุก') {
                      context.read<VehicleCarBloc>().add(SelectVehicleCarEvent(item));
                    } else if (widget.title == 'จังหวัด') {
                      context.read<ProvinceBloc>().add(SelectProvince(item));
                    } else if (widget.title == 'จังหวัดหางลาก') {
                      context.read<ProvinceBloc>().add(SelectProvinceTail(item));
                    } else if (widget.title == 'สิ่งของบรรทุก' || widget.title == 'บรรทุกสินค้าประเภท') {
                      context.read<MaterialsBloc>().add(SelectMaterialsEvent(item));
                    }

                    // จัดการตาม label (สำหรับกรณีพิเศษ)
                    if (widget.label == 'arrest') {
                      context.read<ProvinceBloc>().add(SelectProvinceArrest(item));
                    } else if (widget.label == 'police') {
                      context.read<ProvinceBloc>().add(SelectProvincePolice(item));
                    }
                  },
                  title: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.h),
                    child: Text(
                      _getItemDisplayText(item),
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
