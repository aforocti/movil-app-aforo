import 'package:flutter/material.dart';
import 'package:app_deteccion_personas/src/widgets/varios_widget.dart';
import 'package:app_deteccion_personas/src/providers/image_provider.dart';
import 'package:app_deteccion_personas/src/widgets/card_swiper_widget.dart';
import 'package:app_deteccion_personas/src/utils/utils.dart' as utils;

class PrincipalPage extends StatefulWidget {
  @override
  _PrincipalPageState createState() => _PrincipalPageState();
}

class _PrincipalPageState extends State<PrincipalPage> {
  final _imageProvider = new ImagenProvider();
  final _texto =
      'Para cargar mapas nuevos, dirígete a ajustes y selecciona Cargar Mapa, selecciona el piso al que pertenece la imágen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight - 15),
        child: Container(
          color: utils.setColor('color6t5', 'color2'),
          child: Tab(
              child: Text('PLANOS',
                  style: TextStyle(
                      color: Color.fromRGBO(10, 52, 68, 1.0),
                      fontSize: 18,
                      fontWeight: FontWeight.w600))),
        ),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return _crearSwiper(constraints.maxHeight, constraints.maxWidth);
      }),
    );
  }

  Widget _crearSwiper(double bodyHeight, double bodyWidth) {
    return FutureBuilder(
      future: _imageProvider.cargarImages(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Column(children: [
            utils.errorInfo(snapshot.error, Colors.red),
            
            utils.iconFont(Icons.wifi_off, context, '')
          ]);
        } else if (snapshot.hasData) {
          if (snapshot.data.isEmpty) {
            return Column(children: [
              utils.errorInfo('Sin Información', Colors.purple),
              Expanded(
                child:utils.iconFont(Icons.location_searching, context, _texto)
              )
            ]);
          } else
            return CardSwiperWidget(
                mapas: snapshot.data,
                bodyHeight: bodyHeight,
                bodyWidth: bodyWidth);
        } else {
          return circularProgressIndicatorWidget();
        }
      },
    );
  }
}
