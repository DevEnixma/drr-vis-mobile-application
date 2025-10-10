import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wts_bloc/blocs/collaborative/collaborative_bloc.dart';
import 'package:wts_bloc/data/models/collaborative/collaborative_res.dart';

import '../../../utils/constants/color_app.dart';
import '../../../utils/constants/text_style.dart';

class CollaborativeWidget extends StatefulWidget {
  const CollaborativeWidget({
    super.key,
    required this.collaborative,
  });

  final CollaborativeRes collaborative;

  @override
  State<CollaborativeWidget> createState() => _CollaborativeWidgetState();
}

class _CollaborativeWidgetState extends State<CollaborativeWidget> {
  bool isSelect = false;

  @override
  void initState() {
    super.initState();
    isSelect = widget.collaborative.isSelected ?? false;
  }

  void selectItem(CollaborativeRes item) {
    context.read<CollaborativeBloc>().add(SelectedCollaborativeEvent(item));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        selectItem(widget.collaborative);
      },
      child: CheckboxListTile(
        activeColor: Theme.of(context).colorScheme.primary,
        title: Row(
          children: [
            Icon(Icons.person_add_alt_outlined, color: ColorApps.colorText),
            SizedBox(width: 16),
            Text(
              widget.collaborative.colname ?? '',
              style: AppTextStyle.title18normal(),
            ),
          ],
        ),
        controlAffinity: ListTileControlAffinity.leading,
        value: isSelect,
        onChanged: (bool? value) {
          setState(() {
            isSelect = value!;
          });
          selectItem(widget.collaborative);
        },
      ),
    );
  }
}
