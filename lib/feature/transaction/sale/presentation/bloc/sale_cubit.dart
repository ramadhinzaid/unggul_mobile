import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unggul_mobile/feature/transaction/sale/domain/usecase/sale_fetch_usecase.dart';
import 'package:unggul_mobile/feature/transaction/sale/domain/usecase/sale_manage_usecase.dart';
import 'package:unggul_mobile/feature/transaction/sale/presentation/bloc/sale_state.dart';

class SaleCubit extends Cubit<SaleState> {
  SaleCubit(this._deleteUsecase, this._fetchUsecase) : super(SaleState());

  // usecase
  final SaleFetchUsecase _fetchUsecase;
  final SaleManageUsecase _deleteUsecase;

  Future<void> getSales() async {
    final result = await _fetchUsecase.call();
    result.fold(
      (error) {
        emit(state.copyWith(error: error));
      },
      (response) {
        emit(state.copyWith(sales: response.dataDetail ?? []));
      },
    );
  }

  Future<void> deleteSale(String id) async {
    emit(state.copyWith(isLoading: true));
    final result = await _deleteUsecase.call(id: id);
    emit(state.copyWith(isLoading: false));
    await result.fold(
      (error) {
        emit(state.copyWith(error: error));
      },
      (response) async {
        await getSales();
        emit(state.copyWith(message: response));
      },
    );
  }
}
