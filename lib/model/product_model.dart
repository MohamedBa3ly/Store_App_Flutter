class ProductModel{
  final dynamic id;
  final String title;
  final dynamic price;
  final String description;
  final String category;
  final String image;
  final RatingModel? rating;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating
  });

  factory ProductModel.fromjson(jsonData){
    return ProductModel(
        id: jsonData['id'],
        title: jsonData['title'],
        price: jsonData['price'],
        description: jsonData['description'],
        category: jsonData['category'],
        image: jsonData['image'],
        rating:jsonData['rating'] != null
            ? RatingModel.fromjson(jsonData['rating'])
            : null  // Handle null rating
    );
  }
}

class RatingModel {
  final dynamic rate;
  final dynamic count;

  RatingModel({
    required this.rate,
    required this.count
  });

  factory RatingModel.fromjson(jsonData){
    return RatingModel(
        rate:jsonData['rate'],
        count:jsonData['count']
    );
  }
}