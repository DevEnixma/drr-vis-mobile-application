import 'package:flutter/material.dart';

import '../constants/color_app.dart';
import '../constants/text_style.dart';

// ไม่ได้ใช้

class CustomBottomSheet extends StatelessWidget {
  final ScrollController scrollController;
  const CustomBottomSheet({super.key, required this.scrollController});

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
          SizedBox(height: 10),

          // Search Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onTertiaryContainer,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                Icon(Icons.search, color: Colors.grey),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'ทั้งหมด',
                      hintStyle: AppTextStyle.title16normal(color: ColorApps.colorGray),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              SizedBox(width: 16),
              const Text(
                'รายการรถ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              controller: scrollController, // Apply scrollController here
              itemCount: 6, // Number of items in the list
              itemBuilder: (context, index) {
                final vehicles = [
                  {'title': '80-6822 จังหวัดมุกดาหาร', 'subtitle': 'กม.4 ประเภท รถพ่วง (ยาง 8 ล้อ)', 'color': Colors.red},
                  {'title': '70-0986 จังหวัดร้อยเอ็ด', 'subtitle': 'กม.17 ประเภท รถพ่วง (ยาง 8 ล้อ)', 'color': Colors.green},
                  {'title': '70-2696 จังหวัดพระนครศรีอยุธยา', 'subtitle': 'กม.4 ประเภท รถพ่วง (ยาง 8 ล้อ)', 'color': Colors.yellow},
                ];

                final vehicle = vehicles[index % vehicles.length]; // Cycle through vehicle data

                return _buildVehicleItem(
                  context,
                  vehicle['title'] as String,
                  vehicle['subtitle'] as String,
                  vehicle['color'] as Color,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleItem(BuildContext context, String title, String subtitle, Color color) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color,
        child: const Icon(Icons.local_shipping_outlined, color: Colors.white),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      subtitle: Text(subtitle),
    );
  }
}
