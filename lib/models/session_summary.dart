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

  // JSON'dan nesne üreten fabrika metodu (Plana uygun)
  factory SessionSummary.fromJson(Map<String, dynamic> json) {
    return SessionSummary(
      sessionId: json['session_id'],
      durationSeconds: json['duration_seconds'],
      totalEvents: json['total_events'],
      keyboardEvents: json['keyboard_events'],
      mouseEvents: json['mouse_events'],
      eventDensity: json['event_density'].toDouble(),
    );
  }
}