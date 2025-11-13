import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:unggul_mobile/core/components/atom/atom_appbar.dart';
import 'package:unggul_mobile/core/components/atom/atom_date_picker.dart';
import 'package:unggul_mobile/core/components/atom/atom_dropdown.dart';
import 'package:unggul_mobile/core/components/atom/atom_textfield.dart';
import 'package:unggul_mobile/core/util/util.dart';
import 'package:unggul_mobile/feature/master/customer/domain/entity/customer_entity.dart';
import 'package:unggul_mobile/feature/master/customer/presentation/bloc/customer_cubit.dart';
import 'package:unggul_mobile/feature/master/stock/data/model/stock_model.dart';
import 'package:unggul_mobile/feature/master/stock/domain/entity/stock_entity.dart';
import 'package:unggul_mobile/feature/master/stock/presentation/bloc/stock_cubit.dart';
import 'package:unggul_mobile/feature/transaction/sale/data/model/sale_request.dart';
import 'package:unggul_mobile/feature/transaction/sale/presentation/bloc/sale_cubit.dart';
import 'package:unggul_mobile/feature/transaction/sale/presentation/bloc/sale_form_cubit.dart';
import 'package:unggul_mobile/feature/transaction/sale/presentation/bloc/sale_state.dart';

class SaleFormPage extends StatefulWidget {
  const SaleFormPage({super.key, this.id});
  final String? id;

  @override
  State<SaleFormPage> createState() => _SaleFormPageState();
}

class _SaleFormPageState extends State<SaleFormPage> {
  final formKey = GlobalKey<FormState>();
  // Masters
  List<CustomerEntityData?> customers = [];
  List<StockEntityData?> stocks = [];
  List<StockEntityData?> stocksTemp = [];

  DateTime date = DateTime.now();
  CustomerEntityData? customer;
  List<Map<String, TextEditingController>> products = [];
  List<StockEntityData?> productsRequest = [];

  @override
  void initState() {
    customers = context.read<CustomerCubit>().state.customers ?? [];
    stocks.addAll(context.read<StockCubit>().state.stocks ?? []);
    stocksTemp.addAll(stocks);
    if (widget.id != null) initForEdit();
    super.initState();
  }

  void initForEdit() {
    final sales = context.read<SaleCubit>().state.sales ?? [];
    final sale = sales.firstWhere(
      (e) => e?.note == widget.id,
      orElse: () => null,
    );
    if (sale != null) {
      setState(() {
        date = DateTime.tryParse(sale.date ?? '') ?? DateTime.now();
        customer = sale.customer;
        if ((sale.products ?? []).isNotEmpty) {
          products = sale.products!
              .map(
                (e) => {
                  'qty': TextEditingController(text: e?.qty.toString()),
                  'code': TextEditingController(text: e?.name),
                },
              )
              .toList();
          productsRequest = sale.products ?? [];
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SaleFormCubit, SaleFormState>(
      listener: (context, state) {
        if (state.isLoading == true) {
          context.loading(true);
        } else if (state.isLoading == false) {
          context.loading(false);
        } else if (state.error != null) {
          context.snackbarError(state.error);
        } else if (state.message != null) {
          context.snackbarSuccess(state.message ?? '');
          context.read<SaleCubit>().getSales();
          context.pop();
        }
      },
      child: Scaffold(
        appBar: AtomAppbar(
          '${widget.id == null ? 'Tambah' : 'Ubah'} Penjualan',
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                AtomDatePicker(
                  initialValue: date,
                  onChanged: (value) {
                    date = value ?? DateTime.now();
                  },
                ),
                AtomDropdown<CustomerEntityData>(
                  initialValue: customer,
                  label: 'Pelanggan',
                  onSelected: (value) {
                    customer = value;
                  },
                  items: customers
                      .map(
                        (e) =>
                            DropdownMenuEntry(value: e, label: e?.name ?? ''),
                      )
                      .toList(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Produk'),
                    IconButton(
                      onPressed: () {
                        if (products.length < stocksTemp.length) {
                          productsRequest.add(StockEntityData(qty: 1));
                          setState(() {
                            products.add({
                              'qty': TextEditingController(text: '1'),
                              'code': TextEditingController(),
                            });
                          });
                        }
                      },
                      icon: Icon(CupertinoIcons.plus),
                    ),
                  ],
                ),
                Column(
                  spacing: 8,
                  children: products
                      .mapIndexed(
                        (id, e) => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 8,
                          children: [
                            Expanded(
                              flex: 2,
                              child: AtomDropdown<StockEntityData>(
                                label: 'Produk',
                                controller: e['code'],
                                margin: EdgeInsets.zero,
                                onSelected: (value) {
                                  if (value?.code != null) {
                                    productsRequest[id] = productsRequest[id]
                                        ?.copyWith(code: value?.code);
                                    setState(
                                      () => stocks.removeWhere(
                                        (e) => e?.code == value?.code,
                                      ),
                                    );
                                  }
                                },
                                items: stocks
                                    .map(
                                      (e) => DropdownMenuEntry(
                                        value: e,
                                        label: e?.name ?? '',
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                            Expanded(
                              child: AtomTextfield(
                                hint: 'QTY',
                                controller: e['qty'],
                                keyboardType: TextInputType.number,
                                margin: EdgeInsets.zero,
                                onChanged: (v) =>
                                    productsRequest[id] = productsRequest[id]
                                        ?.copyWith(qty: int.tryParse(v)),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                if (productsRequest[id]?.code != null) {
                                  final stock = stocksTemp.firstWhereOrNull(
                                    (e) => e?.code == productsRequest[id]?.code,
                                  );

                                  setState(() {
                                    stocks.add(stock);
                                  });
                                }
                                productsRequest.removeAt(id);

                                setState(() {
                                  products.removeAt(id);
                                });
                              },
                              icon: Icon(CupertinoIcons.delete),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: FilledButton(
            onPressed: () {
              final validate =
                  customer?.id != null &&
                  productsRequest.isNotEmpty &&
                  productsRequest.every(
                    (e) => e?.code != null && (e?.qty ?? 0) > 0,
                  );
              if (validate) {
                final form = context.read<SaleFormCubit>();
                final request = SaleRequest(
                  customerId: customer?.id,
                  date: formatDate(date, format: 'yyyy-MM-dd'),
                  products: productsRequest
                      .map((e) => StockModelData(code: e?.code, qty: e?.qty))
                      .toList(),
                );
                form.manageSales(id: widget.id, request: request);
              } else {
                context.snackbarError(ErrorEntity(message: 'Lengkapi form'));
              }
            },
            child: Text('Simpan'),
          ),
        ),
      ),
    );
  }
}
