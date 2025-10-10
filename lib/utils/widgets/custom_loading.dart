import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../constants/text_style.dart';

class CustomLoading {
  static void showLoadingDialog(BuildContext context, Color color) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            padding: EdgeInsets.symmetric(vertical: 20),
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LoadingAnimationWidget.halfTriangleDot(
                  color: color,
                  size: 50,
                ),
                SizedBox(height: 20),
                Text(
                  'Loading...',
                  style: AppTextStyle.title16normal(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void dismissLoadingDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}


// class CustomLoading {
//   static bool isDialogShown = false;

//   static void showLoadingDialog(BuildContext context, Color color) {
//     if (!isDialogShown) {
//       isDialogShown = true;
//       showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (BuildContext context) {
//           return Dialog(
//             backgroundColor: Colors.transparent,
//             elevation: 0,
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               padding: EdgeInsets.symmetric(vertical: 20),
//               margin: EdgeInsets.symmetric(horizontal: 30),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   LoadingAnimationWidget.halfTriangleDot(
//                     color: color,
//                     size: 50,
//                   ),
//                   SizedBox(height: 20),
//                   Text(
//                     'Loading...',
//                     style: AppTextStyle.title16normal(),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ).then((_) {
//         // ตั้งค่าให้เป็น false เมื่อ dialog ถูกปิด
//         isDialogShown = false;
//       });
//     }
//   }

//   static void dismissLoadingDialog(BuildContext context) {
//     if (isDialogShown) {
//       Navigator.of(context, rootNavigator: true).pop();
//       isDialogShown = false;
//     }
//   }
// }
