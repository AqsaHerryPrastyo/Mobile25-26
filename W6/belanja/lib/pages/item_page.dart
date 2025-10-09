import 'package:flutter/material.dart';
import '../models/item.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/item_detail_card.dart';
import '../widgets/app_footer.dart';

class ItemPage extends StatelessWidget {
  final Item? item;
  
  const ItemPage({super.key, this.item});

  @override
  Widget build(BuildContext context) {
    // Get item from constructor parameter or from ModalRoute (fallback)
    final itemArgs = item ?? ModalRoute.of(context)!.settings.arguments as Item;
    
    return Scaffold(
      appBar: CustomAppBar(
        title: itemArgs.name,
        showBackButton: true,
      ),
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProductImage(itemArgs),
                    _buildProductHeader(itemArgs),
                    _buildRatingAndStock(itemArgs),
                    ItemDetailCard(item: itemArgs),
                    _buildActionButtons(context, itemArgs),
                  ],
                ),
              ),
            ),
            AppFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage(Item item) {
    return Container(
      margin: EdgeInsets.all(16),
      height: 280,
      child: Hero(
        tag: 'imageHero-${item.name}',
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
            image: DecorationImage(
              image: NetworkImage(item.foto),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductHeader(Item item) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.name,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Rp ${_formatPrice(item.price)}',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: Colors.green[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingAndStock(Item item) {
    return Container(
      margin: EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange[50]!, Colors.orange[100]!],
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.orange[200]!),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star, color: Colors.orange[600], size: 24),
                  SizedBox(width: 8),
                  Text(
                    '${item.rating}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.orange[700],
                    ),
                  ),
                  Text(
                    '/5.0',
                    style: TextStyle(
                      color: Colors.orange[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: item.stok > 10 
                    ? [Colors.green[50]!, Colors.green[100]!]
                    : [Colors.red[50]!, Colors.red[100]!],
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: item.stok > 10 ? Colors.green[200]! : Colors.red[200]!,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inventory,
                    color: item.stok > 10 ? Colors.green[600] : Colors.red[600],
                    size: 24,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Stock: ${item.stok}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: item.stok > 10 ? Colors.green[700] : Colors.red[700],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, Item item) {
    return Container(
      margin: EdgeInsets.all(16),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: item.stok > 0 ? () {
                _showAddToCartSnackBar(context, item);
              } : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: item.stok > 0 ? Colors.blue[600] : Colors.grey[400],
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    item.stok > 0 ? Icons.add_shopping_cart : Icons.remove_shopping_cart,
                    size: 24,
                  ),
                  SizedBox(width: 12),
                  Text(
                    item.stok > 0 ? 'Add to Cart' : 'Out of Stock',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: OutlinedButton(
              onPressed: () {
                _showBuyNowDialog(context, item);
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.blue[600],
                side: BorderSide(color: Colors.blue[600]!, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.flash_on, size: 24),
                  SizedBox(width: 12),
                  Text(
                    'Buy Now',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddToCartSnackBar(BuildContext context, Item item) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                '${item.name} added to cart!',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.green[600],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: Duration(seconds: 3),
      ),
    );
  }

  void _showBuyNowDialog(BuildContext context, Item item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: [
              Icon(Icons.shopping_cart_checkout, color: Colors.blue[600]),
              SizedBox(width: 12),
              Text('Purchase ${item.name}'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Are you sure you want to buy this item?'),
              SizedBox(height: 12),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Item: ${item.name}', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Price: Rp ${_formatPrice(item.price)}'),
                    Text('Rating: ${item.rating}/5.0'),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showAddToCartSnackBar(context, item);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[600],
                foregroundColor: Colors.white,
              ),
              child: Text('Buy Now'),
            ),
          ],
        );
      },
    );
  }

  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }
}