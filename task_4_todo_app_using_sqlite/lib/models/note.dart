class Note {
  final int? id;
  String? title;
  String? description;
  String? date;
  int? priority;

  Note({this.id, this.title, this.description, this.date, this.priority});

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      date: json['date'],
      priority: json['priority'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'priority': priority,
    };
  }

  void updateNote(String newNote) {
    if (newNote.length <= 255) {
      title = newNote;
    }
  }

  // void updateStatus(String newStatus) {
  //   if (newStatus == 'Pending' || newStatus == 'Completed') {
  //     description = newStatus;
  //   }
  // }

  void updateDate(String newDate) {
    date = newDate;
  }
}
