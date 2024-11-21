import 'package:flutter/material.dart';
import 'comics_data.dart';
import 'comic_detail_page.dart'; // Импортируем страницу с деталями комикса

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Главная'),
      ),
      body: Container(
        color: Colors.white, // Устанавливаем белый фон
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Два столбца
            childAspectRatio: 0.75, // Соотношение сторон
          ),
          itemCount: comics.length,
          itemBuilder: (context, index) {
            final comic = comics[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ComicDetailPage(comic: comic),
                  ),
                );
              },
              child: Card(
                child: Column(
                  children: [
                    Expanded(
                      child: Image.network(
                        comic.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    ListTile(
                      title: Text(comic.title),
                      subtitle: Text('${comic.author} | ${comic.price} \$'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          icon: Icon(
                            comic.isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: comic.isFavorite ? Colors.red : null,
                          ),
                          onPressed: () {
                            setState(() {
                              comic.isFavorite = !comic.isFavorite;
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            comic.isInCart ? Icons.shopping_cart : Icons.add_shopping_cart,
                            color: comic.isInCart ? Colors.green : null,
                          ),
                          onPressed: () {
                            setState(() {
                              comic.isInCart = !comic.isInCart;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}