
abstract class CategoriesChipState {
  final String selectedCategory;
  CategoriesChipState(this.selectedCategory);
}

class AllCategoriesState extends CategoriesChipState {
  AllCategoriesState() : super('All');
}

class ElectronicsState extends CategoriesChipState {
  ElectronicsState() : super('electronics');
}

class JeweleryState extends CategoriesChipState {
  JeweleryState() : super('jewelery');
}

class MenClothingState extends CategoriesChipState {
  MenClothingState() : super("men's clothing");
}

class WomenClothingState extends CategoriesChipState {
  WomenClothingState() : super("women's clothing");
}