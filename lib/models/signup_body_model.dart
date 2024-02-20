class SignUpBody {
  final String name;
  final String phone;
  final String email;
  final String password;

  SignUpBody({required this.name, required this.phone, required this.email, required this.password});

  Map<String, dynamic> toJson(){
  final Map<String, dynamic> data={
    'f_name':name,
    'phone':phone,
    'email':email,
    'password':password
  };
  return data;

}

}