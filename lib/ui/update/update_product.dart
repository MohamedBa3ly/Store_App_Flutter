import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:store_app/model/product_model.dart';
import 'package:store_app/services/update_product.dart';
import 'package:store_app/utils/colors.dart';

import '../../cubits/update_product_screen_loading/uodate_product_loading_state.dart';
import '../../cubits/update_product_screen_loading/update_product_loading_cubit.dart';

class UpdateProductScreen extends StatelessWidget {
  final ProductModel? product;

  UpdateProductScreen({super.key, this.product});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    // Initialize text controllers with existing product values
    titleController.text = product!.title;
    priceController.text = product!.price.toString();
    descriptionController.text = product!.description;
    imageController.text = product!.image ;

    return BlocProvider(
      create: (context) => UpdateProductLoadingCubit(),
      child: BlocBuilder<UpdateProductLoadingCubit, UpdateScreenLoadingState>(
        builder: (context, state) {
          bool isLoading = state is ShowLoading;
          return ModalProgressHUD(
            inAsyncCall: isLoading,
            child: Scaffold(
              appBar: AppBar(
                title: Text("Update Product"),
                backgroundColor: AppColors.orange,
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Image Placeholder
                      Center(
                        child: Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.asset("assets/images/update_sign.jpg"),
                        ),
                      ),
                      SizedBox(height: 20),

                      // Product Name Field
                      TextField(
                        controller: titleController,
                        decoration: InputDecoration(
                          labelText: "Product Name",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),

                      // Price Field
                      TextField(
                        controller: priceController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Price",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),

                      // Description Field
                      TextField(
                        controller: descriptionController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: "Description",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),

                      // Image URL Field
                      TextField(
                        controller: imageController,
                        decoration: InputDecoration(
                          labelText: "Image URL",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 20),

                      // Submit Button
                      ElevatedButton(
                        onPressed: () async {

                          final cubit = context.read<UpdateProductLoadingCubit>();
                          cubit.showLoadingState();

                          final messenger = ScaffoldMessenger.of(context);

                          try {
                            final updatedProduct = await UpdateProduct()
                                .updateProduct(
                              id: product!.id,
                              title: titleController.text.isEmpty
                                  ? product!.title
                                  : titleController.text,
                              price: priceController.text.isEmpty
                                  ? product!.price.toString()
                                  : priceController.text.toString(),
                              description: descriptionController.text.isEmpty
                                  ? product!.description
                                  : descriptionController.text,
                              image: imageController.text.isEmpty
                                  ? product!.image
                                  : imageController.text,
                              category: product!.category,
                            );

                            // Show success message
                            messenger.showSnackBar(
                              SnackBar(
                                content: Text(
                                    "Product updated successfully: ${updatedProduct
                                        .title}"),
                              ),
                            );
                          } catch (e) {
                            // Show error message
                            messenger.showSnackBar(
                              SnackBar(
                                content: Text("Failed to update product: $e"),
                              ),
                            );
                          }

                          cubit.hideLoadingState();
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: Text("Update Product"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
