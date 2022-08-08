import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  
  String categoryName;
  String imageAssets;
  CategoryWidget({required this.categoryName,required this.imageAssets,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey[300],
            child: Image.asset(
              'assets/images/$imageAssets.png',
              height: 35,
              width: 35,
            ),
          ),
           Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(categoryName),
          ),
        ],
      ),
    );
  }
}
