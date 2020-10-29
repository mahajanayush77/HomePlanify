class InvestProperty {
  int id;
  String title;
  String label;
  String description;
  String image;
  String link;
  DateTime datetime;

  InvestProperty({
    this.id,
    this.title,
    this.label,
    this.description,
    this.image,
    this.link,
    this.datetime,
  });

  factory InvestProperty.fromJson(Map<String, dynamic> json) {
    return InvestProperty(
      id: json['id'],
      title: json['title'],
      label: json['label'],
      description: json['description'],
      image: json['image'],
      link: json['link'],
      datetime: json['datetime'],
    );
  }

  dynamic toJson() => {
        'id': id,
        'title': title,
        'label': label,
        'description': description,
        'image': image,
        'link': link,
        'datetime': datetime,
      };
}
