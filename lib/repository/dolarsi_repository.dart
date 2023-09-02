import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:json_helpers/json_helpers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../generated/l10n.dart';
import '../model/dolarsi_model.dart';
import '../model/dollar_model.dart';
import '../theme/theme_constants.dart';

class DolarsiRepository {
  Future<List<Dollar>> fetchDolarsi() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.dolarsi.com/api/api.php?type=valoresprincipales'));
      if (response.statusCode == 200) {
        final SharedPreferences _dolarsiData =
            await SharedPreferences.getInstance();
        _dolarsiData.setString('dolarsi', response.body);
        // return response.body.jsonList((e) => Dolar.fromJson(e));
        return getDolarsi();
      } else {
        throw Exception(S.current.error_message);
      }
    } catch (error) {
      return getDolarsi();
    }
  }

  Future<List<Dollar>> getDolarsi() async {
    final SharedPreferences _dolarsiData =
        await SharedPreferences.getInstance();
    final String _dolarsi = _dolarsiData.getString('dolarsi') ?? '';
    if (_dolarsi != '') {
      // final List<Dolarsi> list = _dolarsi.jsonList((e) => Dolarsi.fromJson(e));
      // final List<Dollar> list = jsonDecode(_dolarsi);
      final Iterable<dynamic> l = json.decode(_dolarsi);
      final List<Dolarsi> list =
          List<Dolarsi>.from(l.map((model) => Dolarsi.fromJson(model)));
      // list.length = result.length - 7;
      // list.removeWhere((element) => element.casa.nombre == "Dolar");
      // list.removeWhere((element) => element.casa.nombre == "Dolar Bolsa");
      // list.removeWhere((element) => element.casa.nombre == "Argentina");
      // list.removeWhere((element) => element.casa.nombre == "Dolar Soja");
      // list.removeWhere(
      //     (element) => element.casa.nombre == "Dolar Contado con Liqui");

      // result
      //     .addAll(list.where((element) => element.casa.nombre == 'Dolar Blue'));
      // result.addAll(
      //     list.where((element) => element.casa.nombre == 'Dolar Oficial'));
      // result.addAll(
      //     list.where((element) => element.casa.nombre == 'Dolar turista'));
      // result.addAll(list.where((element) => element.casa.nombre == 'Bitcoin'));

      final List<Dollar> result = [];

      result.add(convertDolarsiToDollar(list, 'Dolar Blue',
          AppTextStyle.dolarBlueBuy, AppTextStyle.dolarBlueSell));
      result.add(convertDolarsiToDollar(list, 'Dolar Oficial',
          AppTextStyle.dolarOficialBuy, AppTextStyle.dolarOficialSell));
      result.add(convertDolarsiToDollar(list, 'Dolar turista',
          AppTextStyle.dolarOtherBuy, AppTextStyle.dolarOtherSell));
      result.add(convertDolarsiToDollar(list, 'Bitcoin',
          AppTextStyle.dolarOtherBuy, AppTextStyle.dolarOtherSell));
      return result;
    } else {
      throw Exception(S.current.error_message);
    }
  }

  Dollar convertDolarsiToDollar(List<Dolarsi> list, String text,
      TextStyle textStyleBuy, TextStyle textStyleSell) {
    final Dolarsi dolarsi =
        list.where((element) => element.casa.nombre == text).first;
    final Dollar dollar = Dollar(
      name: dolarsi.casa.nombre,
      buy: (dolarsi.casa.compra == 'No Cotiza') ? 'None' : dolarsi.casa.compra,
      sell: (dolarsi.casa.venta == '0') ? 'None' : dolarsi.casa.venta,
      isUp: null,
      percent: null,
      date: 'NOW',
      textStyleBuy: textStyleBuy,
      textStyleSell: textStyleSell,
    );
    return dollar;
  }
  // }
}
