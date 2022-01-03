import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:user/models/user.dart';

const darkBlueColor = Color(0xff486579);

class MyForm extends StatefulWidget {
  final User user;
  MyForm({Key? key, required this.user}) : super(key: key);
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  int idController = 0;

  @override
  void initState() {
    super.initState();
    nameController.text = this.widget.user.name!;
    emailController.text = this.widget.user.email!;
    passwordController.text = this.widget.user.password!;
    idController = this.widget.user.id!;
  }

  final _formKey = GlobalKey<FormState>();
  List<User> _users = [];
  User _user = User();
  final apiUrl = Uri.parse('http://10.0.2.2:8000/user');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('form'),
        foregroundColor: darkBlueColor,
        backgroundColor: Colors.white,
      ),
      body: formBody(),
    );
  }

  Container formBody() {
    return Container(
      color: Colors.grey[200],
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Form(
        key: _formKey,
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: '  name'),
                controller: nameController,
                onSaved: (val) => setState(() => _user.name = val!),
                validator: (val) =>
                    (val!.length == 0 ? 'this field is required' : null),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: '  email'),
                controller: emailController,
                onSaved: (val) => setState(() => _user.email = val!),
                validator: (val) =>
                    (val!.length < 11 ? 'email not valide' : null),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: '  password'),
                onSaved: (val) => setState(() => _user.password = val!),
                controller: passwordController,
                validator: (val) =>
                    (val!.length < 3 ? 'password at least 4 caracters' : null),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: RaisedButton(
                  onPressed: () => _onSubmit(),
                  child: Text('Submit'),
                  color: darkBlueColor,
                  textColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onSubmit() {
    var form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      String name = nameController.text;
      String email = emailController.text;
      String password = passwordController.text;
      if (idController != 0) {
        updateUser(
            User(
                id: idController,
                name: name,
                email: email,
                password: password,
                is_Active: true),
            );
      } else {
        createUser(
          User(name: name, email: email, password: password, is_Active: true),
        );
      }
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
    }
  }

  Future<User> createUser(User user) async {
    final Response response = await post(
      apiUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );
    if (response.statusCode == 201) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create user');
    }
  }

  Future<String> updateUser(User user) async {
    final Response response = await put(Uri.parse('${apiUrl}/${idController}')
      ,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );
    if (response.statusCode == 202) {
      return 'user updated';
    } else {
      throw Exception('Failed to update user');
    }
  }
}
