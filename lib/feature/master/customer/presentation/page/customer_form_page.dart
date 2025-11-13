import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:unggul_mobile/core/components/atom/atom_appbar.dart';
import 'package:unggul_mobile/core/components/atom/atom_textfield.dart';
import 'package:unggul_mobile/core/util/util.dart'
    show ContextDialog, textFieldValidator;
import 'package:unggul_mobile/feature/master/customer/data/model/customer_model.dart';
import 'package:unggul_mobile/feature/master/customer/presentation/bloc/customer_cubit.dart';
import 'package:unggul_mobile/feature/master/customer/presentation/bloc/customer_form_cubit.dart';
import 'package:unggul_mobile/feature/master/customer/presentation/bloc/customer_state.dart';

class CustomerFormPage extends StatefulWidget {
  const CustomerFormPage({super.key, this.id});
  final String? id;

  @override
  State<CustomerFormPage> createState() => _CustomerFormPageState();
}

class _CustomerFormPageState extends State<CustomerFormPage> {
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final domicile = TextEditingController();
  bool gender = true;

  @override
  void initState() {
    if (widget.id != null) initForEdit();
    super.initState();
  }

  void initForEdit() {
    final customers = context.read<CustomerCubit>().state.customers ?? [];
    final customer = customers.firstWhere(
      (e) => e?.id == widget.id,
      orElse: () => null,
    );
    if (customer != null) {
      name.text = customer.name ?? '';
      domicile.text = customer.domicile ?? '';
      setState(() {
        gender = customer.gender == 'Pria';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CustomerFormCubit, CustomerFormState>(
      listener: (context, state) {
        if (state.isLoading == true) {
          context.loading(true);
        } else if (state.isLoading == false) {
          context.loading(false);
        } else if (state.error != null) {
          context.snackbarError(state.error);
        } else if (state.message != null) {
          context.snackbarSuccess(state.message ?? '');
          context.read<CustomerCubit>().getCustomers();
          context.pop();
        }
      },
      child: Scaffold(
        appBar: AtomAppbar(
          '${widget.id == null ? 'Tambah' : 'Ubah'} Pelanggan',
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                AtomTextfield(
                  controller: name,
                  hint: 'Nama Pelanggan',
                  validator: (text) =>
                      textFieldValidator(label: 'Nama Pelanggan', value: text),
                ),
                AtomTextfield(
                  controller: domicile,
                  hint: 'Domisili',
                  validator: (text) =>
                      textFieldValidator(label: 'Domisili', value: text),
                ),
                RadioGroup(
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value ?? true;
                    });
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Jenis Kelamin:'),
                      RadioListTile(value: true, title: Text('Pria')),
                      RadioListTile(value: false, title: Text('Wanita')),
                    ],
                  ),
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
                final form = context.read<CustomerFormCubit>();
                final request = CustomerModelData(
                  id: widget.id,
                  name: name.text,
                  domicile: domicile.text,
                  gender: gender ? 'Pria' : 'Wanita',
                );
                form.manageCustomer(request: request);
              }
            },
            child: Text('Simpan'),
          ),
        ),
      ),
    );
  }
}
