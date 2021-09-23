class Album {
  int? id;
  String? name;
  String? htmlUrl;
  String? description;

  Album({required this.id, required this.name, required this.htmlUrl, required this.description});

  Album.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    htmlUrl = json['html_url'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['html_url'] = this.htmlUrl;
    data['description'] = this.description;
    return data;
  }
}
