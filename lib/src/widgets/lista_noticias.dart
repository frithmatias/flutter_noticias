import 'package:flutter/material.dart';
import 'package:noticias/src/models/news_models.dart';
import 'package:noticias/src/theme/tema.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ListaNoticias extends StatelessWidget {
  final List<Article> noticias;

  const ListaNoticias(
      this.noticias
  ); 
  
  @override
  Widget build(BuildContext context) {
    
    return ListView.builder(
      itemCount: this.noticias.length,
      itemBuilder: (BuildContext context, int index) {
        return _Noticia(this.noticias[index], index);
      },
    );
  }
}

class _Noticia extends StatelessWidget {

  final Article noticia;
  final int index;
  const _Noticia(this.noticia, this.index);

  @override
  Widget build(BuildContext context) {
  print(this.noticia.title);
  

    return  Column(  
          children: [
            _Medio(this.noticia, index), 
            _Titulo(this.noticia), 
            _Imagen(this.noticia), 
            _Body(this.noticia),
            _Botones(this.noticia),
            SizedBox(height: 10),
            Divider()
          ]
        );
  }
}

class _Medio extends StatelessWidget {

  final Article noticia;
  final int index;
  const _Medio(this.noticia, this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10), 
      margin: EdgeInsets.only( bottom: 10, top: 5 ),
      child: Row(  
        children: <Widget>[  
          Text('${ index + 1 } - ', style: TextStyle(color: miTema.accentColor)), 
          Text('${ noticia.source?.name ?? 'no-surce' }', style: TextStyle( color: Colors.amber)), 

        ]
      ),
    );
  }
}

class _Titulo extends StatelessWidget {

  final Article noticia;
  const _Titulo(this.noticia);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10), 
      margin: EdgeInsets.only( bottom: 10 ),
      child: Text( this.noticia.title ?? 'no-title' , style: TextStyle( fontSize: 20, fontWeight: FontWeight.w400, letterSpacing: 0.8)), 
    );
  }
}

class _Imagen extends StatelessWidget {

  final Article noticia;
  const _Imagen(this.noticia);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
          child: Container(
            child: this.noticia.urlToImage != null 
            ? FadeInImage(
              image: NetworkImage(this.noticia.urlToImage.toString()), 
              placeholder: AssetImage('assets/img/giphy.gif'),
            )
            : Image( image: AssetImage('assets/img/no-image.png'))
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {

  final Article noticia;
  const _Body(this.noticia);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 0),
      child: Text(this.noticia.description ?? 'no-description', style: TextStyle( fontSize: 16, height: 1.5))
    );
  }
}

class _Botones extends StatelessWidget {
  final Article noticia;
  const _Botones(this.noticia);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(  
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [  
          RawMaterialButton(
            child: Icon( Icons.web),
            onPressed: () async => await canLaunch(noticia.url) ? await launch(noticia.url) : throw 'No se pudo abrir ${noticia.url}', 
            fillColor: Colors.green,
            shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20))
          ),
          RawMaterialButton(
            child: Icon( Icons.star_border),
            onPressed: (){}, 
            fillColor: miTema.accentColor,
            shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20))
          ),
          RawMaterialButton(
            child: Icon( Icons.share),
            onPressed: (){
              Share.share('check out my website https://example.com');
            }, 
            fillColor: Colors.blue,
            shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20))
          )
        ]
      )
    );
  }
}
