// ignore_for_file: unused_local_variable

import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../generated/l10n.dart';
import '../model/dollar_model.dart';

class Ambito {
  Ambito({
    required this.name,
  });
  late final String name;
}

class AmbitoRepository {
  // Future<List<Dollar>>
  Future<void> fetchAmbito() async {
    try {
      final response = await http
          // .get(Uri.parse('https://www.ambito.com/contenidos/dolar.html'));
          .get(Uri.parse(
              'https://www.ambito.com/contenidos/dolar-informal.html'));

      if (response.statusCode == 200) {
        ////TEST
        final document = parse(response.body);
        // final List<String> test = [];
        // test.addAll(iterable);

        print(response.statusCode);
        // var ttt = document.getElementsByClassName(
        //     'variation-max-min variation-max-min--xs indicador');
        var ttt = document.getElementsByClassName('indicador');

        // print(ttt[0].innerHtml.substring(1));
        // var zzz = ttt[0].getElementsByClassName('variation-max-min__title');
        // ttt[0].getElementsByClassName('variation-max-min__values-wrapper');
        // var name = ttt[0].getElementsByTagName('span')[0].text.trim();

        var ddd = document
            .getElementsByClassName('variation-max-min__date-time data-fecha');
        // var xxx = ttt[0].getElementsByClassName('data-compra')[0];
        // var yyy = ttt[0].getElementsByClassName('data-venta')[0];
        // var zzz = ttt[0].getElementsByClassName('data-fecha')[0];
        print(ddd);
        // ttt[0].innerHtml.substring(0, ttt[0].innerHtml.indexOf('<span>'));
        // print(ttt);

        ////TEST
        final SharedPreferences rastesData =
            await SharedPreferences.getInstance();
        rastesData.setString('ambito', response.body);
        // return getAmbito();
      } else {
        throw Exception(S.current.error_message);
      }
    } catch (error) {
      // return getAmbito();
    }
  }

  Future<List<Dollar>> getAmbito() async {
    final SharedPreferences _rastesData = await SharedPreferences.getInstance();
    final String _ambito = _rastesData.getString('ambito') ?? '';
    print(_ambito);
    if (_ambito != '') {
      final document = parse(_ambito);
      // final List<String> data = [];

      // data.add(document.getElementsByClassName('variation-max-min variation-max-min--xs indicador')[0].innerHtml);

      final List<Dollar> result = [];
      return result;
    } else {
      throw Exception(S.current.error_message);
    }
  }

  // Dollar convertAmbitoToDollar(List<Ambito> list, String text,
  //     TextStyle textStyleBuy, TextStyle textStyleSell) {
  //   final Ambito ambito =
  //       list.where((element) => element.casa.nombre == text).first;
  //   final Dollar dollar = Dollar(
  //     name: ambito.casa.nombre,
  //     buy: (ambito.casa.compra == 'No Cotiza') ? 'None' : ambito.casa.compra,
  //     sell: (ambito.casa.venta == '0') ? 'None' : ambito.casa.venta,
  //     isUp: null,
  //     percent: null,
  //     date: 'NOW',
  //     textStyleBuy: textStyleBuy,
  //     textStyleSell: textStyleSell,
  //   );
  //   return dollar;
  // }
}
