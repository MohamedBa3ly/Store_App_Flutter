class FavouriteItemState{}
class FavouriteState extends FavouriteItemState{
  final Map<int, bool> favoriteMap;
  FavouriteState(this.favoriteMap);
}
class NoFavouriteState extends FavouriteItemState{}