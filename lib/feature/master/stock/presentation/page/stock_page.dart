import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:unggul_mobile/core/components/atom/atom_appbar.dart';
import 'package:unggul_mobile/core/components/atom/atom_list_item.dart';
import 'package:unggul_mobile/core/components/template/body_layout.dart';
import 'package:unggul_mobile/core/util/util.dart';
import 'package:unggul_mobile/feature/master/stock/domain/entity/stock_entity.dart';
import 'package:unggul_mobile/feature/master/stock/presentation/bloc/stock_cubit.dart';
import 'package:unggul_mobile/feature/master/stock/presentation/bloc/stock_state.dart';

class StockPage extends StatefulWidget {
  const StockPage({super.key});

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  @override
  void initState() {
    context.read<StockCubit>().getStocks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AtomAppbar('Barang', add: () => context.go('/stocks/create')),
      body: BlocListener<StockCubit, StockState>(
        listener: (context, state) {
          if (state.isLoading == true) {
            context.loading(true);
          } else if (state.isLoading == false) {
            context.loading(false);
          } else if (state.error != null) {
            context.snackbarError(state.error);
          } else if (state.message != null) {
            context.snackbarSuccess(state.message ?? '');
          }
        },
        child: BlocBuilder<StockCubit, StockState>(
          builder: (context, state) => BodyLayout<StockEntityData>(
            items: state.stocks,
            builder: (stock) => AtomListItem(
              leading: '#${stock?.code}',
              title: '${stock?.name}',
              subtitle: '${stock?.category}, ${formatCurrency(stock?.price)}',
              edit: () => context.go('/stocks/${stock?.id}'),
              delete: () =>
                  context.read<StockCubit>().deleteStock(stock?.id ?? ''),
            ),
          ),
        ),
      ),
    );
  }
}
