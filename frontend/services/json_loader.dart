import 'dart:convert'; // JSON'u anlamak (decode) için [cite: 82]
import 'package:flutter/services.dart'; // rootBundle ile dosyalara erişmek için [cite: 68]

class JsonLoader {
  // Gelecekte bir veri döneceği için 'Future' kullanıyoruz [cite: 64, 83]
  static Future<Map<String, dynamic>> loadSessionSummary() async {
    try {
      // 1. Dosya yolunun assets klasöründekiyle AYNI olduğundan emin olmalısın 
      // Eğer klasörün 'sample' değilse yolu 'assets/sample_summary.json' yapmalısın.
    // json_loader.dart içinde bu satırı güncelle:
      const String filePath = 'assets/sample/frontend_test_summary.json';
      
      // 2. Dosyayı ham metin (string) olarak oku 
      final String response = await rootBundle.loadString(filePath);
      
      // 3. Bu metni Flutter'ın anlayacağı bir haritaya (Map) çevir [cite: 70, 82]
      final Map<String, dynamic> data = json.decode(response);
      
      // Geliştirme aşamasında veriyi görmek iyidir [cite: 14]
      // ignore: avoid_print
      print("Başarılı: JSON Verisi Okundu: $data");
      
      return data;
    } catch (e) {
      // Mühendislik kuralı: Dosya yoksa veya bozuksa uygulama çökmemeli 
      // ignore: avoid_print
      print("HATA: JSON okunurken bir sorun oluştu: $e");
      return {}; // Boş bir harita döndürerek akışı bozmayız
    }
  }
}