class User {
  final int id;
  final String title;
  final String image;
  final String profile;

  User({
    this.id,
    this.title,
    this.image,
    this.profile,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      title: json['title'],
      image: json['url'],
      profile: json['thumbnailUrl'],
    );
  }
}
