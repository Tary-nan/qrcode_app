class User {
  final int id;
  final String email;
  final String contact;
  final String genre;
  final String specialite;
  final String username;
  final String image;
  final String password;
  final bool userIsSuperuser;

  User(
      {this.id,
      this.contact,
      this.username,
      this.genre,
      this.email,
      this.specialite,
      this.image,
      this.password,
      this.userIsSuperuser,
      });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'],
        contact: json["contacts"] ?? 'inconnu',
        username: json["user__username"] ?? 'inconnu',
        genre: json["genre"] ?? 'inconnu',
        email: json["user__email"] ?? 'inconnu',
        specialite: json["specialite"] ?? 'inconnu',
        image: json["image"],
        userIsSuperuser: json["user__is_superuser"] == null ? null : json["user__is_superuser"],
      );

  Map<String, dynamic> toJson() {
    return {
      "contacts": contact,
      "user__username": username,
      "genre": genre,
      "user__email": email,
      "specialite": specialite,
      "image": image,
      "user__is_superuser": userIsSuperuser,
    };
  }
}
