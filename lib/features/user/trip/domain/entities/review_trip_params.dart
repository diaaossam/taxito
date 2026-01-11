class ReviewTripParams {
  final int tripId;
  final String review;
  final double rating;

  ReviewTripParams({
    required this.tripId,
    required this.review,
    required this.rating,
  });

  Map<String, dynamic> toMap() {
    return {
      'trip_id': tripId,
      'comment': review,
      'rate': rating,
    };
  }
}
