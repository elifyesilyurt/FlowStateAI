# FlowStateAI

> **Passive Behavioral Sensing for Cognitive Load Estimation**

FlowStateAI, kullanıcının klavye ve fare etkileşimlerini pasif olarak analiz ederek bilişsel yük seviyesini (**Düşük / Orta / Yüksek**) tahmin eden bir sistemdir. EEG veya göz takibi gibi invaziv yöntemler yerine yalnızca davranışsal sinyal kullanılır.

[![Python 3.11+](https://img.shields.io/badge/python-3.11+-blue.svg)](https://www.python.org/downloads/)
[![Flutter](https://img.shields.io/badge/flutter-3.x-02569B?logo=flutter)](https://flutter.dev/)
[![Status](https://img.shields.io/badge/status-in%20development-orange)]()

---

## Nasıl Çalışır?

```
Klavye & Fare Olayları  →  Python Backend  →  frontend_summary.json  →  Flutter Dashboard
        (pynput)           (data_collector)      (JSON sözleşmesi)       (görselleştirme)
```

Backend, `pynput` ile gerçek zamanlı klavye/fare olaylarını thread-safe queue üzerinden işler ve her oturum sonunda `frontend_summary.json` üretir. Flutter uygulaması bu JSON'ı okuyarak bilişsel yük göstergelerini dashboard'da gösterir. Canlı backend bağlantısı olmadan da `sample_data/frontend_summary.json` ile demo yapılabilir.

---

## Repo Yapısı

```
FlowStateAI/
├── backend/
│   ├── data_collector.py       # Gerçek zamanlı klavye/fare event toplama
│   ├── data_analysis.py        # Veri kalitesi ve istatistik analizi
│   ├── flow_logger.py          # Logging altyapısı
│   └── requirements.txt
│
├── frontend/                   # Flutter uygulaması (geliştirme aşamasında)
│
├── docs/
│   ├── integration_contract.md # Backend–Frontend JSON sözleşmesi
│   ├── library_usage_guide.md
│   ├── data_collector_report.md
│   └── README_TR.md
│
├── sample_data/
│   ├── frontend_summary.json   # ⭐ Frontend demo dosyası
│   ├── sample_event.json
│   ├── sample_summary.json
│   └── README.md
│
└── sessions/                   # Canlı oturumların çıktısı
    └── YYYY-MM-DD/
```

---

## Kurulum

### Backend (Python)

```bash
git clone https://github.com/elifyesilyurt/FlowStateAI.git
cd FlowStateAI

python3 -m venv .venv
source .venv/bin/activate        # Windows: .venv\Scripts\activate

pip install -r backend/requirements.txt
```

> **macOS:** Accessibility izni gereklidir.  
> System Preferences → Security & Privacy → Privacy → Accessibility → Terminal'i ekle.

### Frontend (Flutter)

```bash
flutter pub get
flutter run
```

---

## Kullanım

### Veri Toplama

```bash
# Ctrl+C ile durdurana kadar çalışır
python backend/data_collector.py

# Belirli süre (saniye)
python backend/data_collector.py --duration 180

# Farklı çıktı klasörü
python backend/data_collector.py --output-dir my_sessions
```

Veriler `sessions/YYYY-MM-DD/session_HHMMSS.json` formatında kaydedilir.

### Veri Analizi

```bash
python backend/data_analysis.py sessions/2026-01-30/session_sample_mixed.json
```

**Örnek çıktı:**
```
=== FlowStateAI Log Analysis ===
Total lines       : 23
Valid JSON         : 23  |  Invalid JSON: 0
Keyboard events   : 14  (key_press: 7, key_release: 7)
Mouse events      : 9   (move: 4, click: 4, scroll: 1)
Keyboard ratio    : 0.61
Mouse ratio       : 0.39
Anomalies:
  - Timestamp order violations : 0
  - Extreme velocity (>50000)  : 0
  - Negative dwell/flight times: 0
```

---

## Frontend — Demo Rehberi

Backend bağlantısı olmadan demo yapmak için sadece şu adım yeterlidir:

```
sample_data/frontend_summary.json  →  Flutter: assets/sample/frontend_summary.json
```

Dashboard'da gösterilen alanlar:

| Kart | JSON Alanı | Örnek Değer |
|------|------------|-------------|
| Total Events | `total_events` | 23 |
| Keyboard Activity | `keyboard_events` | 14 |
| Mouse Activity | `mouse_events` | 9 |
| Duration | `duration_seconds` | 180 |
| Flow Density | `event_density` | 0.13 |

**Hata durumları:** Demo dosyası bulunamazsa `"No data available"`, dosya bozuksa `"Data format error"` gösterilir.

Alan tanımları ve tam sözleşme: [`docs/integration_contract.md`](docs/integration_contract.md)

---

## Demo Akışı

```
Uygulama Aç  →  Home Ekranı  →  Start Session
    →  Session Ekranı  →  Stop
        →  Dashboard (JSON verileri kartlarda görünür)
            →  History Ekranı
```

---

## Branch Yapısı

| Branch | Sahibi | İçerik |
|--------|--------|--------|
| `main` | Ümmügülsün | Altyapı, yapılandırma, dokümantasyon |
| `backend-havin` | Havin | Stabil veri toplama, summary üretimi |
| `elif-frontend-teslim` | Elif | Flutter uygulaması, dashboard, JSON entegrasyonu |

---

## Ekip

| Rol | Kişi |
|-----|------|
| Backend Yapılandırma & Koordinasyon | Ümmügülsün |
| Backend Çekirdek & Veri İşleme | Havin |
| Frontend & Flutter Entegrasyonu | Elif |

---

## Geliştirme Durumu

- [x] Gerçek zamanlı klavye/fare event toplama
- [x] Thread-safe veri işleme ve logging
- [x] `frontend_summary.json` üretimi
- [x] Flutter dashboard temel yapısı
- [x] JSON entegrasyonu (demo modu)
- [ ] Bilişsel yük sınıflandırma modeli (ML)
- [ ] Canlı backend–frontend bağlantısı
- [ ] Oturum geçmişi ve karşılaştırma ekranı

---

> [Türkçe Dokümantasyon](docs/README_TR.md)
