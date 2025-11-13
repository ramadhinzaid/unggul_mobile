import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Unggul Mobile')),
      body: ListView(
        children: [
          ListTile(
            onTap: () {
              context.go('/sales');
            },
            leading: Icon(CupertinoIcons.cart),
            title: Text('Penjualan'),
            trailing: Icon(CupertinoIcons.chevron_forward),
          ),
          const Divider(height: 1),
          ListTile(
            onTap: () {
              context.go('/customers');
            },
            leading: Icon(CupertinoIcons.person_3),
            title: Text('Pelanggan'),
            trailing: Icon(CupertinoIcons.chevron_forward),
          ),
          const Divider(height: 1),
          ListTile(
            onTap: () {
              context.go('/stocks');
            },
            leading: Icon(CupertinoIcons.cube_box),
            title: Text('Barang'),
            trailing: Icon(CupertinoIcons.chevron_forward),
          ),
        ],
      ),
    );
  }
}
