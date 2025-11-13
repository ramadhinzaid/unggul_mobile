import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unggul_mobile/feature/transaction/sale/data/model/sale_request.dart';
import 'package:unggul_mobile/feature/transaction/sale/domain/usecase/sale_manage_usecase.dart';
import 'package:unggul_mobile/feature/transaction/sale/presentation/bloc/sale_state.dart';

class SaleFormCubit extends Cubit<SaleFormState> {
  SaleFormCubit(this._manageUsecase) : super(SaleFormState());

  // usecase
  final SaleManageUsecase _manageUsecase;

  Future<void> manageSales({String? id, SaleRequest? request}) async {
    emit(state.copyWith(isLoading: true));
    final result = await _manageUsecase.call(id: id, request: request);
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
