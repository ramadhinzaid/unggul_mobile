import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unggul_mobile/core/util/util.dart';

class AtomListItem extends StatelessWidget {
  const AtomListItem({
    super.key,
    this.delete,
    this.edit,
    this.leading,
    this.subtitle,
    this.title,
    this.view,
  });

  final String? leading;
  final String? title;
  final String? subtitle;

  final Function()? view;
  final Function()? delete;
  final Function()? edit;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: view,
      leading: Text(leading ?? ''),
      title: Text(title ?? ''),
      subtitleTextStyle: context.textStyle.labelSmall?.copyWith(
        color: context.colors.secondary,
      ),
      subtitle: (subtitle ?? '').isEmpty ? null : Text(subtitle ?? ''),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 4,
        children: [
          IconButton(onPressed: edit, icon: Icon(CupertinoIcons.square_pencil)),
          IconButton(
            onPressed: () {
              context.popupDelete(onNext: delete);
            },
            icon: Icon(CupertinoIcons.delete),
          ),
        ],
      ),
    );
  }
}
