import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:app_deteccion_personas/models/ap_model.dart';
import 'package:app_deteccion_personas/widgets/varios_widget.dart';
import 'package:app_deteccion_personas/widgets/ap_on_map.dart';
import 'package:app_deteccion_personas/models/image_model.dart';
import 'package:app_deteccion_personas/providers/ap_provider.dart';
import 'package:app_deteccion_personas/preferencias_usuario/preferencias_usuario.dart';

class CardSwiperWidget extends StatefulWidget {
  final List<ImageModel> mapas;
  final double bodyHeight, bodyWidth;

  CardSwiperWidget(
      {@required this.mapas,
      @required this.bodyHeight,
      @required this.bodyWidth});

  @override
  _CardSwiperWidgetState createState() => _CardSwiperWidgetState();
}

class _CardSwiperWidgetState extends State<CardSwiperWidget> {
  final ApProvider apProvider = ApProvider();
  final _prefs = PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: apProvider.cargarApsByNetwork(_prefs.tokenNetwork),
      builder: (context, AsyncSnapshot<List<ApModel>> snapshot) {
        if (snapshot.hasData) {
          List<Widget> lista = [];
          for (var i = 0; i < snapshot.data.length; i++) {
            final x =
                (double.parse(snapshot.data[i].dx) * widget.bodyWidth / 100) -
                    widget.bodyWidth / 4;
            final y =
                (double.parse(snapshot.data[i].dy) * widget.bodyHeight / 100) -
                    widget.bodyWidth / 4;
            var colora = Color.fromRGBO(87, 198, 62, 0.5);
            if( double.parse(snapshot.data[i].devices) >= double.parse(snapshot.data[i].limit)){
              colora = Color.fromRGBO(255, 0, 0, 0.5);
            }else if(double.parse(snapshot.data[i].devices) < double.parse(snapshot.data[i].limit)
              && double.parse(snapshot.data[i].devices) >= double.parse(snapshot.data[i].limit)*0.7){
              colora = Color.fromRGBO(224, 168, 22, 0.5);
            }
            lista.add(ApOnMap(
              piso: snapshot.data[i].piso,
              name: snapshot.data[i].name,
              left: x,
              top: y,
              active: snapshot.data[i].active,
              cover: widget.bodyWidth / 1.7,
              color: colora,
            ));
          }
          return Swiper(
            itemCount: widget.mapas.length,
            itemWidth: double.infinity,
            itemBuilder: (context, i) {
              return Stack(
                  fit: StackFit.expand,
                  children: _makeChidren(lista, i));
            },
            pagination: new SwiperPagination(),
            control: new SwiperControl(
                iconNext: Icons.arrow_right,
                iconPrevious: Icons.arrow_left,
                size: 40.0),
          );
        }
        return circularProgressIndicatorWidget();
      },
    );
  }

  List<Widget> _makeChidren(List listaAps, int index) {
    List<Widget> lista = [];
    for (var i = 0; i < listaAps.length; i++) {
      if (listaAps[i].piso == widget.mapas[index].piso.toString()) {
        lista.add(listaAps[i]);
      }
    }
    lista.add(Positioned(
      bottom: 10.0,
      left: 10.0,
      child: Container(
        child: Text(
            (widget.mapas[index].piso == 0)
                ? 'GROUND FLOOR'
                : 'FLOOR ${widget.mapas[index].piso}',
            style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold)),
        color: Colors.white24,
      ),
    ));
    lista.insert(
      0,
      Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
        child: FadeInImage(
          placeholder: AssetImage('assets/no-image.jpg'),
          fit: BoxFit.fill,
          image: NetworkImage(widget.mapas[index].url),
        ),
      ),
    );
    return lista;
  }
}
