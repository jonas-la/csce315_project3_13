
class employee{

  late int id;
  late String name;
  late String email;
  late String role;
  late String uid;
  late double hourly_rate;

  employee.defaultConstructor(){
    this.id = 0;
    this.name = "";
    this.email = "";
    this.role = "";
    this.uid = "";
    this.hourly_rate = 0.0;
  }

  employee({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.uid,
    required this.hourly_rate,
  });
}