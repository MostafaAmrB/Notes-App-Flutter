class Note {
   int? id;
   String? title;
   String? description;
   DateTime? createdDate;

  Note({ this.id ,required  this.title ,required  this.description , this.createdDate });

  Map<String , dynamic> toMap()
  {
    return {
      'id' : createdDate!.millisecondsSinceEpoch,
      'title' : title,
      'description' : description,
      'createdDate' : createdDate?.toIso8601String(),
    };
  }
  @override
  String toString() {
    return 'Note{id: $id, name: $title, age: $description , createdDate: $createdDate}';
  }
}