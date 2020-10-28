class BlogPost {
  int id;
  String slug;
  String title;
  int category;
  String content;
  String date;
  String main_image;
  String image1;
  String image2;
  String image3;
  String image4;
  String courtesy_title;
  String courtesy_url;

  BlogPost({
    this.id,
    this.slug,
    this.title,
    this.category,
    this.content,
    this.date,
    this.main_image,
    this.image1,
    this.image2,
    this.image3,
    this.image4,
    this.courtesy_title,
    this.courtesy_url,
  });

  factory BlogPost.fromJson(Map<String, dynamic> json) {
    return BlogPost(
      id: json['id'],
      slug: json['slug'],
      title: json['title'],
      category: json['category'],
      content: json['content'],
      date: json['date'],
      main_image: json['main_image'],
      image1: json['image1'],
      image2: json['image2'],
      image3: json['image3'],
      image4: json['image4'],
      courtesy_title: json['courtesy_title'],
      courtesy_url: json['courtesy_url'],
    );
  }

  dynamic toJson() => {
        'id': id,
        'slug': slug,
        'title': title,
        'category': category,
        'content': content,
        'date': date,
        'main_image': main_image,
        'image1': image1,
        'image2': image2,
        'image3': image3,
        'image4': image4,
        'courtesy_title': courtesy_title,
        'courtesy_url': courtesy_url,
      };
}
