import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vcx_demo/src/presentation/connections/connection_page.widget.dart';
import 'package:flutter_vcx_demo/src/presentation/credentials/bloc/credential_page.cubit.dart';
import 'package:flutter_vcx_demo/src/presentation/credentials/credential_page.widget.dart';
import 'package:flutter_vcx_demo/src/presentation/menu_navigation/bloc/menu_navigation.cubit.dart';
import 'package:flutter_vcx_demo/src/presentation/menu_navigation/bloc/menu_navigation.state.dart';
import 'package:flutter_vcx_demo/src/presentation/menu_navigation/bottom_menu_navigation.widget.dart';
import 'package:flutter_vcx_demo/src/presentation/proofs/proof_page.widget.dart';
import 'package:flutter_vcx_demo/src/presentation/wallet/bloc/wallet_page.cubit.dart';
import 'package:flutter_vcx_demo/src/presentation/wallet/wallet_page.widget.dart';

void main() {
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
                wallet: (_) => BlocProvider<WalletPageCubit>(
                    create: (ctx) => WalletPageCubit(),
                    child: const WalletPageWidget()),
                connection: (_) => ConnectionPageWidget(),
                credential: (_) => BlocProvider<CredentialPageCubit>(
                    create: (ctx) => CredentialPageCubit(),
                    child: const CredentialPageWidget()),
                proof: (_) => const ProofPageWidget());
          }),
        ),
        bottomNavigationBar: const BottomMenuNavigationWidget(),
      ),
    );
  }
}
