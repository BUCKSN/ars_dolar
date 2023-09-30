import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../generated/l10n.dart';
import '../model/dolahoy_model.dart';
import '../model/dollar_model.dart';
import '../theme/theme_constants.dart';

class DolarhoyRepository {
  Future<List<Dollar>> fetchDolarhoy() async {
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

        final jsonstr = _dolarhoy.map((e) => e.toJson()).toList();
        final SharedPreferences _dolarhoyData =
            await SharedPreferences.getInstance();
        _dolarhoyData.setString('dolarhoy', jsonEncode(jsonstr));
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
    if (_jsonstr != '') {
      final List<dynamic> list = json.decode(_jsonstr);
      final List<Dolarhoy> _dolarhoy = List<Dolarhoy>.from(
          list.map((dynamic model) => Dolarhoy.fromJson(model)));

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
