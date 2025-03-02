import 'package:flutter_bloc/flutter_bloc.dart';
import 'chip_change_state.dart';

class ChipChangeCubit extends Cubit<CategoriesChipState> {
  ChipChangeCubit() : super(AllCategoriesState());

  void selectCategory(String category) {
    switch (category) {
      case 'electronics':
        emit(ElectronicsState());
        break;
      case 'jewelery':
        emit(JeweleryState());
        break;
      case "men's clothing":
        emit(MenClothingState());
        break;
      case "women's clothing":
        emit(WomenClothingState());
        break;
      default:
        emit(AllCategoriesState());
    }
  }

}