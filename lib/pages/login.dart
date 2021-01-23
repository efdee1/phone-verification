import 'package:flutter/material.dart';
import 'package:signup_verify/pages/verify.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController usernameController;
  TextEditingController phoneNumberController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    usernameController = TextEditingController(text: '');
    phoneNumberController = TextEditingController(text: '');

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:<Widget>[
            Text("Auth",
              style: TextStyle(
                  color: Colors.black,
                fontSize: 25,
              ),
            ),
            Text("Kit",
              style: TextStyle(
                  color: Colors.purple,
                fontSize: 25,
              ),
            )
          ],
        ),
        elevation: 0.0,
      ),
      body:Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/purple.jpg'),
                        fit: BoxFit.cover
                    )
                ),
        child: Form(
          key: _key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8.0,8,8,8),
                    child: TextFormField(
                      validator: (String  value){
                        if (value == null || value.isEmpty)
                          return "username cannot be empty";
                        else
                          return null;
                      },
                      style: TextStyle(
                        color: Colors.white,
                        fontSize:25,
                      ),

                      controller: usernameController,
                      textAlign: TextAlign.center,
                      autocorrect: true,
                      decoration: InputDecoration(
                        hintText: 'username',
                        hintStyle: TextStyle(
                        fontSize: 18,
                          color: Colors.grey,
                      ),
                        prefixIcon: Icon(Icons.perm_identity_outlined,
                          color: Colors.black,
                          size: 36,
                        ),
                       // hintStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.transparent,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          borderSide: BorderSide(color: Colors.black, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(color: Colors.black26,width: 2),
                        ),
                      ),
                    ),
                  ),
                ),
              ),



              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: TextFormField(
                    controller: phoneNumberController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (String  value){
                      if (value.length < 14)
                       return "add +234";
                      else
                        return null;
                    },
                    style: TextStyle(
                      color: Colors.white,
                      fontSize:25,
                    ),
                    keyboardType: TextInputType.phone,
                    maxLength:14 ,
                    textAlign: TextAlign.center,
                    decoration:InputDecoration(
                        hintText: 'Phone Number ',
                      labelText: 'Phone number(+xxx xxx-xxx-xxxx)',
                      //errorText: _numberError,
                      hintStyle: TextStyle(
                        fontSize: 18,
                          color: Colors.grey
                      ),
                      prefixIcon: Icon(Icons.phone_in_talk_rounded,
                        color: Colors.black,
                        size: 36,
                      ),
                      filled: true,
                      fillColor: Colors.transparent,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        borderSide: BorderSide(color: Colors.black, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(color: Colors.black26,width: 2),
                      ),
                    ) ,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color:Colors.black,width: 2)
                  ),
                  color: Colors.transparent,
                  onPressed: (){
                    if (_key.currentState.validate()){
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=>VerificationScreen(phoneNumber:phoneNumberController.text , username:usernameController.text))
                      );
                    }
                  },
                  child: Text('Next',style:
                    TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.purple[200]
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),

    );
  }
}
