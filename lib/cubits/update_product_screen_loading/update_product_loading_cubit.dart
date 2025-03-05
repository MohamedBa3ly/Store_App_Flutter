import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/cubits/update_product_screen_loading/uodate_product_loading_state.dart';

class UpdateProductLoadingCubit extends Cubit<UpdateScreenLoadingState>{
  UpdateProductLoadingCubit() : super(HideLoading());


  void showLoadingState() => emit(ShowLoading());
  void hideLoadingState() => emit(HideLoading());

}