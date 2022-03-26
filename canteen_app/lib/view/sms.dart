import 'package:flutter/material.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TwilioFlutter twilioFlutter;

  void sendSms() async {
    twilioFlutter = TwilioFlutter(
        accountSid: 'AC0af284e07dd78c2b827ec036ba464315',
        authToken: '388f87fc7fc687da4f6cd9653ba7ab7b',
        twilioNumber: '+19289853180');
    twilioFlutter.sendSMS(toNumber: '+94766807668', messageBody: 'hello world');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('jjj'),
      ),
      body: Center(
        child: Text(
          'Click the button to send SMS.',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: sendSms,
        tooltip: 'Send Sms',
        child: Icon(Icons.send),
      ),
    );
  }
}
