import 'package:flutter/material.dart';

class Dollar {
  Dollar({
    required this.name,
    required this.buy,
    required this.sell,
    required this.isUp,
    required this.percent,
    required this.date,
    required this.textStyleBuy,
    required this.textStyleSell,
  });

  Dollar.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    buy = json['buy'];
    sell = json['sell'];
    isUp = json['isup'];
    percent = json['percent'];
    date = json['date'];
    textStyleBuy = json['textStyleBuy'];
    textStyleSell = json['textStyleSell'];
  }
  late final String name;
  late final String buy;
  late final String sell;
  late final bool? isUp;
  late final String? percent;
  late final String date;
  late final TextStyle textStyleBuy;
  late final TextStyle textStyleSell;

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['buy'] = buy;
    _data['sell'] = sell;
    _data['isup'] = isUp;
    _data['percent'] = percent;
    _data['date'] = date;
    _data['textStyleBuy'] = textStyleBuy;
    _data['textStyleSell'] = textStyleSell;
    return _data;
  }
}
