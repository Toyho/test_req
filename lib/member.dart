class Member {
  final int id;
  final String name;
  final String location;
  final bool online;
  final bool placeType;

  Member(this.id, this.name, this.location, this.online, this.placeType);

  Member.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        location = json['location'],
        online = json['online'],
        placeType = json['placeType'];
}