import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AtomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const AtomAppbar(this.title, {super.key, this.add});

  final String title;
  final Function()? add;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actionsPadding: EdgeInsets.only(right: 16),
      actions: [
        if (add != null)
          IconButton.outlined(onPressed: add, icon: Icon(CupertinoIcons.add)),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
