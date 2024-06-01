import 'dart:convert';

List<OrderModel> orderModelFromJson(String str) => List<OrderModel>.from(json.decode(str).map((x) => OrderModel.fromJson(x)));

String orderModelToJson(List<OrderModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderModel {
    int? orderId;
    String? orderNo;
    String? status;
    int? tableNo;
    List<Item>? items;

    OrderModel({
        this.orderId,
        this.orderNo,
        this.status,
        this.tableNo,
        this.items,
    });

    factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        orderId: json["order_id"],
        orderNo: json["order_no"],
        status: json["status"],
        tableNo: json["table_no"],
        items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "order_no": orderNo,
        "status": status,
        "table_no": tableNo,
        "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
    };
}

class Item {
    String? name;
    int? quatity;

    Item({
        this.name,
        this.quatity,
    });

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        name: json["name"],
        quatity: json["quatity"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "quatity": quatity,
    };
}
