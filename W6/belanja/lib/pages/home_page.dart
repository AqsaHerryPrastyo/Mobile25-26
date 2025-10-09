import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/item.dart';
import '../widgets/product_card.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/app_footer.dart';

class HomePage extends StatelessWidget {
  final List<Item> items = [
    Item(
      name: 'Sugar', 
      price: 5000, 
      foto: 'https://via.placeholder.com/150/FFB6C1/000000?text=Sugar',
      stok: 25,
      rating: 4.5
    ),
    Item(
      name: 'Salt', 
      price: 2000, 
      foto: 'https://via.placeholder.com/150/87CEEB/000000?text=Salt',
      stok: 30,
      rating: 4.2
    ),
    Item(
      name: 'Rice', 
      price: 15000, 
      foto: 'https://via.placeholder.com/150/DDA0DD/000000?text=Rice',
      stok: 50,
      rating: 4.8
    ),
    Item(
      name: 'Oil', 
      price: 25000, 
      foto: 'https://via.placeholder.com/150/F0E68C/000000?text=Oil',
      stok: 15,
      rating: 4.3
    ),
    Item(
      name: 'Flour', 
      price: 8000, 
      foto: 'https://via.placeholder.com/150/98FB98/000000?text=Flour',
      stok: 40,
      rating: 4.6
    ),
    Item(
      name: 'Milk', 
      price: 12000, 
      foto: 'https://via.placeholder.com/150/F5DEB3/000000?text=Milk',
      stok: 20,
      rating: 4.7
    ),
  ];
  
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Belanja App'),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue[50]!,
              Colors.white,
            ],
          ),
        ),
        child: Column(
          children: [
            _buildWelcomeSection(),
            Expanded(
              child: _buildProductGrid(),
            ),
            AppFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue[600]!,
            Colors.blue[400]!,
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to Belanja!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Find the best products at great prices',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.shopping_bag,
            color: Colors.white,
            size: 40,
          ),
        ],
      ),
    );
  }

  Widget _buildProductGrid() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: GridView.builder(
        padding: EdgeInsets.all(8),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.7,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return ProductCard(
            item: item,
            onTap: () {
              context.go('/item', extra: item);
            },
          );
        },
      ),
    );
  }
}
