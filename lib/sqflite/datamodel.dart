class DataModel {
  final int? id;
  final String title;
  final String subtitle;

  DataModel({this.id, required this.title, required this.subtitle});

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      id: json["id"],
      title: json["title"],
      subtitle: json["subtitle"],
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "subtitle": subtitle,
      };
}
