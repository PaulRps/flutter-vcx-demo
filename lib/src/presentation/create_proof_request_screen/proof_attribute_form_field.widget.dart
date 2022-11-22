import 'package:flutter/material.dart';

class ProofAttributeFormFieldWidget extends StatefulWidget {
  ProofAttributeFormFieldWidget({Key? key}) : super(key: key);

  String? currentSchema;
  String? currentAttribute;

  @override
  State<ProofAttributeFormFieldWidget> createState() =>
      _ProofAttributeFormFieldWidgetState();
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

  @override
  void initState() => widget.currentSchema = schemas.first;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: DropdownButtonFormField<String?>(
                value: widget.currentSchema,
                onChanged: (String? newValue) {
                  setState(() {
                    widget.currentSchema = newValue;
                    if (widget.currentSchema != null) {
                      _attributesMenuItem =
                          schemaAttributesMap[widget.currentSchema!]!
                              .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList();
                      widget.currentAttribute = _attributesMenuItem.first.value;
                    }
                  });
                },
                items: schemasMenuItem)),
        Container(width: 10.0),
        Expanded(
            child: DropdownButtonFormField<String?>(
                value: widget.currentAttribute,
                onChanged: (String? newValue) {
                  setState(() {
                    widget.currentAttribute = newValue;
                  });
                },
                items: _attributesMenuItem))
      ],
    );
  }
}
