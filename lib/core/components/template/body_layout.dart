import 'package:flutter/material.dart';
import 'package:unggul_mobile/core/components/atom/atom_empty_list.dart';
import 'package:unggul_mobile/core/components/molecule/molecule_list_view.dart';

class BodyLayout<T> extends StatelessWidget {
  const BodyLayout({super.key, required this.items, required this.builder});

  final List<T?>? items;
  final Widget Function(T?) builder;

  @override
  Widget build(BuildContext context) {
    if (items == null) {
      return Center(child: CircularProgressIndicator());
    } else if ((items ?? []).isEmpty) {
      return Center(child: AtomEmptyList(width: 140));
    }

    return MoleculeListView(
      itemBuilder: (c, id) => builder(items?[id]),
      itemCount: items?.length ?? 0,
    );
  }
}
