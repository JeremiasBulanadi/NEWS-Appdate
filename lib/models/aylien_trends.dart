// To parse this JSON data, do
//
//     final aylienTrends = aylienTrendsFromJson(jsonString);
import 'dart:convert';

AylienTrends aylienTrendsFromJson(String str) =>
    AylienTrends.fromJson(json.decode(str));

String aylienTrendsToJson(AylienTrends data) => json.encode(data.toJson());

class AylienTrends {
  AylienTrends({
    required this.field,
    required this.trends,
    required this.publishedAtStart,
  });

  String field;
  List<Trend> trends;
  DateTime publishedAtStart;

  factory AylienTrends.fromJson(Map<String, dynamic> json) => AylienTrends(
        field: json["field"],
        trends: List<Trend>.from(json["trends"].map((x) => Trend.fromJson(x))),
        publishedAtStart: DateTime.parse(json["published_at.start"]),
      );

  Map<String, dynamic> toJson() => {
        "field": field,
        "trends": List<dynamic>.from(trends.map((x) => x.toJson())),
        "published_at.start": publishedAtStart.toIso8601String(),
      };
}

class Trend {
  Trend({
    required this.count,
    required this.value,
  });

  int count;
  String value;

  factory Trend.fromJson(Map<String, dynamic> json) => Trend(
        count: json["count"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "value": value,
      };
}
