class ChatApiResponse {
  ChatApiResponse({
    required this.response,
  });
  late final String response;

  ChatApiResponse.fromJson(Map<String, dynamic> json) {
    response = json['response'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['response'] = response;
    return data;
  }
}
