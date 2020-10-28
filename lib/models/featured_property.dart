class FeaturedProperty {
  int id;
  String name;
  String location;
  String description;
  String image;
  String link;
  DateTime datetime;

  FeaturedProperty({
    this.id,
    this.name,
    this.location,
    this.description,
    this.image,
    this.link,
    this.datetime,
  });

  factory FeaturedProperty.fromJson(Map<String, dynamic> json) {
    return FeaturedProperty(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      description: json['description'],
      image: json['image'],
      link: json['link'],
      datetime: json['datetime'],
    );
  }

  dynamic toJson() => {
        'id': id,
        'name': name,
        'location': location,
        'description': description,
        'image': image,
        'link': link,
        'datetime': datetime,
      };
}
