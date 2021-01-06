import 'package:eat_well_v1/widgets/misc/icon_text.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../tools.dart';

class EditProductForm extends StatefulWidget {
  final double initAmount;
  final String initUnit;
  final DateTime initDate;

  EditProductForm({this.initAmount, this.initUnit, this.initDate});

  @override
  _EditProductFormState createState() => _EditProductFormState();
}

class _EditProductFormState extends State<EditProductForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _amountController = TextEditingController();
  String _selectedUnit;
  DateTime _selectedDate;

  @override
  void initState() {
    if (widget.initAmount != null) _amountController.text = '${widget.initAmount}';
    _selectedUnit = widget.initUnit ?? '';
    if (widget.initDate != null) _selectedDate = widget.initDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _getAmountAndExpDateFields(),
        const SizedBox(height: 16),
        _getSaveButton(),
        const SizedBox(height: 16),
        Divider(),
        const SizedBox(height: 16),
        _getRemoveButton(),
      ],
    );
  }

  Widget _getAmountAndExpDateFields() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    validator: (val) => val.isEmpty
                        ? 'Enter the amount.'
                        : double.tryParse(val) == null
                            ? 'Incorrect value.'
                            : null,
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Amount',
                      contentPadding: const EdgeInsets.only(left: 12, right: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 1,
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 12, right: 6),
                    ),
                    icon: Icon(Icons.arrow_downward_rounded, size: 20),
                    value: _selectedUnit,
                    items: kUnits
                        .map(
                          (String value) => DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedUnit = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            if(widget.initDate != null) const SizedBox(height: 16),
            if(widget.initDate != null) RaisedButton(
              child: Text(
                'Select expiry date',
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(DateTime.now().year + 100),
                ).then((selectedDate) {
                  setState(() {
                    _selectedDate = selectedDate;
                  });
                });
              },
              color: kAccentColor,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            ),
            if (_selectedDate != null) const SizedBox(height: 16),
            if (_selectedDate != null)
              Text(
                'Expiry date selected: ${Tools.getDate(_selectedDate)}',
                style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }

  Widget _getSaveButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        RaisedButton(
          color: kPrimaryColorLight,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              Navigator.pop(context);
            }
          },
          child: Text(
            'Cancel',
            style: TextStyle(fontSize: 16),
          ),
        ),
        RaisedButton(
          color: kPrimaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              Navigator.pop(
                context,
                [
                  double.parse(_amountController.text),
                  _selectedUnit,
                  _selectedDate,
                ],
              );
            }
          },
          child: Text(
            'Save',
            style: TextStyle(fontSize: 22),
          ),
        ),
      ],
    );
  }

  Widget _getRemoveButton() {
    return RaisedButton(
      color: Colors.redAccent,
      child: IconText(
        text: Text(
          'Remove',
          style: TextStyle(fontSize: 18),
        ),
        icon: Icon(Icons.delete_rounded, size: 20),
        squeeze: true,
      ),
      onPressed: () {
        Navigator.pop(
          context,
          ['remove'],
        );
      },
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }
}
