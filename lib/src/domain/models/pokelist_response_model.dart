import 'dart:convert';

class PokelistResponseModel {
  int? count;
  String? next;
  String? previous;
  List<Result>? results;

  PokelistResponseModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory PokelistResponseModel.fromRawJson(String str) =>
      PokelistResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PokelistResponseModel.fromJson(Map<String, dynamic> json) =>
      PokelistResponseModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: json["results"] == null
            ? []
            : List<Result>.from(
                json["results"]!.map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class Result {
  String? name;
  String? url;

  Result({
    this.name,
    this.url,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}
