import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:unggul_mobile/core/components/atom/atom_appbar.dart';
import 'package:unggul_mobile/core/components/atom/atom_list_item.dart';
import 'package:unggul_mobile/core/components/template/body_layout.dart';
import 'package:unggul_mobile/core/util/extension_custom.dart';
import 'package:unggul_mobile/feature/master/customer/domain/entity/customer_entity.dart';
import 'package:unggul_mobile/feature/master/customer/presentation/bloc/customer_cubit.dart';
import 'package:unggul_mobile/feature/master/customer/presentation/bloc/customer_state.dart';

class CustomerPage extends StatefulWidget {
  const CustomerPage({super.key});

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  @override
  void initState() {
    context.read<CustomerCubit>().getCustomers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AtomAppbar(
        'Pelanggan',
        add: () => context.go('/customers/create'),
      ),

      body: BlocListener<CustomerCubit, CustomerState>(
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
        child: BlocBuilder<CustomerCubit, CustomerState>(
          builder: (context, state) => BodyLayout<CustomerEntityData>(
            items: state.customers,
            builder: (customer) => AtomListItem(
              leading: '#${customer?.id}',
              title: '${customer?.name}',
              subtitle: '${customer?.domicile}, ${customer?.gender}',
              edit: () => context.go('/customers/${customer?.id}'),
              delete: () => context.read<CustomerCubit>().deleteCustomer(
                customer?.id ?? '',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
