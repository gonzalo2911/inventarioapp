import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inventario/HomePage/HomePage.dart';

class LoginPage extends StatefulWidget{
  @override
  State createState(){
    return _LoginState();
  }
}

class _LoginState extends State<LoginPage>{

  late String email, password;
  final _formKey = GlobalKey<FormState>();
  String error='';

  @override
  void initState(){
    super.initState();
  }
  @override
Widget build(BuildContext context){
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        Text("APP INVENTARIO",style: TextStyle(color: Colors.black,fontSize: 20),),
          Offstage(
            offstage: error =='',
            child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("error",style: TextStyle(color: Colors.red, fontSize: 24),),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: formulario(),
          ),
          butonLogin(),
        ],
      ),
    );

  }

  Widget formulario(){
    return Form(
      key: _formKey,
        child: Column(children: [
        buildEmail(),
        const Padding(padding: EdgeInsets.only(top: 12)),
        buildPassword(),
        ],)
    );
  }

  Widget buildEmail(){
    return TextFormField(
      decoration: InputDecoration(
        label: Text("ejemplo@gmail.com"),
        border: OutlineInputBorder(
          borderRadius: new BorderRadius.circular(8),
          borderSide: new BorderSide(color: Colors.black)
        )
      ),
      keyboardType: TextInputType.emailAddress,
      onSaved: (String? value){
        email = value!;
      },
      validator: (value){
        if(value!.isEmpty){
          return "este campo es obligatorio";
        }
        return null;
      },
    );
  }

  Widget buildPassword(){
    return TextFormField(
      decoration: InputDecoration(
        label: Text('Contraseña'),
          border: OutlineInputBorder(
              borderRadius: new BorderRadius.circular(8),
              borderSide: new BorderSide(color: Colors.black)
          )
      ),
      obscureText: true,
      validator: (value){
        if(value!.isEmpty){
          return "este campo es obligatorio";
        }
        return null;
      },

      onSaved: (String? value){
        password = value!;
      },
    );
  }

  Widget butonLogin(){
    return FractionallySizedBox(
      widthFactor: 0.6,
      child: ElevatedButton(onPressed:() async{
        if(_formKey.currentState!.validate()){
          _formKey.currentState!.save();
          UserCredential? credenciales = await login(email, password);
          if(credenciales !=null){
            if(credenciales !=null){
              if(credenciales.user!.emailVerified){
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MyHomePage()), (route) => false);
              }
              else{
              setState(() {
                error = "Verificar Correo";
              });
              }
            }
          }
        }
      }, child: Text("Ingresar",style: TextStyle(color: Colors.black,fontSize: 20),)),
    );
  }

  Future<UserCredential?> login(String email, String password) async{
    try{
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email,
        password: password);
    return userCredential;

    }on FirebaseAuthException catch(e){
      if(e.code == 'user-not-found'){
      setState(() {
        error = "Usuario no encontrado";
      });
      }

      if(e.code == "wrong-password"){
        setState(() {
          error = "Contraseña Incorrecta";
        });
      }
    }
  }
}