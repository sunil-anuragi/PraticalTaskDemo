import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/product_model.dart';
import '../../../provider/product_provider.dart';

class CategoriesRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<ProductProvider>(context).categories;

    return Container(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return CategoryChip(category: category);
        },
      ),
    );
  }
}

class CategoryChip extends StatelessWidget {
  final Category category;

  CategoryChip({required this.category});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);
    final isSelected = provider.selectedCategories.contains(category);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: FilterChip(
        label: Text(category.name),
        selected: isSelected,
        onSelected: (selected) {
          provider.toggleCategorySelection(category);
        },
      ),
    );
  }
}
