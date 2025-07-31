import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class UtilsServices {

  final storage = const FlutterSecureStorage();

  //salva dad localmente em seguranca
  Future<void> saveLocalData({required String key, required String data})async {
    await storage.write(key: key, value: data);
  }
  
  //recupera dado salvo localmente em seguranca
  Future<String?> getLocalData({required String key})async {
    return await storage.read(key: key);
  }

  //remove dado salvo localmente
  Future<void> removeLocalData({required String key})async {
    await storage.delete(key: key);
  }


  String priceToCurrency(double price) {
    NumberFormat numberFormat = NumberFormat.simpleCurrency(locale: 'pt_BR');

    return numberFormat.format(price);
  }

  String formatDateTime(DateTime dateTime) {
    initializeDateFormatting();

    DateFormat dateFormat = DateFormat.yMd('pt_BR').add_Hm();

    return dateFormat.format(dateTime);
  }

  void showToast({required String message, bool isError = false}) {

    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG, //tempo apresentacao do toast
        gravity: ToastGravity.BOTTOM, //local que o toast vai aparecer na tela
        timeInSecForIosWeb: 3, //tempo que vamos apresentar a msg em ios e web
        backgroundColor: isError? Colors.red : Colors.white, // cor de fundo
        textColor: isError? Colors.white : Colors.black,  //cor do texto
        fontSize: 14.0);
  }

}
