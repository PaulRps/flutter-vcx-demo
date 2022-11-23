import 'package:flutter/material.dart';

class ProofAttributeFormFieldWidget extends StatefulWidget {
  ProofAttributeFormFieldWidget({Key? key})
      : _state = _ProofAttributeFormFieldWidgetState(),
        super(key: key);

  final _ProofAttributeFormFieldWidgetState _state;

  @override
  State<ProofAttributeFormFieldWidget> createState() => _state;

  String? get currentSchema {
    return _state._currentSchema;
  }

  String? get currentAttribute {
    return _state._currentAttribute;
  }
}

const List<String?> schemas = [null, "cnh-schema:1.0", "rg-schema:1.0"];
List<DropdownMenuItem<String?>> schemasMenuItem =
    schemas.map<DropdownMenuItem<String?>>((String? value) {
  return DropdownMenuItem<String?>(
    value: value,
    child: Text(value ?? "Select a schema"),
  );
}).toList();

const Map<String, List<String>> schemaAttributesMap = {
  "cnh-schema:1.0": [
    "cpf",
    "registro_geral",
    "doc_emissor",
    "numero_registro",
    "name",
    "primeira_habilitacao",
    "filiacao_mae",
    "data_emissao",
    "filiacao_pai",
    "validade",
    "data_nascimento",
    "expiration"
  ],
  "rg-schema:1.0": [
    "naturalidade",
    "registro_geral",
    "doc_emissor",
    "cpf",
    "nome",
    "data_nascimento",
    "filiacao_mae",
    "data_expedicao",
    "doc_origem",
    "filiacao_pai"
  ]
};

class _ProofAttributeFormFieldWidgetState
    extends State<ProofAttributeFormFieldWidget> {
  List<DropdownMenuItem<String>> _attributesMenuItem = [];
  String? _currentSchema;
  String? _currentAttribute;

  @override
  void initState() => _currentSchema = schemas.first;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: DropdownButtonFormField<String?>(
                value: _currentSchema,
                onChanged: (String? newValue) {
                  setState(() {
                    _currentSchema = newValue;
                    if (_currentSchema != null) {
                      _attributesMenuItem =
                          schemaAttributesMap[_currentSchema!]!
                              .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList();
                      _currentAttribute = _attributesMenuItem.first.value;
                    }
                  });
                },
                items: schemasMenuItem)),
        Container(width: 10.0),
        Expanded(
            child: DropdownButtonFormField<String?>(
                value: _currentAttribute,
                onChanged: (String? newValue) {
                  setState(() {
                    _currentAttribute = newValue;
                  });
                },
                items: _attributesMenuItem))
      ],
    );
  }
}
