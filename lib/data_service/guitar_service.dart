import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:guitar_app/globalvar.dart';

class GuitarService {
  Future<ListOfGuitar> getGuitar() async {
    var response = await http.get(Uri.parse(a));
    return ListOfGuitar.fromList(
        jsonDecode(Utf8Decoder().convert(response.bodyBytes)));
  }
}

class ListOfGuitar {
  List<Guitar> guitars;
  ListOfGuitar({required this.guitars});
  factory ListOfGuitar.fromList(List list) {
    List<Guitar> _guitar = [];
    for (var element in list) {
      _guitar.add(Guitar.fromJson(element));
    }
    return ListOfGuitar(guitars: _guitar);
  }
}

class Guitar {
  int id;
  String name;
  double price;
  double discount;
  double price_with_discount;
  String model;
  String image;
  String preview;
  String last_sold;
  Uint8List image_memory;
  Guitar(
      {required this.id,
      required this.name,
      required this.price,
      required this.discount,
      required this.price_with_discount,
      required this.model,
      required this.image,
      required this.preview,
      required this.last_sold,
      required this.image_memory});

  factory Guitar.fromJson(map) {
    return Guitar(
      id: map["id"],
      name: map["name"],
      price: map["price"].toDouble(),
      discount: map["discount"].toDouble(),
      price_with_discount: double.parse(map["price_with_discount"].toString()),
      model: map["model"],
      image: map["image"],
      preview: map["preview"],
      last_sold: map["last_sold"],
      image_memory: base64Decode(map["image_memory"]),
    );
  }
}
