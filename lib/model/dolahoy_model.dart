import 'package:json_annotation/json_annotation.dart';

part 'dolahoy_model.g.dart';

@JsonSerializable()
class Dolarhoy {
  Dolarhoy({
    required this.name,
    required this.buy,
    required this.sell,
    required this.date,
  });
  factory Dolarhoy.fromJson(Map<String, dynamic> json) =>
      _$DolarhoyFromJson(json);
  late final String name;
  late final String buy;
  late final String sell;
  late final String date;
  Map<String, dynamic> toJson() => _$DolarhoyToJson(this);
}
