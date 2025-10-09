import 'package:flutter/material.dart';
import '../models/item.dart';

class ProductCard extends StatelessWidget {
  final Item item;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Card(
        elevation: 6,
        shadowColor: Colors.black26,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                Colors.grey.shade50,
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProductImage(),
              _buildProductInfo(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    return Expanded(
      flex: 3,
      child: Container(
        margin: EdgeInsets.all(8),
        child: Hero(
          tag: 'imageHero-${item.name}',
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
              image: DecorationImage(
                image: NetworkImage(item.foto),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductInfo() {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.grey[800],
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 6),
            Text(
              'Rp ${_formatPrice(item.price)}',
              style: TextStyle(
                color: Colors.green[700],
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildRatingWidget(),
                _buildStockWidget(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.orange[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange[200]!),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star, color: Colors.orange[600], size: 12),
          SizedBox(width: 2),
          Text(
            item.rating.toString(),
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Colors.orange[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStockWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: item.stok > 10 ? Colors.green[50] : Colors.red[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: item.stok > 10 ? Colors.green[200]! : Colors.red[200]!,
        ),
      ),
      child: Text(
        'Stock: ${item.stok}',
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: item.stok > 10 ? Colors.green[700] : Colors.red[700],
        ),
      ),
    );
  }

  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }
}