import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unggul_mobile/feature/master/customer/domain/usecase/customer_fetch_usecase.dart';
import 'package:unggul_mobile/feature/master/customer/domain/usecase/customer_manage_usecase.dart';
import 'package:unggul_mobile/feature/master/customer/presentation/bloc/customer_state.dart';

class CustomerCubit extends Cubit<CustomerState> {
  CustomerCubit(this._deleteUsecase, this._fetchUsecase)
    : super(CustomerState());

  // usecase
  final CustomerFetchUsecase _fetchUsecase;
  final CustomerManageUsecase _deleteUsecase;

  Future<void> getCustomers() async {
    final result = await _fetchUsecase.call();
    result.fold(
      (error) {
        emit(state.copyWith(error: error));
      },
      (response) {
        emit(state.copyWith(customers: response.dataDetail ?? []));
      },
    );
  }

  Future<void> deleteCustomer(String id) async {
    emit(state.copyWith(isLoading: true));
    final result = await _deleteUsecase.call(id: id);
    emit(state.copyWith(isLoading: false));
    await result.fold(
      (error) {
        emit(state.copyWith(error: error));
      },
      (response) async {
        await getCustomers();
        emit(state.copyWith(message: response));
      },
    );
  }
}
