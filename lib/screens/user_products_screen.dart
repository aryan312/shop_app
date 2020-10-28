import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/user_product_item.dart';
import '../providers/products_provider.dart';

class UserProductsScreen extends StatelessWidget {
  static String routeName = '/UserProducts';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          )
        ],
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                    color: Colors.black,
                    onRefresh: () => _refreshProducts(context),
                    child: Consumer<Products>(
                      builder: (ctx, productsData, _) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                            itemCount: productsData.items.length,
                            itemBuilder: (_, i) => Column(
                                  children: [
                                    UserProductItem(
                                      title: productsData.items[i].title,
                                      imageUrl: productsData.items[i].imageUrl,
                                      id: productsData.items[i].id,
                                    ),
                                    Divider(
                                      thickness: 2,
                                    ),
                                  ],
                                )),
                      ),
                    ),
                  ),
      ),
    );
  }
}
