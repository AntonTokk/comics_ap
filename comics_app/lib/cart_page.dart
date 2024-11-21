import 'package:flutter/material.dart';
import 'comics_data.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final cartComics = comics.where((comic) => comic.isInCart).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Корзина'),
      ),
      body: Container(
        color: Colors.white, // Устанавливаем белый фон
        child: ListView.builder(
          itemCount: cartComics.length,
          itemBuilder: (context, index) {
            final comic = cartComics[index];
            return ListTile(
              leading: Image.network(comic.imageUrl),
              title: Text(comic.title),
              subtitle: Text('${comic.author} | ${comic.price} \$'),
              trailing: IconButton(
                icon: const Icon(Icons.remove_shopping_cart),
                onPressed: () {
                  setState(() {
                    comic.isInCart = false;
                  });
                },
              ),
            );
          },
        ),
      ),
    );
  }
}