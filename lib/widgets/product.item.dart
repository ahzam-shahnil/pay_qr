// import 'package:flutter/material.dart';

// class ProductItem extends StatelessWidget {
//   final int id;
//   final String title;
//   final String imaheUrl;
//   const ProductItem(this.id, this.title, this.imaheUrl, {Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(10),
//       child: GridTile(
//         child: Image.network(
//           imaheUrl,
//           fit: BoxFit.cover,
//         ),
//         footer: GridTileBar(
//           backgroundColor: Colors.black87,
//           leading: IconButton(
//             icon: Icon(Icons.favorite),
//             onPressed: () {},
//             color: Theme.of(context).colorScheme.secondary,
//           ),
//           title: Text(
//             title,
//             textAlign: TextAlign.center,
//           ),
//           trailing: IconButton(
//             icon: Icon(Icons.shopping_cart),
//             onPressed: () {},
//             color: Theme.of(context).colorScheme.secondary,
//           ),
//         ),
//       ),
//     );
//   }
// }
