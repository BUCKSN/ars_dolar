class Dolarsi {
  Dolarsi({
    required this.casa,
  });

  Dolarsi.fromJson(Map<String, dynamic> json) {
    casa = Casa.fromJson(json['casa']);
  }
  late final Casa casa;

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['casa'] = casa.toJson();
    return _data;
  }
}

class Casa {
  Casa({
    required this.compra,
    required this.venta,
    required this.nombre,
  });

  Casa.fromJson(Map<String, dynamic> json) {
    compra = json['compra'];
    venta = json['venta'];
    nombre = json['nombre'];
  }
  late final String compra;
  late final String venta;
  late final String nombre;

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['compra'] = compra;
    _data['venta'] = venta;
    _data['nombre'] = nombre;
    return _data;
  }
}
