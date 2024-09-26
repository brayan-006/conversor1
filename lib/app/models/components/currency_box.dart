import 'package:conversor/app/models/currency_model.dart';
import 'package:flutter/material.dart';

class CurrencyBox extends StatefulWidget {
  final List<CurrencyModel> items;
  final CurrencyModel selectedItem;
  final TextEditingController controller;
  final void Function(CurrencyModel model) onChanged;

  const CurrencyBox({
    Key? key,
    required this.items,
    required this.controller,
    required this.onChanged,
    required this.selectedItem,
  }) : super(key: key);

  @override
  _CurrencyBoxState createState() => _CurrencyBoxState();
}

class _CurrencyBoxState extends State<CurrencyBox> {
  String? selectedCurrency;

  @override
  void initState() {
    super.initState();
    selectedCurrency = widget.selectedItem.name; // Usa o nome do item selecionado
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SizedBox(
            height: 56,
            child: DropdownButton<String>(
              iconEnabledColor: Colors.amber,
              isExpanded: true,
              value: selectedCurrency, // Usar selectedCurrency aqui
              underline: Container(
                height: 1,
                color: Colors.amber,
              ),
              items: widget.items.map((currency) {
                return DropdownMenuItem<String>(
                  value: currency.name,
                  child: Text(currency.name),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedCurrency = newValue;
                  widget.onChanged(widget.items.firstWhere(
                      (element) => element.name == newValue)); // Passa o CurrencyModel correto
                });
              },
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 2,
          child: TextField(
            controller: widget.controller,
            decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.amber),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.amber),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
