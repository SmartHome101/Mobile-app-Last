class NLPResult {
  final String Intent;
  final String Entity;

  const NLPResult({required this.Intent, required this.Entity});

  factory NLPResult.fromJson(Map<String, dynamic> json) {
    if (json['Intent'] == "Cooking") {
      return NLPResult(
        Intent: json['Intent'],
        Entity: json['Entities']['food'],
      );
    } else if (json['Intent'] == "Weather") {
      return NLPResult(
        Intent: json['Intent'],
        Entity: json['Entities']['location'],
      );
    } else {
      return const NLPResult(
        Intent: "",
        Entity: "",
      );
    }
  }
}
