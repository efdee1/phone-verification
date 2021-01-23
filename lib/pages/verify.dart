import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:signup_verify/pages/home.dart';

class VerificationScreen extends StatefulWidget {
final  username,phoneNumber;
VerificationScreen({this.username,this.phoneNumber});
  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {

  String verificationId;
  final GlobalKey<ScaffoldState>  _scaffoldkey = GlobalKey<ScaffoldState>();
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: const Color.fromRGBO(43, 46, 66, 1),
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: const Color.fromRGBO(126, 203, 224, 1),
    ),
  );


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/night.jpg'),
              fit: BoxFit.cover,
            )
          ),

          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.all(10),
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  margin: EdgeInsets.all(8),
                  alignment: Alignment.center,
                  child: Center(
                    child: Text('${widget.username}',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  decoration: BoxDecoration(
                    shape:BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(15),
                    ),
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  alignment: Alignment.center,
                  // width: double.infinity,
                  margin: EdgeInsets.all(8),
                  child: Text('${widget.phoneNumber}',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  decoration: BoxDecoration(
                    shape:BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(15),
                    ),
                    color: Colors.white,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(18.0),
                child: PinPut(
                    fieldsCount: 6,
                  textStyle:  TextStyle(fontSize: 25.0, color: Colors.white),
                  eachFieldWidth: 40.0,
                  eachFieldHeight: 55.0,
                  focusNode: _pinPutFocusNode,
                  controller: _pinPutController,
                  submittedFieldDecoration: pinPutDecoration,
                  selectedFieldDecoration: pinPutDecoration,
                  followingFieldDecoration: pinPutDecoration,
                  pinAnimationType: PinAnimationType.slide,
                  onSubmit:(pin) async{
                      try{
                        await FirebaseAuth.instance
                            .signInWithCredential(PhoneAuthProvider.credential(
                            verificationId:verificationId,smsCode: pin))
                            .then((value) => {
                              if (value.user != null){
                            Navigator.pushAndRemoveUntil(
                            context,MaterialPageRoute(builder: (context)=>HomePage()),
                                (route) => false)
                        }
                        });
                      }catch(e){
                        FocusScope.of(context).unfocus();
                        _scaffoldkey.currentState.showSnackBar(SnackBar(content: Text('invalid OTP')));

                      }
                  },
                ),
              )
            ],
          ) ,
        ),
      ),
     );
  }
  _sendVerificationCode() async {
    PhoneCodeSent codeSent = (String verId, [int forceCodeResend]) {
      setState(() {
        verificationId = verId;
      });
    };
    // ignore: non_constant_identifier_names
    PhoneVerificationCompleted verificationSuccess = (PhoneAuthCredential credential) async {
      //_loggedIn();
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) async {
        if (value.user != null) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
                  (route) => false);
        }
      });
    };
    // ignore: non_constant_identifier_names
    PhoneVerificationFailed verificationFail = (FirebaseAuthException e) {
      print(e.message);
    };
    PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout = (String verId) {
      setState(() {
        verificationId = verId;
      });

    };
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '${widget.phoneNumber}',
      codeSent: codeSent,
      verificationCompleted: verificationSuccess,
      verificationFailed: verificationFail,
      codeAutoRetrievalTimeout: autoRetrievalTimeout,
      timeout: Duration(seconds:60),
    );
  }
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
      _sendVerificationCode();
  }
}