import 'package:flutter/material.dart';

class CustomSlider extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          _item( 'https://www.traveldailymedia.com/assets/2020/01/thailandblogger-1024x683.jpg' ),
          _item( 'https://london.ac.uk/sites/default/files/styles/promo_large/public/2018-10/london-aerial-cityscape-river-thames_1.jpg?itok=BMaDUhjp' ),
          _item( 'https://www.viagenscinematograficas.com.br/wp-content/uploads/2018/09/Jericoacoara-Dicas-O-que-Fazer-em-Jeri-Capa.jpg' )
        ],
      ),
    );
  }

  Widget _item(image) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      width: 320,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.network(image, fit: BoxFit.cover,),
      ),
    );
  }

}