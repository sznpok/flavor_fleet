
import 'package:flaviourfleet/features/auth/domain/entity/auth_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_current_user_dto.g.dart';

@JsonSerializable()
class GetCurrentUserDto {
  @JsonKey(name:"_id")
  final String id;
  final String fname;
  final String lname;
  final String address;
  // final String image;
  // final String username;
  final String  email;
  // final String batch;
  // final List<String> course;

  GetCurrentUserDto({
    required this.id,
    required this.fname,
    required this.lname,
    required this.address,
    // required this.image,
    // required this.username,
    required this.email,
    // required this.batch,
    // required this.course,
  });

  AuthEntity toEntity() {
    return AuthEntity(
        id: id,
        fname: fname,
        lname: lname,
        // image: image,
        address: address,
        // batch: BatchEntity(batchId: id, batchName: ''),
        // courses:  course.map((course) {
        //   return CourseEntity( courseId: course, courseName: '');
        // }).toList() ,
        email: email,
        // username: username,
        password: '');
  }

  factory GetCurrentUserDto.fromJson(Map<String, dynamic> json) =>
      _$GetCurrentUserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetCurrentUserDtoToJson(this);
}
