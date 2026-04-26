# FlowStateAI

> **Passive Behavioral Sensing for Cognitive Load Estimation**

FlowStateAI estimates cognitive load levels (**Low / Medium / High**) by passively analyzing keyboard and mouse interactions — no invasive sensors like EEG or eye-tracking required.

[![Python 3.11+](https://img.shields.io/badge/python-3.11+-blue.svg)](https://www.python.org/downloads/)
[![Flutter](https://img.shields.io/badge/flutter-3.x-02569B?logo=flutter)](https://flutter.dev/)
[![Status](https://img.shields.io/badge/status-in%20development-orange)]()

---

## How It Works

```
Keyboard & Mouse Events  →  Python Backend  →  frontend_summary.json  →  Flutter Dashboard
        (pynput)            (data_collector)     (JSON contract)           (visualization)
```

The backend captures real-time keyboard and mouse events via `pynput`, processes them through a thread-safe queue, and produces a `frontend_summary.json` at the end of each session. The Flutter app reads this JSON and displays cognitive load indicators on a dashboard. A demo can be run without a live backend using `sample_data/frontend_summary.json`.

---

## Repository Structure

```
FlowStateAI/
├── backend/
│   ├── data_collector.py       # Real-time keyboard/mouse event collection
│   ├── data_analysis.py        # Data quality and statistical analysis
│   ├── flow_logger.py          # Logging infrastructure
│   └── requirements.txt
│
├── frontend/                   # Flutter application (in development)
│
├── docs/
│   ├── integration_contract.md # Backend–Frontend JSON contract
│   ├── library_usage_guide.md
│   ├── data_collector_report.md
│   └── README_TR.md            # Turkish documentation
│
├── sample_data/
│   ├── frontend_summary.json   # ⭐ Frontend demo file
│   ├── sample_event.json
│   ├── sample_summary.json
│   └── README.md
│
└── sessions/                   # Live session output files
    └── YYYY-MM-DD/
```

---

## Setup

### Backend (Python)

```bash
git clone https://github.com/elifyesilyurt/FlowStateAI.git
cd FlowStateAI

python3 -m venv .venv
source .venv/bin/activate        # Windows: .venv\Scripts\activate

pip install -r backend/requirements.txt
```

> **macOS:** Accessibility permission is required.  
> System Preferences → Security & Privacy → Privacy → Accessibility → Add Terminal.

### Frontend (Flutter)

```bash
flutter pub get
flutter run
```

---

## Usage

### Data Collection

```bash
# Runs until Ctrl+C
python backend/data_collector.py

# Fixed duration (seconds)
python backend/data_collector.py --duration 180

# Custom output directory
python backend/data_collector.py --output-dir my_sessions
```

Sessions are saved as `sessions/YYYY-MM-DD/session_HHMMSS.json`.

### Data Analysis

```bash
python backend/data_analysis.py sessions/2026-01-30/session_sample_mixed.json
```

**Sample output:**
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

## Frontend — Demo Guide

To run the demo without a live backend, copy the sample file to Flutter assets:

```
sample_data/frontend_summary.json  →  Flutter: assets/sample/frontend_summary.json
```

Fields displayed on the dashboard:

| Card | JSON Field | Example Value |
|------|------------|---------------|
| Total Events | `total_events` | 23 |
| Keyboard Activity | `keyboard_events` | 14 |
| Mouse Activity | `mouse_events` | 9 |
| Duration | `duration_seconds` | 180 |
| Flow Density | `event_density` | 0.13 |

**Error handling:** If the demo file is missing, the app shows `"No data available"`; if the file is malformed, it shows `"Data format error"`.

Full field definitions and contract: [`docs/integration_contract.md`](docs/integration_contract.md)

---

## Demo Flow

```
Open App  →  Home Screen  →  Start Session
    →  Session Screen  →  Stop
        →  Dashboard (real session data shown on cards)
            →  History Screen
```

---

## Branch Structure

| Branch | Owner | Contents |
|--------|-------|----------|
| `main` | Ümmügülsün | Infrastructure, configuration, documentation |
| `backend-havin` | Havin | Stable data collection, summary generation |
| `elif-frontend-teslim` | Elif | Flutter app, dashboard, JSON integration |

---

## Team

| Role | Person |
|------|--------|
| Backend Configuration & Coordination | Ümmügülsün |
| Backend Core & Data Processing | Havin |
| Frontend & Flutter Integration | Elif |

---

## Development Status

- [x] Real-time keyboard/mouse event collection
- [x] Thread-safe data processing and logging
- [x] `frontend_summary.json` generation
- [x] Flutter dashboard base structure
- [x] JSON integration (demo mode)
- [ ] Cognitive load classification model (ML)
- [ ] Live backend–frontend connection
- [ ] Session history and comparison screen

---

> 🇹🇷 [Türkçe Dokümantasyon](docs/README_TR.md)
