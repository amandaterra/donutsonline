import 'package:donutsonline/screen/screenInicio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScreenLogin extends StatefulWidget {
  @override
  _ScreenLoginState createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController _email = TextEditingController();
  TextEditingController _senha = TextEditingController();

  Future signInEmailPasswd(String email, String passwd) async {
    try {
      final FirebaseUser user = (await auth.signInWithEmailAndPassword(
              email: email, password: passwd))
          .user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    _email.text = "donuts@gmail.com";
    _senha.text = "123456";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: Text(
          "DonutsOnline",
          style: GoogleFonts.aladin(fontSize: 45),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3.5,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFB71C1C),
                    Color(0xFFB73C1C),
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(100),
                  bottomLeft: Radius.circular(100),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Icon(Icons.person, size: 80, color: Colors.white),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    _texto(_email, "Email"),
                    SizedBox(height: 20),
                    _texto(_senha, "Senha"),
                  ],
                ),
              ],
            ),
            _botaoEntrar(),
            Container(),
          ],
        ),
      ),
    );
  }

  Widget _texto(TextEditingController controller, String label) {
    return Column(
      children: [
        Text(label, style: GoogleFonts.alice(fontSize: 28)),
        SizedBox(height: 13),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: TextField(
            controller: controller,
            obscureText: (label == 'Senha') ? true : false,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _botaoEntrar() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.red[900],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: 5),
          Text("ENTRAR", style: GoogleFonts.alice(fontSize: 20)),
          SizedBox(width: 5),
          Icon(Icons.forward_rounded),
        ],
      ),
      onPressed: () async {
        dynamic resultado = await signInEmailPasswd(_email.text, _senha.text);
        if (resultado != null)
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ScreenInicio()));
      },
    );
  }
}
