class Note {
  int? id;
  String? title;
  String? description;
  String? date;
  int? priority;
  String? status;

  Note(
      {this.id,
      this.title,
      this.description,
      this.date,
      this.priority,
      this.status});

  Note.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    priority = json['priority'];
    date = json['date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['priority'] = this.priority;
    data['date'] = this.date;
    data['status'] = this.status;
    return data;
  }

  void updateNote(String newNote) {
    if (newNote.length <= 255) {
      title = newNote;
    }
  }

  void updateStatus(String newStatus) {
    if (newStatus == 'Pending' || newStatus == 'Completed') {
      description = newStatus;
    }
  }

  void updateDate(String newDate) {
    date = newDate;
  }
}
