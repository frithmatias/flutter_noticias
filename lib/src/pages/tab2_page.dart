import 'package:flutter/material.dart';
import 'package:noticias/src/models/category_model.dart';
import 'package:noticias/src/services/news_service.dart';
import 'package:noticias/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final NewsService newsService = Provider.of<NewsService>(context);
    print(
        'Noticias de la categoría: ${newsService.categoryArticles[newsService.selectedCategory]}');
    print('Categoría seleccionada: ${newsService.selectedCategory}');

    return SafeArea(
      child: Scaffold(
        body: Column(children: <Widget>[
          Expanded(
              child: ListaNoticias(
                  newsService.categoryArticles[newsService.selectedCategory]!)),
          _ListaCategorias(),
        ]),
      ),
    );
  }
}

class _ListaCategorias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Category> categorias =
        Provider.of<NewsService>(context).categories;

    return Container(
      width: double.infinity,
      height: 80,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categorias.length,
        itemBuilder: (BuildContext context, int index) {
          final capitalizedName = categorias[index].label;

          return Padding(
              padding: EdgeInsets.all(8),
              child: Column(children: <Widget>[
                _CategoryButton(categorias[index], context),
                SizedBox(height: 5),
                Text(
                    '${capitalizedName[0].toUpperCase()}${capitalizedName.substring(1)}')
              ]));
        },
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final BuildContext context;
  final Category categoria;
  _CategoryButton(this.categoria, this.context);

  @override
  Widget build(BuildContext context) {
    final NewsService newsService = Provider.of<NewsService>(context);

    return GestureDetector(
      onTap: () {
        newsService.selectedCategory = categoria.name;
      },
      child: Container(
          width: 40,
          height: 40,
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: (newsService.selectedCategory == categoria.name)
                ? Colors.white
                : Colors.white38,
          ),
          child: Icon(categoria.icon, color: Colors.black54)),
    );
  }
}
