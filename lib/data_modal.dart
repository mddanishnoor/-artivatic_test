class DataModal {
  int? userId;
  int? id;
  String? title;
  String? body;

  DataModal({this.userId, this.id, this.title, this.body});

  DataModal.fromData(Map<String, dynamic> data)
      : this.userId = data['userId'],
        this.id = data['id'],
        this.title = data['title'],
        this.body = data['body'];
}
