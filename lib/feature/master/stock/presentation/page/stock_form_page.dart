import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:unggul_mobile/core/components/atom/atom_appbar.dart';
import 'package:unggul_mobile/core/components/atom/atom_textfield.dart';
import 'package:unggul_mobile/core/util/util.dart';
import 'package:unggul_mobile/feature/master/stock/data/model/stock_model.dart';
import 'package:unggul_mobile/feature/master/stock/presentation/bloc/stock_cubit.dart';
import 'package:unggul_mobile/feature/master/stock/presentation/bloc/stock_form_cubit.dart';
import 'package:unggul_mobile/feature/master/stock/presentation/bloc/stock_state.dart';

class StockFormPage extends StatefulWidget {
  const StockFormPage({super.key, this.id});
  final String? id;

  @override
  State<StockFormPage> createState() => _StockFormPageState();
}

class _StockFormPageState extends State<StockFormPage> {
  final formKey = GlobalKey<FormState>();
  final code = TextEditingController();
  final name = TextEditingController();
  final category = TextEditingController();
  final price = TextEditingController();

  @override
  void initState() {
    if (widget.id != null) initForEdit();
    super.initState();
  }

  void initForEdit() {
    final stocks = context.read<StockCubit>().state.stocks ?? [];
    final stock = stocks.firstWhere(
      (e) => e?.id == widget.id,
      orElse: () => null,
    );
    if (stock != null) {
      code.text = stock.code ?? '';
      name.text = stock.name ?? '';
      category.text = stock.category ?? '';
      price.text = formatCurrency(stock.price, symbol: '');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<StockFormCubit, StockFormState>(
      listener: (context, state) {
        if (state.isLoading == true) {
          context.loading(true);
        } else if (state.isLoading == false) {
          context.loading(false);
        } else if (state.error != null) {
          context.snackbarError(state.error);
        } else if (state.message != null) {
          context.snackbarSuccess(state.message ?? '');
          context.read<StockCubit>().getStocks();
          context.pop();
        }
      },
      child: Scaffold(
        appBar: AtomAppbar('${widget.id == null ? 'Tambah' : 'Ubah'} Barang'),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                AtomTextfield(
                  controller: code,
                  hint: 'Kode Barang',
                  validator: (text) =>
                      textFieldValidator(label: 'Kode Barang', value: text),
                ),
                AtomTextfield(
                  controller: name,
                  hint: 'Nama Barang',
                  validator: (text) =>
                      textFieldValidator(label: 'Nama Barang', value: text),
                ),
                AtomTextfield(
                  controller: category,
                  hint: 'Kategori',
                  validator: (text) =>
                      textFieldValidator(label: 'Kategori', value: text),
                ),
                AtomTextfield(
                  controller: price,
                  hint: 'Harga',
                  keyboardType: TextInputType.number,
                  prefixText: 'Rp ',
                  onChanged: (text) {
                    if (text.isNotEmpty) {
                      final value = text.replaceAll('.', '');
                      price.text = formatCurrency(value, symbol: '');
                    }
                  },
                  validator: (text) =>
                      textFieldValidator(label: 'Harga', value: text),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: FilledButton(
            onPressed: () {
              final validate = formKey.currentState?.validate() ?? false;
              if (validate) {
                final form = context.read<StockFormCubit>();
                final request = StockModelData(
                  id: widget.id,
                  code: code.text,
                  name: name.text,
                  category: category.text,
                  price: double.tryParse(price.text.replaceAll('.', '')),
                );
                form.manageStock(request: request);
              }
            },
            child: Text('Simpan'),
          ),
        ),
      ),
    );
  }
}
