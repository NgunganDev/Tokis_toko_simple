import 'package:hive_flutter/hive_flutter.dart';
part 'profile.g.dart';
@HiveType(typeId: 4)
class Profile {
  @HiveField(0)
  final String profileName;
  @HiveField(1)
  final String profilAddress;
  @HiveField(2)
  final String profilPhoto;
  @HiveField(3)
  final String profilcategory;
  @HiveField(4)
  final DateTime updateAt;
  Profile(
      {required this.profilAddress,
      required this.profilPhoto,
      required this.profilcategory,
      required this.profileName,
      required this.updateAt});
}
