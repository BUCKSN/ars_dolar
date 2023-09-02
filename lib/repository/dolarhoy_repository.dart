// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:flutter/src/painting/text_style.dart';
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../generated/l10n.dart';
import '../model/dolahoy_model.dart';
import '../model/dollar_model.dart';
import '../theme/theme_constants.dart';

class DolarhoyRepository {
  Future<List<Dollar>> fetchDolarhoy() async {
    // var SUKA = [
    //   Dollar(
    //       name: 'name',
    //       buy: 'buy',
    //       sell: 'sell',
    //       isUp: null,
    //       percent: 'percent',
    //       date: 'date',
    //       textStyleBuy: TextStyle(),
    //       textStyleSell: TextStyle())
    // ];
    try {
      final response = await http.get(Uri.parse('https://dolarhoy.com'));

      if (response.statusCode == 200) {
        final body = parse(response.body);

        final dateTime =
            body.getElementsByClassName('tile update')[0].text.trim();

        final document = body
            .getElementsByClassName('tile dolar')[0]
            .getElementsByClassName('tile is-parent is-7 is-vertical')[0];

        final List<Dolarhoy> _dolarhoy = [];

        void parseDolarhay(
            int name, int? buy, int? sell, String text, dynamic nameNew) {
          final dollarName =
              (document.getElementsByClassName('title')[name].text.trim() ==
                      text)
                  // ? S.current.dollar_blue
                  ? nameNew
                  : null;
          final dollarBuy = (buy != null)
              ? document.getElementsByClassName('val')[buy].text.trim()
              : '-';
          final dollarSell = (sell != null)
              ? document.getElementsByClassName('val')[sell].text.trim()
              : '-';
          if (dollarName != null) {
            _dolarhoy.add(Dolarhoy(
                name: dollarName,
                buy: dollarBuy,
                sell: dollarSell,
                date: dateTime));
          }
        }

        parseDolarhay(0, 0, 1, 'Dólar blue', S.current.dollar_blue);
        parseDolarhay(
            1, 2, 3, 'Dólar oficial promedio', S.current.dollar_oficial);
        parseDolarhay(2, 4, 5, 'Dólar Bolsa', S.current.dollar_purse);
        parseDolarhay(
            3, 6, 7, 'Contado con liqui', S.current.counted_with_liquid);
        parseDolarhay(4, 8, 9, 'Dólar cripto', S.current.crypto_dollar);
        parseDolarhay(5, null, 10, 'Dólar Solidario', S.current.tourist_dollar);

        // print('dolarhoy $_dolarhoy');
        // final jsonstr = jsonEncode(dolarhoy.map((e) => e.toJson()).toList());
        final jsonstr = _dolarhoy.map((e) => e.toJson()).toList();
        // final jsonstr = jsonEncode(dolarhoyList);
        // print(jsonstr);

        final SharedPreferences _dolarhoyData =
            await SharedPreferences.getInstance();
        // _dolarhoyData.setString('dolarhoy', jsonstr);
        _dolarhoyData.setString('dolarhoy', jsonEncode(jsonstr));
        // _dolarhoyData.setString('dolarhoy', jsonEncode(dolarhoy));
        // return dolarhoy;
        return getDolarhoy();
      } else {
        throw Exception(S.current.error_message);
      }
    } catch (error) {
      return getDolarhoy();
    }
  }

  Future<List<Dollar>> getDolarhoy() async {
    final SharedPreferences _dolarhoyData =
        await SharedPreferences.getInstance();
    final String _jsonstr = _dolarhoyData.getString('dolarhoy') ?? '';
    // print('_jsonstr $_jsonstr');
    if (_jsonstr != '') {
      final list = json.decode(_jsonstr);
      final List<Dolarhoy> _dolarhoy =
          List<Dolarhoy>.from(list.map((model) => Dolarhoy.fromJson(model)));

      // final List<Dollar> _dolarhoy =
      //     List<Dollar>.from(list.map((model) => Dolarhoy.fromJson(model)));
      final List<Dollar> result =
          _dolarhoy.map((e) => convertDolarhoyToDollar(e)).toList();
      return result;
    } else {
      throw Exception(S.current.error_message);
    }
  }

  Dollar convertDolarhoyToDollar(Dolarhoy dolarhoy) {
    final TextStyle _textStyleBuy = (dolarhoy.name == S.current.dollar_blue)
        ? AppTextStyle.dolarBlueBuy
        : AppTextStyle.dolarOtherBuy;

    // final TextStyle _textStyleBuy = (dolarhoy.name == S.current.dollar_blue)
    //     ? AppTextStyle.dolarBlueBuy
    //     : AppTextStyle.dolarOtherBuy;
    // dollar.textStyleSell = (dollar.name == S.current.dollar_blue)
    //     ? AppTextStyle.dolarBlueSell
    //     : AppTextStyle.dolarOtherSell;
    final Dollar dollar = Dollar(
      name: dolarhoy.name,
      buy: dolarhoy.buy,
      sell: dolarhoy.sell,
      isUp: null,
      percent: null,
      date: dolarhoy.date,
      textStyleBuy: _textStyleBuy,
      textStyleSell: AppTextStyle.dolarOtherSell,
    );
    return dollar;
  }
}



      // final _dolarhoy = jsonDecode(_jsonstr);
      //!!!!!!!!!!!!!

      // final List<Dollar> dolarhoy = [];

      // dolarhoy.add(convertDolarhoyToDollar(
      //     dollarBlueName!,
      //     dollarBlueBuy,
      //     dollarBlueSell,
      //     dateTime,
      //     AppTextStyle.dolarBlueBuy,
      //     AppTextStyle.dolarBlueSell));

      // dolarhoy.add(convertDolarhoyToDollar(
      //     dollarOficialName!,
      //     dollarOficialBuy,
      //     dollarOficialSell,
      //     dateTime,
      //     AppTextStyle.dolarOficialBuy,
      //     AppTextStyle.dolarOficialSell));

      // dolarhoy.add(convertDolarhoyToDollar(
      //     dollarPurseName!,
      //     dollarPurseBuy,
      //     dollarPurseSell,
      //     dateTime,
      //     AppTextStyle.dolarOtherBuy,
      //     AppTextStyle.dolarOtherSell));

      // dolarhoy.add(convertDolarhoyToDollar(
      //     countedWithLiquidName!,
      //     countedWithLiquidBuy,
      //     countedWithLiquidSell,
      //     dateTime,
      //     AppTextStyle.dolarOtherBuy,
      //     AppTextStyle.dolarOtherSell));

      // dolarhoy.add(convertDolarhoyToDollar(
      //     cryptoDollarName!,
      //     cryptoDollarBuy,
      //     cryptoDollarSell,
      //     dateTime,
      //     AppTextStyle.dolarOtherBuy,
      //     AppTextStyle.dolarOtherSell));

      // dolarhoy.add(convertDolarhoyToDollar(
      //     touristDollarName!,
      //     touristDollarBuy,
      //     touristDollarSell,
      //     dateTime,
      //     AppTextStyle.dolarOtherBuy,
      //     AppTextStyle.dolarOtherSell));
      //!!!!!!!!!!!!!
        // "dollar_blue": "Dólar blue",
        // "dollar_oficial": "Dólar oficial promedio",
        // "dollar_purse": "Dólar Bolsa",
        // "counted_with_liquid": "Contado con liqui",
        // "crypto_dollar": "Dólar cripto",
        // "tourist_dollar": "Dólar Turista o Solidario"



        // var name1 = main
        //     // .getElementsByClassName('tile dolar')[0]
        //     .getElementsByClassName('title')[0]
        //     .text
        //     .trim();
        // var compra1 = main
        //     .getElementsByClassName('compra')[0]
        //     .getElementsByClassName('val')[0]
        //     .text
        //     .trim();
        // var venta1 = main
        //     .getElementsByClassName('venta')[0]
        //     .getElementsByClassName('val')[0]
        //     .text
        //     .trim();

        // final name1 = document.getElementsByClassName('title')[0].text.trim();
        // final compra1 = document.getElementsByClassName('val')[0].text.trim();
        // final venta1 = document.getElementsByClassName('val')[1].text.trim();

        // final name2 = document.getElementsByClassName('title')[1].text.trim();
        // final compra2 = document.getElementsByClassName('val')[2].text.trim();
        // final venta2 = document.getElementsByClassName('val')[3].text.trim();

        // final name3 = document.getElementsByClassName('title')[2].text.trim();
        // final compra3 = document.getElementsByClassName('val')[4].text.trim();
        // final venta3 = document.getElementsByClassName('val')[5].text.trim();

        // final name4 = document.getElementsByClassName('title')[3].text.trim();
        // final compra4 = document.getElementsByClassName('val')[6].text.trim();
        // final venta4 = document.getElementsByClassName('val')[7].text.trim();

        // final name5 = document.getElementsByClassName('title')[4].text.trim();
        // final compra5 = document.getElementsByClassName('val')[8].text.trim();
        // final venta5 = document.getElementsByClassName('val')[9].text.trim();

        // final name6 = document.getElementsByClassName('title')[5].text.trim();
        // final compra6 = 'None';
        // final venta6 = document.getElementsByClassName('val')[10].text.trim();

        // print(ttt[0].innerHtml.substring(1));
        // var zzz = ttt[0].getElementsByClassName('variation-max-min__title');
        // ttt[0].getElementsByClassName('variation-max-min__values-wrapper');
        // var name = ttt[0].getElementsByTagName('span')[0].text.trim();

        // var ddd = ttt[0].getElementsByTagName('span')[1].text;
        // var xxx = ttt[0].getElementsByClassName('data-compra')[0];
        // var yyy = ttt[0].getElementsByClassName('data-venta')[0];
        // var zzz = ttt[0].getElementsByClassName('data-fecha')[0];
        // ttt[0].innerHtml.substring(0, ttt[0].innerHtml.indexOf('<span>'));
        // print(ttt);
        

        // final dollarBlueName =
        //     (document.getElementsByClassName('title')[0].text.trim() ==
        //             'Dólar blue')
        //         ? S.current.dollar_blue
        //         : null;
        // final dollarBlueBuy =
        //     document.getElementsByClassName('val')[0].text.trim();
        // final dollarBlueSell =
        //     document.getElementsByClassName('val')[1].text.trim();
        // if (dollarBlueName != null) {
        //   _dolarhoy.add(Dolarhoy(
        //       name: dollarBlueName,
        //       buy: dollarBlueBuy,
        //       sell: dollarBlueSell,
        //       date: dateTime));
        // }

        // final dollarOficialName =
        //     (document.getElementsByClassName('title')[1].text.trim() ==
        //             'Dólar oficial promedio')
        //         ? S.current.dollar_oficial
        //         : null;
        // final dollarOficialBuy =
        //     document.getElementsByClassName('val')[2].text.trim();
        // final dollarOficialSell =
        //     document.getElementsByClassName('val')[3].text.trim();
        // if (dollarOficialName != null) {
        //   _dolarhoy.add(Dolarhoy(
        //       name: dollarOficialName,
        //       buy: dollarOficialBuy,
        //       sell: dollarOficialSell,
        //       date: dateTime));
        // }

        // final dollarPurseName =
        //     (document.getElementsByClassName('title')[2].text.trim() ==
        //             'Dólar Bolsa')
        //         ? S.current.dollar_purse
        //         : null;
        // final dollarPurseBuy =
        //     document.getElementsByClassName('val')[4].text.trim();
        // final dollarPurseSell =
        //     document.getElementsByClassName('val')[5].text.trim();
        // if (dollarPurseName != null) {
        //   _dolarhoy.add(Dolarhoy(
        //       name: dollarPurseName,
        //       buy: dollarPurseBuy,
        //       sell: dollarPurseSell,
        //       date: dateTime));
        // }

        // final countedWithLiquidName =
        //     (document.getElementsByClassName('title')[3].text.trim() ==
        //             'Contado con liqui')
        //         ? S.current.counted_with_liquid
        //         : null;
        // final countedWithLiquidBuy =
        //     document.getElementsByClassName('val')[6].text.trim();
        // final countedWithLiquidSell =
        //     document.getElementsByClassName('val')[7].text.trim();
        // if (countedWithLiquidName != null) {
        //   _dolarhoy.add(Dolarhoy(
        //       name: countedWithLiquidName,
        //       buy: countedWithLiquidBuy,
        //       sell: countedWithLiquidSell,
        //       date: dateTime));
        // }

        // final cryptoDollarName =
        //     (document.getElementsByClassName('title')[4].text.trim() ==
        //             'Dólar cripto')
        //         ? S.current.crypto_dollar
        //         : null;
        // final cryptoDollarBuy =
        //     document.getElementsByClassName('val')[8].text.trim();
        // final cryptoDollarSell =
        //     document.getElementsByClassName('val')[9].text.trim();
        // if (cryptoDollarName != null) {
        //   _dolarhoy.add(Dolarhoy(
        //       name: cryptoDollarName,
        //       buy: cryptoDollarBuy,
        //       sell: cryptoDollarSell,
        //       date: dateTime));
        // }

        // final touristDollarName =
        //     (document.getElementsByClassName('title')[5].text.trim() ==
        //             'Dólar Solidario')
        //         ? S.current.tourist_dollar
        //         : null;
        // const touristDollarBuy = '-';
        // final touristDollarSell =
        //     document.getElementsByClassName('val')[10].text.trim();
        // if (touristDollarName != null) {
        //   _dolarhoy.add(Dolarhoy(
        //       name: touristDollarName,
        //       buy: touristDollarBuy,
        //       sell: touristDollarSell,
        //       date: dateTime));
        // }