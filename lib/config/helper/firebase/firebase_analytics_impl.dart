import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:injectable/injectable.dart';
import 'analytics_event.dart';

abstract class AnalyticsProvider {
  void log(AnalyticsEvent event);
}

@Injectable(as: AnalyticsProvider)
class FirebaseAnalyticsProvider extends AnalyticsProvider {
  final FirebaseAnalytics _firebaseAnalytics;

  FirebaseAnalyticsProvider(this._firebaseAnalytics);

  @override
  void log(AnalyticsEvent event) {
    if (event.key == null) return;
    _firebaseAnalytics.logEvent(
      name: event.key!,
      parameters: event.params as Map<String, Object>,
    );
  }
}
