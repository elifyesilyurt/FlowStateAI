# FlowStateAI — Flutter Frontend

> FlowStateAI bilişsel yük tahmin sisteminin Flutter istemcisi.

FlowStateAI, ne kadar zihinsel olarak yoğun olduğunu yalnızca klavye ve fare kullanım şekillerine bakarak tahmin eder. Bu repo, FlowStateAI backend'inin ürettiği oturum verilerini görselleştiren Flutter frontend uygulamasını içerir.

[![Flutter](https://img.shields.io/badge/flutter-3.x-02569B?logo=flutter)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/dart-3.x-0175C2?logo=dart)](https://dart.dev/)
[![Durum](https://img.shields.io/badge/durum-geliştirme%20aşamasında-orange)]()
[![Lisans](https://img.shields.io/badge/lisans-MIT-green)]()

> **Not:** Bu repo yalnızca Flutter frontend kodunu içerir. Projenin tamamı (Python backend + Flutter frontend) ekip olarak geliştirilmekte olup ayrı bir private repoda bulunmaktadır.

---

## İçindekiler

- [Nasıl Çalışır?](#nasıl-çalışır)
- [Proje Yapısı](#proje-yapısı)
- [Gereksinimler](#gereksinimler)
- [Kurulum](#kurulum)
- [Uygulamayı Çalıştırma](#uygulamayı-çalıştırma)
- [Ekranlar](#ekranlar)
- [Demo Modu](#demo-modu)
- [Sorun Giderme](#sorun-giderme)
- [Geliştirme Durumu](#geliştirme-durumu)
- [Katkıda Bulunma](#katkıda-bulunma)
- [Lisans](#lisans)

---

## Nasıl Çalışır?

Backend (Python), oturum sırasında klavye ve fare olaylarını toplayarak `frontend_summary.json` dosyası üretir. Flutter uygulaması bu JSON'ı okuyarak bilişsel yük metriklerini dashboard'da gösterir.

```
Python Backend  →  frontend_summary.json  →  json_loader.dart  →  Dashboard UI
```

Uygulama aynı zamanda **demo modunda** da çalışır — örnek JSON dosyası sayesinde backend bağlantısına gerek kalmaz.

---

## Proje Yapısı

```
frontend/
├── assets/
│   └── sample/
│       └── frontend_summary.json   # Demo modu için örnek veri
│
├── models/                         # Veri modelleri (SessionSummary vb.)
│
├── screens/
│   ├── home_screen.dart            # Giriş ekranı
│   ├── session_screen.dart         # Aktif oturum görünümü
│   ├── dashboard_screen.dart       # Oturum sonuçları ve metrikler
│   └── focus_page.dart             # Odaklanma / bilişsel yük gösterimi
│
├── services/
│   └── json_loader.dart            # frontend_summary.json okuma ve parse
│
├── main.dart                       # Uygulama giriş noktası
├── pubspec.yaml
└── pubspec.lock
```

---

## Gereksinimler

| Araç | Versiyon |
|------|----------|
| Flutter | 3.x |
| Dart | 3.x |
| Git | herhangi |

Flutter kurulumu: [flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install)

---

## Kurulum

```bash
git clone https://github.com/elifyesilyurt/FlowStateAI.git
cd FlowStateAI/frontend

flutter pub get
```

---

## Uygulamayı Çalıştırma

```bash
# Bağlı cihaz veya emülatörde çalıştır
flutter run

# Belirli bir platformda çalıştır
flutter run -d chrome       # Web
flutter run -d macos        # macOS masaüstü
flutter run -d android      # Android emülatör
```

---

## Ekranlar

| Ekran | Dosya | Açıklama |
|-------|-------|----------|
| Home | `home_screen.dart` | Giriş ekranı |
| Session | `session_screen.dart` | Aktif oturum izleme görünümü |
| Dashboard | `dashboard_screen.dart` | Metrik kartlarıyla oturum sonuçları |
| Focus Page | `focus_page.dart` | Bilişsel yük seviyesi gösterimi |

**Uygulama akışı:**

```
Home Ekranı  →  Start Session
    →  Session Ekranı  →  Stop
        →  Dashboard (JSON'dan metrikler)
            →  Focus Page
```

---

## Demo Modu

Uygulama, canlı backend bağlantısı olmadan yerleşik örnek dosyayla çalışır.

Örnek dosya konumu:
```
assets/sample/frontend_summary.json
```

JSON'dan okunan dashboard metrikleri:

| Kart | JSON Alanı | Örnek |
|------|------------|-------|
| Total Events | `total_events` | 23 |
| Keyboard Activity | `keyboard_events` | 14 |
| Mouse Activity | `mouse_events` | 9 |
| Duration | `duration_seconds` | 180 |
| Flow Density | `event_density` | 0.13 |

**Hata durumları:**
- Dosya bulunamazsa → `"No data available"`
- Dosya bozuksa → `"Data format error"`

---

## Sorun Giderme

**`flutter pub get` başarısız oluyor**

Flutter'ın kurulu ve PATH'te olduğundan emin ol:
```bash
flutter doctor
```
Çıkan sorunları giderdikten sonra tekrar dene.

---

**Assets yüklenmiyor (`frontend_summary.json` bulunamıyor)**

`pubspec.yaml`'da asset'in tanımlı olduğunu kontrol et:
```yaml
flutter:
  assets:
    - assets/sample/frontend_summary.json
```
Ardından `flutter pub get` komutunu tekrar çalıştır.

---

**Uygulama macOS'ta açılmıyor**

macOS build'i Xcode gerektirir:
```bash
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -runFirstLaunch
```

---

## Geliştirme Durumu

- [x] Home ekranı
- [x] Session ekranı
- [x] Dashboard ekranı (metrik kartları)
- [x] Focus page
- [x] JSON loader servisi (`json_loader.dart`)
- [x] Örnek veriyle demo modu
- [ ] Canlı backend bağlantısı
- [ ] Oturum geçmişi ekranı
- [ ] Bilişsel yük sınıflandırma UI (Düşük / Orta / Yüksek)

---

## Katkıda Bulunma

Pull request'ler kabul edilir. Büyük değişiklikler için önce bir issue aç.

1. Repo'yu fork'la
2. Feature branch oluştur (`git checkout -b feature/ozellik-adi`)
3. Değişikliklerini commit'le (`git commit -m 'feat: özellik ekle'`)
4. Branch'e push'la (`git push origin feature/ozellik-adi`)
5. Pull Request aç

---

## Lisans

MIT © 2026 Elif Yeşilyurt

---

> 🇬🇧 [English Documentation](../README.md)
