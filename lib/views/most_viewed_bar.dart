import 'package:flutter/material.dart';

class MostViewedBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _mostViewed('https://exame.com/wp-content/uploads/2017/03/1edb_singapura.jpg?quality=70&strip=info&resize=680,453'),
          _mostViewed('https://conteudo.imguol.com.br/c/noticias/d8/2019/02/09/conhecida-como-a-perola-da-asia-cingapura-e-um-dos-maiores-centros-financeiros-do-mundo-1549729914056_v2_900x506.jpg'),
          _mostViewed('https://lh3.googleusercontent.com/proxy/K6IOj-p7qSF_9aaK7w3F7DOv0KIi0Q7vBVWC1bmjyUxlNPHz_024bXerDcgcR_FflEDBblVaEt_TO0u-98ksD5ILUMgkmFhwl5CRv9CuzYUAsPH4PZ578UUPtIM2qFFua_wMep0'),
        ],
      ),
    );
  }

  Widget _mostViewed(img) {
    return Container(
      width: 116,
      height: 200,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(7.5),
        child: Image.network(img, fit: BoxFit.cover, ),
      )
    );
  }

}