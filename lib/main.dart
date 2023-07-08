import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vcx_demo/src/menu/ui/widgets/bottom_menu_navigation.widget.dart';

import 'injection.dart';
import 'src/connections/connections.dart';
import 'src/credentials/credentials.dart';
import 'src/menu/menu.dart';
import 'src/proofs/proofs.dart';
import 'src/wallet/wallet.dart';

Future<void> main() async {
  configureInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter VCX Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
          create: (ctx) => MenuNavigationCubit(),
          child: const MyHomePage(title: 'Flutter VCX Demo')),
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
        body: SingleChildScrollView(
          child: BlocBuilder<MenuNavigationCubit, MenuNavigationState>(
              builder: (context, state) {
            return state.when(
                wallet: (_) => BlocProvider(
                    create: (ctx) => locator<WalletPageCubit>(),
                    child: const WalletPage()),
                connection: (_) => BlocProvider(
                    create: (ctx) => locator<ConnectionPageCubit>(),
                    child: const ConnectionPage()),
                credential: (_) => BlocProvider(
                    create: (ctx) => locator<CredentialPageCubit>(),
                    child: const CredentialPage()),
                proof: (_) => BlocProvider(
                    create: (ctx) => locator<ProofPageCubit>(),
                    child: const ProofPage()));
          }),
        ),
        bottomNavigationBar: const BottomMenuNavigationWidget(),
      ),
    );
  }
}
