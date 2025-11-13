import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unggul_mobile/feature/master/stock/data/model/stock_model.dart';
import 'package:unggul_mobile/feature/master/stock/domain/usecase/stock_manage_usecase.dart';
import 'package:unggul_mobile/feature/master/stock/presentation/bloc/stock_state.dart';

class StockFormCubit extends Cubit<StockFormState> {
  StockFormCubit(this._manageUsecase) : super(StockFormState());

  // usecase
  final StockManageUsecase _manageUsecase;

  Future<void> manageStock({StockModelData? request}) async {
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
