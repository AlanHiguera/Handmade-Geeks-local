import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:appflutter/models/tienda_modelo.dart';
import '../../config.dart';

// Esta clase se encarga de obtener solo el nombre e imagen de una tienda que subió un producto.
class APIImgNomTiendaXProducto {
  static var client = http.Client();

  static Future<Map<String, dynamic>?> obtenerImgNomTiendaPorProducto(
    int producto,
  ) async {
    Map<String, String> headers = {"Content-Type": "application/json"};

    var url = Uri.parse(
      Config.buildUrl(
        "${Config.tiendaAPI}/ObtenerImgNomIdTiendaPorProducto/?producto_id=$producto",
      ),
    );

    print('🔍 URL tienda por producto: $url');

    var response = await client.get(url, headers: headers);

    print('🔍 Status code: ${response.statusCode}');
    print('🔍 Response body: ${response.body}');

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print('🔍 Data recibida: $data');
      return data;
    } else {
      print("❌ Error al obtener info de tienda: ${response.body}");
      return null;
    }
  }

  static Future<Tienda?> obtenerTiendaPorProducto(int producto) async {
    Map<String, String> headers = {"Content-Type": "application/json"};

    var url = Uri.parse(
      Config.buildUrl("${Config.tiendaAPI}/ObtenerProducto/$producto"),
    );

    print('🔍 URL tienda completa por producto: $url');

    var response = await client.get(url, headers: headers);

    print('🔍 Status code: ${response.statusCode}');
    print('🔍 Response body: ${response.body}');

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return Tienda.fromJson(data);
    } else {
      print("❌ Error al obtener tienda completa: ${response.body}");
      return null;
    }
  }
}
