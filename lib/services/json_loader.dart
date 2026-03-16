import 'dart:convert';
import 'package:flutter/services.dart';

class JsonLoader {
  // JSON dosyasını okuyan fonksiyon [cite: 115, 116, 117]
  static Future<Map<String, dynamic>> loadSessionSummary() async {
    // 1. Assets içindeki dosyayı string olarak yükle
    final String response = await rootBundle.loadString('assets/sample/frontend_test_summary.json');
    
    // 2. String veriyi JSON (Map) formatına çevir
    final data = await json.decode(response);
    
    // Test amaçlı konsola yazdıralım
    print("JSON Verisi Okundu: $data");
    
    return data;
  }
}