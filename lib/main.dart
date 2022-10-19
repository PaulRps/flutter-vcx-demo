import 'package:flutter/material.dart';
import 'package:flutter_vcx_demo/src/presentation/accept_credential_offer_form/accept_credential_offer_form.widget.dart';
import 'package:flutter_vcx_demo/src/presentation/create_aries_connection_form/create_aries_connection_form.widget.dart';
import 'package:flutter_vcx_demo/src/presentation/proof_request_form/proof_request_form.widget.dart';
import 'package:flutter_vcx_demo/src/presentation/start_aries_sdk_form/start_aries_sdk_form.widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter VCX Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final StartAriesSdkFormWidget _ariesSdkFormWidget = StartAriesSdkFormWidget();
  final CreateAriesConnectionFormWidget _ariesConnectionFormWidget =
      const CreateAriesConnectionFormWidget();
  final AcceptCredentialOfferFormWidget _acceptCredentialOfferFormWidget =
      AcceptCredentialOfferFormWidget();
  final ProofRequestFormWidget _presentProofRequestFormWidget =
      ProofRequestFormWidget();

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Text(widget.title),
          ),
          body: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: SingleChildScrollView(
              child: Column(
                // Column is also a layout widget. It takes a list of children and
                // arranges them vertically. By default, it sizes itself to fit its
                // children horizontally, and tries to be as tall as its parent.
                //
                // Invoke "debug painting" (press "p" in the console, choose the
                // "Toggle Debug Paint" action from the Flutter Inspector in Android
                // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
                // to see the wireframe for each widget.
                //
                // Column has various properties to control how it sizes itself and
                // how it positions its children. Here we use mainAxisAlignment to
                // center the children vertically; the main axis here is the vertical
                // axis because Columns are vertical (the cross axis would be
                // horizontal).
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  ExpansionTile(
                    initiallyExpanded: true,
                    trailing: const SizedBox.shrink(),
                    title: const Text("SDK"),
                    children: [_ariesSdkFormWidget],
                  ),
                  ExpansionTile(
                    initiallyExpanded: true,
                    trailing: const SizedBox.shrink(),
                    title: const Text("Connection"),
                    children: [_ariesConnectionFormWidget],
                  ),
                  ExpansionTile(
                      initiallyExpanded: true,
                      trailing: const SizedBox.shrink(),
                      title: const Text("Credential"),
                      children: [_acceptCredentialOfferFormWidget]),
                  ExpansionTile(
                    initiallyExpanded: true,
                    trailing: const SizedBox.shrink(),
                    title: const Text("Proof"),
                    children: [_presentProofRequestFormWidget],
                  )
                ],
              ),
            ),
          ),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: _incrementCounter,
          //   tooltip: 'Increment',
          //   child: const Icon(Icons.add),
          // ), // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}
