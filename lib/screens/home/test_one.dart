import 'package:flutter/material.dart';

import '../../utils/constants/text_style.dart';
import '../widgets/empty_widget.dart';

class TestOne extends StatefulWidget {
  final String title;
  const TestOne({super.key, required this.title});

  @override
  State<TestOne> createState() => _TestOneState();
}

class _TestOneState extends State<TestOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: AppTextStyle.title18bold(color: Theme.of(context).colorScheme.surface),
        ),
      ),
      body: EmptyWidget(
        title: 'กรุณาเข้าร่วมหน่วยชั่ง',
        label: 'ยังไม่สามารถจับกุมได้ \nกรุณาเข้าร่วมหน่วยชั่งก่อน',
      ),
    );
  }
}
