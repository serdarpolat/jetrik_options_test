// To parse this JSON data, do
//
//     final menuGroupModel = menuGroupModelFromJson(jsonString);

import 'dart:convert';

List<MenuGroupModel> menuGroupModelFromJson(String str) =>
    List<MenuGroupModel>.from(
        json.decode(str).map((x) => MenuGroupModel.fromJson(x)));

String menuGroupModelToJson(List<MenuGroupModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MenuGroupModel {
  MenuGroupModel({
    required this.customerId,
    required this.optionGroupName,
    required this.optionName,
    required this.optionPrice,
    required this.option,
    required this.sortOrder,
    required this.id,
  });

  int customerId;
  String optionGroupName;
  String optionName;
  double optionPrice;
  List<Option> option;
  int sortOrder;
  String id;

  factory MenuGroupModel.fromJson(Map<String, dynamic> json) => MenuGroupModel(
        customerId: json["CustomerId"],
        optionGroupName: json["OptionGroupName"],
        optionName: json["OptionName"],
        optionPrice: json["OptionPrice"].toDouble(),
        option:
            List<Option>.from(json["Option"].map((x) => Option.fromJson(x))),
        sortOrder: json["SortOrder"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "CustomerId": customerId,
        "OptionGroupName": optionGroupName,
        "OptionName": optionName,
        "OptionPrice": optionPrice,
        "Option": List<dynamic>.from(option.map((x) => x.toJson())),
        "SortOrder": sortOrder,
        "id": id,
      };
}

class Option {
  Option({
    required this.optionId,
    required this.optionName,
  });

  int optionId;
  String optionName;

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        optionId: json["OptionId"],
        optionName: json["OptionName"],
      );

  Map<String, dynamic> toJson() => {
        "OptionId": optionId,
        "OptionName": optionName,
      };
}
