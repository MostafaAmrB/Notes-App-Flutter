class Task {
   int? id;
   String? title;
   String? description;
   DateTime? createdDate;
   DateTime? deadlineDate;

  Task({ this.id ,required  this.title ,required  this.description , this.createdDate , this.deadlineDate});

  Map<String , dynamic> toMap()
  {
    return {
      'id' : id,
      'title' : title,
      'description' : description,
      'createdDate' : createdDate,
      'deadlineDate' : deadlineDate,
    };
  }
  @override
  String toString() {
    return 'Task{id: $id, name: $title, age: $description , createdDate: $createdDate, age: $deadlineDate}';
  }
}