import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/model/product_model.dart';
import 'package:store_app/services/get_all_product_service.dart';
import 'package:store_app/utils/colors.dart';
import '../../cubits/categories_chip_change/chip_change_cubit.dart';
import '../../cubits/categories_chip_change/chip_change_state.dart';
import '../../services/get_all_categories_name_service.dart';
import '../../services/get_called_category_service.dart';
import '../widget/product_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Home',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
        backgroundColor: AppColors.orange,
        elevation: 4.0,
        centerTitle: true,
        automaticallyImplyLeading: false, // Remove the back arrow
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft, // Aligns only the text to the start
              child: Text(
                'Categories :',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 8),

            BlocBuilder<ChipChangeCubit, CategoriesChipState>(
                builder: (context, state) {
                  return FutureBuilder<List<dynamic>>(
                      future: AllCategoriesNameServices().getAllCategories(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(child: Text("Error: ${snapshot.error}"));
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(child: Text(""));
                        } else {
                          List<String> categories = ['All', ...snapshot.data!.map((e) => e.toString())];

                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: categories.map((category) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                  child: ChoiceChip(
                                    backgroundColor: Colors.white,
                                    label: Text(category),
                                    selected: state.selectedCategory == category,
                                    onSelected: (isSelected) {
                                      if(isSelected){
                                        context.read<ChipChangeCubit>().selectCategory(category);
                                      }
                                    },
                                    selectedColor: AppColors.orange,
                                    labelStyle: TextStyle(
                                      color: state.selectedCategory == category ? Colors.white : Colors.black,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          );
                        }
                      },
                    );
                }
            ),

            SizedBox(height: 10),

            Expanded(
              child: BlocBuilder<ChipChangeCubit, CategoriesChipState>(
                builder: (context,state){
                  return FutureBuilder<List<ProductModel>>(
                    future: state.selectedCategory == 'All'
                        ? AllProductServices().getAllProducts()
                        : CalledCategoryServices().getCalledCategoryProducts(state.selectedCategory),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator()); // While waiting for data
                      } else if (snapshot.hasError) {
                        return Center(child: Text("Error: ${snapshot.error}")); // Show error message
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text("No products available")); // Handle empty response
                      } else {
                        List<ProductModel> products = snapshot.data!;
                        return GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            childAspectRatio: 0.9,
                          ),
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            return ProductCard(
                              product: products[index],
                              onClick: () {
                                print("object");
                              },
                            );
                          },
                        );
                      }
                    },
                  );
                },
              )

            ),
          ],
        ),
      ),
    );
  }
}


