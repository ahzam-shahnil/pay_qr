class ChatApiResponse {
  ChatApiResponse({
    required this.response,
  });
  late final String response;

  ChatApiResponse.fromJson(Map<String, dynamic> json) {
    response = json['response'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['response'] = response;
    return _data;
  }
}
