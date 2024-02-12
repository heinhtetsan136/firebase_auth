class NoteModel {
  final String id;
  final String userid;
  final String title;
  final String acl;
  final String description;
  bool get editable => acl == "Public";

  NoteModel(
      {required this.id,
      required this.userid,
      required this.title,
      required this.acl,
      required this.description});

  @override
  bool operator ==(covariant NoteModel other) {
    return other.id == id;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => id.hashCode;

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "acl": acl,
        "description": description,
        "userid": userid
      };

  factory NoteModel.fromJson(dynamic data) {
    return NoteModel(
        userid: data["userid"],
        id: data["id"],
        title: data["title"],
        acl: data["acl"],
        description: data["description"]);
  }
}
