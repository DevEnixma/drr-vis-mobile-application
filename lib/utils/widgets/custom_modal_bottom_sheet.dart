import 'package:flutter/material.dart';


//  อันนี้ใช้แบบไม่ต้องเลื่อน
class CustomModalBottomSheet extends StatelessWidget {
   final Widget? widgets;
    final void Function()? onPressed; 

  const CustomModalBottomSheet({
    super.key,
    this.widgets,
    this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 16.0,
        bottom: MediaQuery.of(context).viewInsets.bottom, // Adjusts for keyboard
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Wraps content height
        children: <Widget>[
          Container(
            width: 40,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(height: 20),
          widgets ?? SizedBox.shrink(),
          Text(
            'Custom Bottom Sheet',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Enter something',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Closes the bottom sheet
            },
            child: Text('Close'),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}