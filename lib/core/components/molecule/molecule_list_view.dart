import 'package:flutter/material.dart';

class MoleculeListView extends StatelessWidget {
  const MoleculeListView({
    super.key,
    required this.itemBuilder,
    this.itemCount,
  });

  final int? itemCount;
  final Widget? Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 16),
      itemBuilder: itemBuilder,
      separatorBuilder: (c, id) => const Divider(height: 1),
      itemCount: itemCount ?? 0,
    );
  }
}
