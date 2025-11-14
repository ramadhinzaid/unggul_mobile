import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unggul_mobile/feature/master/stock/domain/usecase/stock_fetch_usecase.dart';
import 'package:unggul_mobile/feature/master/stock/domain/usecase/stock_manage_usecase.dart';
import 'package:unggul_mobile/feature/master/stock/presentation/bloc/stock_state.dart';

class StockCubit extends Cubit<StockState> {
  StockCubit(this._deleteUsecase, this._fetchUsecase) : super(StockState());

  // usecase
  final StockFetchUsecase _fetchUsecase;
  final StockManageUsecase _deleteUsecase;

  Future<void> getStocks() async {
    final result = await _fetchUsecase.call();
    result.fold(
      (error) {
        emit(state.copyWith(error: error));
      },
      (response) {
        emit(state.copyWith(stocks: response.dataDetail ?? []));
      },
    );
  }

  Future<void> deleteStock(String id) async {
    emit(state.copyWith(isLoading: true));
    final result = await _deleteUsecase.call(id: id);
    emit(state.copyWith(isLoading: false));
    await result.fold(
      (error) {
        emit(state.copyWith(error: error));
      },
      (response) async {
        await getStocks();
        emit(state.copyWith(message: response));
      },
    );
  }
}
