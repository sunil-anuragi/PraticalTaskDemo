import 'review_model.dart';

class Product {
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final String discountPercentage;
  final double rating;
  final int stock;
  final String brand;
  final List<String> tags;
  final List<String> images;
  final String thumbnail;
  final List<Reviews> reviews; // Add reviews field

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.tags,
    required this.images,
    required this.thumbnail,
    required this.reviews,
  });

  // Factory method to convert from JSON to Product object
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      price: (json['price'] as num).toDouble(),
      discountPercentage: json['discountPercentage'].toString(),
      rating: (json['rating'] as num).toDouble(),
      stock: json['stock'],
      brand: json['brand'] ?? '',
      tags: List<String>.from(json['tags']),
      images: List<String>.from(json['images']),
      thumbnail: json['thumbnail'],
      reviews: (json['reviews'] as List<dynamic>) // Fix the reviews parsing
          .map((reviewJson) => Reviews.fromJson(reviewJson))
          .toList(),
    );
  }
}


class Category {
  final String name;

  Category({required this.name});
}

class Brand {
  final String name;

  Brand({required this.name});
}
