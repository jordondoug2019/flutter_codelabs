// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shrine/supplemental/asymmetric_view.dart';

import 'model/product.dart';
import 'model/products_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  // Make a collection of cards (102)
  // fucntins that start w/ _ are private API
  //added product information to card collection
  // List<Card> _buildGridCards(BuildContext context) {
  //   List<Product> products = ProductsRepository.loadProducts(Category.all);

  //   if (products.isEmpty) {
  //     return const <Card>[];
  //   }
  //   final ThemeData theme = Theme.of(context);
  //   final NumberFormat formatter = NumberFormat.simpleCurrency(
  //       locale: Localizations.localeOf(context).toString()
  //       );

  //   return products.map((product) {
  //     return Card(
  //       clipBehavior: Clip.antiAlias,
  //       //Adjust card heights (103)
  //       elevation: 0.0,
  //       child: Column(
  //         //center items on the card (103)
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: <Widget>[
  //           AspectRatio(
  //             aspectRatio: 18 / 11,
  //             child: Image.asset(
  //               product.assetName,
  //               package: product.assetPackage,
  //               //Adust the box size (102)
  //               fit: BoxFit.fitWidth,
  //             ),
  //           ),
  //           Expanded(
  //             child: Padding(
  //               padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
  //               child: Column(
  //                 //Align Labels to the bottom and center (103)
  //                 mainAxisAlignment: MainAxisAlignment.end,
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 //Change innermost Column (103)
  //                 children: <Widget>[
  //                   //Handle Overflowing labels (103)
  //                   Text(
  //                     product.name,
  //                     style: theme.textTheme.labelLarge,
  //                     softWrap: false,
  //                     overflow:TextOverflow.ellipsis,
  //                     maxLines: 1,
  //                   ),
  //                   const SizedBox(height: 4.0),
  //                   Text(
  //                     formatter.format(product.price),
  //                     style: theme.textTheme.bodySmall,
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     );
  //   }).toList();
  // }

    // Add a variable for Category (104)
  @override
    Widget build(BuildContext context) {
      // Return an AsymmetricView (104)
      // TODO: Return an AsymmetricView (104)
return AsymmetricView(products: ProductsRepository.loadProducts(Category.all));
      // Pass Category variable to AsymmetricView (104)
        }
  }
      // return Scaffold(
      //   // Add app bar (102)
      //   appBar: AppBar(
      //       leading: IconButton(
      //         icon: const Icon(
      //           Icons.menu,
      //           semanticLabel: 'menu',
      //         ),
      //         onPressed: () {
      //           print('Menu button');
      //         },
      //       ),
      //       // Add buttons and title (102)
      //       title: const Text('SHRINE'),
      //       actions: <Widget>[
      //         //added search icon
      //         IconButton(
      //           icon: const Icon(
      //             Icons.search,
      //             semanticLabel: 'search',
      //           ),
      //           onPressed: () {
      //             print('Search button');
      //           },
      //         ),
      //         //added filter icon
      //         IconButton(
      //           icon: const Icon(
      //             Icons.tune,
      //             semanticLabel: 'filter',
      //           ),
      //           onPressed: () {
      //             print('Filter Button');
      //           },
      //         )
      //       ]),
      //   // Add a grid view (102)
      //   //GridView uses count constructor since the number of items it displays is countable and not infiniste
      //   //GridView makes tiles that are all the same size
      //   body: AsymmetricView(products: ProductsRepository.loadProducts(Category.all))
        
      //   // GridView.count(
      //   //     crossAxisCount: 2,
      //   //     //Cross Axis Count specifies how many items across. @ columsn for this example.
      //   //     padding: const EdgeInsets.all(16.0),
      //   //     //Padding provides space on all 4 sides of the GridView
      //   //     childAspectRatio: 8.0 / 9.0,
      //   //     //childAspectRatio identifed the size of the items based on an aspect ration(width over height)
      //   //     children: _buildGridCards(context)),
      //   // resizeToAvoidBottomInset: false,
      //   // Set resizeToAvoidBottomInset (101)
      // );
  



    //   List<Card> cards = List.generate(count, (int index) {
    //     return Card(
    //         clipBehavior: Clip.antiAlias,
    //         child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: <Widget>[
    //               AspectRatio(
    //                 aspectRatio: 18.0 / 11.0,
    //                 child: Image.asset('assets/diamond.png'),
    //               ),
    //               const Padding(
    //                   padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
    //                   child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: <Widget>[
    //                         Text('Title'),
    //                         SizedBox(height: 8.0),
    //                         Text('Secondary Text'),
    //                       ]))
    //             ]));
    //   });
    //   return cards;
    // }

    // Add a variable for Category (104)
    // @override
    // Widget build(BuildContext context) {
    //   // Return an AsymmetricView (104)
    //   // Pass Category variable to AsymmetricView (104)
    //   return Scaffold(
    //     // Add app bar (102)
    //     appBar: AppBar(
    //         leading: IconButton(
    //           icon: const Icon(
    //             Icons.menu,
    //             semanticLabel: 'menu',
    //           ),
    //           onPressed: () {
    //             print('Menu button');
    //           },
    //         ),
    //         // Add buttons and title (102)
    //         title: const Text('SHRINE'),
    //         actions: <Widget>[
    //           //added search icon
    //           IconButton(
    //             icon: const Icon(
    //               Icons.search,
    //               semanticLabel: 'search',
    //             ),
    //             onPressed: () {
    //               print('Search button');
    //             },
    //           ),
    //           //added filter icon
    //           IconButton(
    //             icon: const Icon(
    //               Icons.tune,
    //               semanticLabel: 'filter',
    //             ),
    //             onPressed: () {
    //               print('Filter Button');
    //             },
    //           )
    //         ]),
    //     // Add a grid view (102)
    //     //GridView uses count constructor since the number of items it displays is countable and not infiniste
    //     //GridView makes tiles that are all the same size
    //     body: GridView.count(
    //         crossAxisCount: 2,
    //         //Cross Axis Count specifies how many items across. @ columsn for this example.
    //         padding: const EdgeInsets.all(16.0),
    //         //Padding provides space on all 4 sides of the GridView
    //         childAspectRatio: 8.0 / 9.0,
    //         //childAspectRatio identifed the size of the items based on an aspect ration(width over height)
    //         children: _buildGridCards(context)),
    //     resizeToAvoidBottomInset: false,
    //     // Set resizeToAvoidBottomInset (101)
    //   );
    // }
  
