import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:unggul_mobile/core/components/atom/atom_appbar.dart';
import 'package:unggul_mobile/core/components/atom/atom_list_item.dart';
import 'package:unggul_mobile/core/components/template/body_layout.dart';
import 'package:unggul_mobile/core/util/util.dart';
import 'package:unggul_mobile/feature/master/customer/presentation/bloc/customer_cubit.dart';
import 'package:unggul_mobile/feature/master/stock/presentation/bloc/stock_cubit.dart';
import 'package:unggul_mobile/feature/transaction/sale/domain/entity/sale_entity.dart';
import 'package:unggul_mobile/feature/transaction/sale/presentation/bloc/sale_cubit.dart';
import 'package:unggul_mobile/feature/transaction/sale/presentation/bloc/sale_state.dart';

class SalePage extends StatefulWidget {
  const SalePage({super.key});

  @override
  State<SalePage> createState() => _SalePageState();
}

class _SalePageState extends State<SalePage> {
  @override
  void initState() {
    context.read<CustomerCubit>().getCustomers();
    context.read<StockCubit>().getStocks();
    context.read<SaleCubit>().getSales();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AtomAppbar(
        'Penjualan',
        add: () {
          context.go('/sales/create');
        },
      ),
      body: BlocListener<SaleCubit, SaleState>(
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
        child: BlocBuilder<SaleCubit, SaleState>(
          builder: (context, state) => BodyLayout<SaleEntityData>(
            items: state.sales,
            builder: (sale) => AtomListItem(
              leading: '#${sale?.note}',
              title: sale?.customer?.name,
              subtitle: formatCurrency(sale?.subtotal),
              edit: () => context.go('/sales/${sale?.note}'),
              delete: () =>
                  context.read<SaleCubit>().deleteSale(sale?.note ?? ''),
            ),
          ),
        ),
      ),
    );
  }
}
