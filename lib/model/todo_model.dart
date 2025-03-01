class TodoModel {
  String? activity;
  String? price;
  String? type;
  bool? bookingRequired;
  double? accessibility;

  TodoModel(
      {this.activity,
      this.price,
      this.type,
      this.bookingRequired,
      this.accessibility});

  Map<String, dynamic> toJson() {
    return {
      'activity': activity,
      'price': price,
      'type': type,
      'bookingRequired': bookingRequired,
      'accessibility': accessibility
    };
  }

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
        activity: json['activity'],
        price: json['price'],
        type: json['type'],
        bookingRequired: json['bookingRequired'],
        accessibility: json['accessibility']);
  }
}
