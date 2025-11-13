import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unggul_mobile/feature/master/customer/data/model/customer_model.dart';
import 'package:unggul_mobile/feature/master/customer/domain/usecase/customer_manage_usecase.dart';
import 'package:unggul_mobile/feature/master/customer/presentation/bloc/customer_state.dart';

class CustomerFormCubit extends Cubit<CustomerFormState> {
  CustomerFormCubit(this._manageUsecase) : super(CustomerFormState());

  // usecase
  final CustomerManageUsecase _manageUsecase;

  Future<void> manageCustomer({CustomerModelData? request}) async {
    emit(state.copyWith(isLoading: true));
    final result = await _manageUsecase.call(request: request);
    emit(state.copyWith(isLoading: false));
    result.fold(
      (error) {
        emit(state.copyWith(error: error));
      },
      (response) {
        emit(state.copyWith(message: response));
      },
    );
  }
}
