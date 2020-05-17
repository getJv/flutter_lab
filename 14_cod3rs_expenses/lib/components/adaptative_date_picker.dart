import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeDatePickr extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onChangeDate;

  const AdaptativeDatePickr({this.selectedDate, this.onChangeDate});

  _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      onChangeDate(pickedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Container(
            height: 180,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime.now(),
              minimumDate: DateTime(2019),
              maximumDate: DateTime.now(),
              onDateTimeChanged: onChangeDate,
            ),
          )
        : Container(
            height: 70,
            child: Row(children: <Widget>[
              Expanded(
                child: Text(
                  selectedDate == null
                      ? "nenhuma data selecionada"
                      : 'Data selecionada: ${DateFormat('dd/MM/y').format(selectedDate)}',
                ),
              ),
              FlatButton(
                textColor: Theme.of(context).primaryColor,
                child: Text(
                  'Selecionar Data',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () => _showDatePicker(context),
              )
            ]),
          );
  }
}
