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

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final StartAriesSdkFormWidget _ariesSdkFormWidget = StartAriesSdkFormWidget();
  final CreateAriesConnectionFormWidget _ariesConnectionFormWidget =
      CreateAriesConnectionFormWidget();
  final AcceptCredentialOfferFormWidget _acceptCredentialOfferFormWidget =
      AcceptCredentialOfferFormWidget();
  final ProofRequestFormWidget _presentProofRequestFormWidget =
      ProofRequestFormWidget();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
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
          // body: Center(
          //   child: IndexedStack(
          //     index: _selectedIndex,
          //     children: _pages,
          //   ),
          // ),
          // bottomNavigationBar: BottomNavigationBar(
          //   currentIndex: _selectedIndex,
          //   //New
          //   onTap: (index) {
          //     setState(() {
          //       _selectedIndex = index;
          //     });
          //   },
          //   selectedFontSize: 20,
          //   selectedIconTheme:
          //       const IconThemeData(color: Colors.amberAccent, size: 40),
          //   selectedItemColor: Colors.amberAccent,
          //   selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          //   backgroundColor: Colors.blueAccent,
          //   items: const <BottomNavigationBarItem>[
          //     BottomNavigationBarItem(
          //       icon: Icon(Icons.call),
          //       label: 'Calls',
          //     ),
          //     BottomNavigationBarItem(
          //       icon: Icon(Icons.camera),
          //       label: 'Camera',
          //     ),
          //     BottomNavigationBarItem(
          //       icon: Icon(Icons.chat),
          //       label: 'Chats',
          //     ),
          //   ],
          // )
        ));
  }
}
