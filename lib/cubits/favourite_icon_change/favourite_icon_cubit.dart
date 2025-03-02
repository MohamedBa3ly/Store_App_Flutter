import 'package:flutter_bloc/flutter_bloc.dart';
import 'favourite_icon_state.dart';

class FavouriteIconCubit extends Cubit<FavouriteItemState> {
  FavouriteIconCubit() : super(NoFavouriteState());

  final Map<int, bool> _favoriteMap = {}; // Local map to store favorites

  void toggleFavourite(int productId) {
    _favoriteMap[productId] = !(_favoriteMap[productId] ?? false); // Toggle favorite status;
    if (_favoriteMap.containsValue(true)) {
      emit(FavouriteState(Map<int, bool>.from(_favoriteMap))); // Emit updated favorite state
    } else {
      emit(NoFavouriteState()); // Emit NoFavouriteState if no items are favorite
    }
  }

  bool isFavourite(int productId) {
    return _favoriteMap[productId] ?? false;
  }
}