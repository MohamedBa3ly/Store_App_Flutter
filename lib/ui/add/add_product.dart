import 'package:flutter/material.dart';
import 'package:store_app/services/add_product.dart';
import 'package:store_app/utils/colors.dart';

class AddProductScreen extends StatelessWidget {
  AddProductScreen({super.key});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
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
                  child: Image.asset("assets/images/add_sign.jpg"),
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

              // description Field
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

              // Category Field
              TextField(
                controller: categoryController,
                decoration: InputDecoration(
                  labelText: "Category",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
          
              // Submit Button
              ElevatedButton(
                onPressed: () async{
                  final messenger = ScaffoldMessenger.of(context); // Get reference before async call
                  try{
                    final product = await AddProduct().addProduct(
                        title: titleController.text,
                        price: priceController.text,
                        description: descriptionController.text,
                        image: imageController.text,
                        category: categoryController.text
                    );
                    // Show success message
                    messenger.showSnackBar(
                      SnackBar(content: Text("Product added successfully: ${product.title}")),
                    );
                  }catch(e){
                    // Show error message
                    messenger.showSnackBar(
                      SnackBar(content: Text("Failed to add product: $e")),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
                child: Text("Add Product"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
