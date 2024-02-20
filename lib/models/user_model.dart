class UserModel{
  final String id;
  final String name;
  final String email;
  final String phone;

  UserModel({required this.id, required this.name, required this.email, required this.phone});
  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(id: json['id'], name: json['f_name'], email: json['email'], phone: json['phone']);
  }

}