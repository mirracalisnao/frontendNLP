class Message {
  final String sender;
  final String content;

  // Constructor
  Message({required this.sender, required this.content});

  // converting JSON object from backend to
  // class to be used by the frontend

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      // the sender and res are the name of the
      // params returned by Flask
      sender: json['sender'],
      content: json['res'],
    );
  }
}
