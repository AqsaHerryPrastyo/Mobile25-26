import 'package:flutter/material.dart';
import '../models/item.dart';

class ItemDetailCard extends StatelessWidget {
  final Item item;

  const ItemDetailCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Colors.grey.shade50,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Product Details'),
          SizedBox(height: 16),
          _buildDetailRow('Product Name', item.name, Icons.shopping_bag),
          _buildDetailRow('Price', 'Rp ${_formatPrice(item.price)}', Icons.attach_money),
          _buildDetailRow('Rating', '${item.rating}/5.0 ⭐', Icons.star_rate),
          _buildDetailRow('Stock Available', '${item.stok} units', Icons.inventory),
          SizedBox(height: 16),
          _buildAvailabilityStatus(),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 24,
          decoration: BoxDecoration(
            color: Colors.blue[600],
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: Colors.blue[600],
              size: 20,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.grey[800],
                fontSize: 16,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvailabilityStatus() {
    bool isAvailable = item.stok > 0;
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isAvailable ? Colors.green[50] : Colors.red[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isAvailable ? Colors.green[200]! : Colors.red[200]!,
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Icon(
            isAvailable ? Icons.check_circle : Icons.cancel,
            color: isAvailable ? Colors.green[600] : Colors.red[600],
            size: 24,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isAvailable ? 'Available' : 'Out of Stock',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isAvailable ? Colors.green[700] : Colors.red[700],
                    fontSize: 16,
                  ),
                ),
                Text(
                  isAvailable 
                    ? 'This item is ready to ship'
                    : 'This item is currently unavailable',
                  style: TextStyle(
                    color: isAvailable ? Colors.green[600] : Colors.red[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
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