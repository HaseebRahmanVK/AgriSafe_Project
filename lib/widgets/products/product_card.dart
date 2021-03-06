// import 'package:flutter/material.dart';

// import 'package:scoped_model/scoped_model.dart';

// import './price_tag.dart';
// import './address_tag.dart';
// import '../ui_elements/title_default.dart';
// import '../../models/product.dart';
// import '../../scoped-models/main.dart';

// class ProductCard extends StatelessWidget {
//   final Product product;

//   ProductCard(this.product);

//   Widget _buildTitlePriceRow() {
//     return Container(
//       padding: EdgeInsets.only(top: 10.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           TitleDefault(product.title),
//           SizedBox(
//             width: 8.0,
//           ),
//           PriceTag(product.price.toString())
//         ],
//       ),
//     );
//   }

//   Widget _buildActionButtons(BuildContext context) {
//     return ScopedModelDescendant<MainModel>(
//       builder: (BuildContext context, Widget child, MainModel model) {
//         return ButtonBar(
//             alignment: MainAxisAlignment.center,
//             children: <Widget>[
//               IconButton(
//                   icon: Icon(Icons.info),
//                   color: Theme.of(context).accentColor,
//                   onPressed: () {
//                     model.selectProduct(product.id);
//                     Navigator.pushNamed<bool>(context, '/product/' + product.id)
//                         .then((_) => model.selectProduct(null));
//                   }),
//               IconButton(
//                 icon: Icon(product.isFavorite
//                     ? Icons.favorite
//                     : Icons.favorite_border),
//                 color: Colors.red,
//                 onPressed: () {
//                   model.selectProduct(product.id);
//                   model.toggleProductFavoriteStatus();
//                 },
//               ),
//             ]);
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Column(
//         children: <Widget>[
//           FadeInImage(
//             image: NetworkImage(product.image),
//             fit: BoxFit.cover,
//             height: 300.0,
//             placeholder: AssetImage('assets/food.jpg'),
//           ),
//           _buildTitlePriceRow(),
//           AddressTag('Union Square, San Francisco'),
//           // Text(product.userEmail),
//           _buildActionButtons(context)
//         ],
//       ),
//     );
//   }
// }
