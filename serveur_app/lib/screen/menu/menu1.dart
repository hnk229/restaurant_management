import 'package:flutter/material.dart';
import 'package:restaurant_management/config/config.dart';
import 'package:restaurant_management/theme/theme.dart';
import 'package:restaurant_management/widgets/customeContainer.dart';

class Menu1 extends StatefulWidget {
  const Menu1({super.key});

  @override
  State<Menu1> createState() => _Menu1State();
}

class _Menu1State extends State<Menu1> {
  final List<Map<String, dynamic>> items = List.generate(
    20,
    (index) => {
      'name': 'Item ${index + 1}',
      'price': (index + 1) * 5.0,
      'image': 'assets/images/burger.jpg', // Placeholder image URL
    },
  );

  @override
  Widget build(BuildContext context) {
    AppConfig.init(context); // Initialize screen configuration

    return CustomContainer(
      child: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5, // Number of items per row
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.8, // Adjust the aspect ratio of the cards
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Card(
            color: lightColorScheme.onSurface,
            elevation: 5, // Shadow under the card
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        items[index]['image'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        items[index]['name'],
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '\$${items[index]['price'].toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
