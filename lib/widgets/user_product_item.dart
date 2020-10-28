

import 'package:flutter/material.dart';
import 'package:shop_app/screens/edit_product_screen.dart';

import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
class UserProductItem extends StatelessWidget {
  final String id;

  final String title;
  final String imageUrl;


  UserProductItem({
    this.id,
    this.title,
    this.imageUrl
  });
  @override
  Widget build(BuildContext context) {
    return ListTile(leading: CircleAvatar(
      backgroundImage: NetworkImage(imageUrl)
    ),
    trailing: Container(
      width: 100,
      child: Row(children: [
        IconButton(icon: Icon(Icons.edit,
        color: Theme.of(context).primaryColor,
        ), onPressed: () {
          Navigator.of(context).pushNamed(EditProductScreen.routeName,
          arguments:id );
        }),
        IconButton(icon: Icon(Icons.delete,
        color: Theme.of(context).errorColor,),
         onPressed: () {
           Provider.of<Products>(context,listen: false).deleteProduct(id);

         })
      ],),
    ),
    title: Text(title),);
  }
}