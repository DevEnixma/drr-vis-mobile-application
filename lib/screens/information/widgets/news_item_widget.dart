import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wts_bloc/data/models/news/news_model_res.dart';

import '../../../app/routes/routes.dart';
import '../../../utils/constants/text_style.dart';
import '../../../utils/libs/convert_date.dart';
import '../../../utils/widgets/html_content/html_fixline_widget.dart';
import '../../../utils/widgets/image_network.dart';

class NewsItemWidget extends StatefulWidget {
  const NewsItemWidget({
    super.key,
    required this.item,
  });

  final NewsModelRes item;

  @override
  State<NewsItemWidget> createState() => _NewsItemWidgetState();
}

class _NewsItemWidgetState extends State<NewsItemWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Routes.gotoInformationDetails(context, widget.item);
      },
      child: Column(
        children: [
          ListTile(
            leading: ImageNetwork(imageUrl: widget.item.newsThumbnail!),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.item.newsHeader ?? '', style: AppTextStyle.title16bold()),
                SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(5.r),
                        border: Border.all(color: Theme.of(context).colorScheme.primary),
                      ),
                      margin: EdgeInsets.symmetric(vertical: 6.0.h),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      child: Center(
                        child: Text(widget.item.createDate != null && widget.item.createDate != '' ? ConvertDate.convertDateToDDMMMMYYYYHHmm(widget.item.createDate!) : '-', style: AppTextStyle.title14bold(color: Theme.of(context).colorScheme.surface)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // subtitle: Text(
            //   maxLines: 3,
            //   widget.item.newsContent ?? '-',
            //   style: AppTextStyle.title14normal(),
            // ),
            subtitle: HtmlFixlineWidget(
              item: widget.item.newsContent ?? '<p>-</p>',
            ),
            isThreeLine: true,
          ),
          Divider(
            color: Theme.of(context).colorScheme.tertiaryContainer,
            height: 1,
            indent: 20,
            endIndent: 20,
          ),
        ],
      ),
    );
  }
}
