import 'dart:convert';

class Court {
    String name;
    String image;
    String id;

    Court({
        required this.name,
        required this.image,
        required this.id,
    });

    Court copyWith({
        String? name,
        String? image,
        String? id,
    }) => 
        Court(
            name: name ?? this.name,
            image: image ?? this.image,
            id: id ?? this.id,
        );

    factory Court.fromRawJson(String str) => Court.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Court.fromJson(Map<dynamic, dynamic> json) => Court(
        name: json["name"],
        image: json["image"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
        "id": id,
    };
}