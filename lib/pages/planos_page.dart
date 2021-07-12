import 'package:flutter/material.dart';
import 'package:app_deteccion_personas/widgets/varios_widget.dart';
import 'package:app_deteccion_personas/providers/image_provider.dart';
import 'package:app_deteccion_personas/widgets/card_swiper_widget.dart';
import 'package:app_deteccion_personas/utils/utils.dart' as utils;

class PlanosPage extends StatefulWidget {
  @override
  _PlanosPageState createState() => _PlanosPageState();
}

class _PlanosPageState extends State<PlanosPage> {
  final _imageProvider = new ImagenProvider();
  final _texto =
      'Para cargar planos dirígete a Información y Ajustes y selecciona la opción Cargar Plano';

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
                      color: utils.getColor('color6'), fontSize: 18))),
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
            utils.errorInfo("Erros en conexión.", Colors.red),
            utils.iconFont(Icons.wifi_off, context, '')
          ]);
        } else if (snapshot.hasData) {
          if (snapshot.data.isEmpty) {
            return Column(children: [
              utils.errorInfo('Sin Información', Colors.purple),
              Expanded(
                  child:
                      utils.iconFont(Icons.location_searching, context, _texto))
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
