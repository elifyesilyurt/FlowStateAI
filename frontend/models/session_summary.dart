// lib/models/session_summary.dart

class SessionSummary {
  final String sessionId;
  final int durationSeconds;
  final int totalEvents;
  final int keyboardEvents;
  final int mouseEvents;
  final double eventDensity;

  SessionSummary({
    required this.sessionId,
    required this.durationSeconds,
    required this.totalEvents,
    required this.keyboardEvents,
    required this.mouseEvents,
    required this.eventDensity,
  });

  factory SessionSummary.fromJson(Map<String, dynamic> json) {
    return SessionSummary(
      sessionId: json['session_id'] ?? "unknown",
      durationSeconds: json['duration_seconds'] ?? 0,
      totalEvents: json['total_events'] ?? 0,
      keyboardEvents: json['keyboard_events'] ?? 0,
      mouseEvents: json['mouse_events'] ?? 0,
      eventDensity: (json['event_density'] ?? 0.0).toDouble(),
    );
  }
}