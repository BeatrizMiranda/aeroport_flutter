import 'package:airport/components/button.dart';
import 'package:airport/globals/pallets.dart';
import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_datepicker/datepicker.dart';


class DatePicker extends StatefulWidget {
  DatePicker({Key key, this.initialDate }) : super(key: key);

  final DateTime initialDate;
  
  _DatePicker createState() => _DatePicker();
}
class _DatePicker extends State<DatePicker> {

  var _chosedData = DateRangePickerController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      backgroundColor: Palette.background,
    );
  }

  Widget _body() { 
    return Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.only(bottomLeft:  Radius.circular(15), bottomRight:  Radius.circular(15)),
            child: Image.asset(
              "src/img/SearchImg.png",
              fit: BoxFit.cover,
              height: 650
            ),
          ),
          Positioned(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _card(),
              ],
            ),
          ),
        ]
      );
  }

  Widget _card() { 
    return Card(
      margin: EdgeInsets.fromLTRB(15, 20, 20, 20),
      elevation: 10,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(25),
        child: Center(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () => Navigator.pop(context, _chosedData),
                  icon: Icon(Icons.close, size: 30)
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Text("Selecione sua data", style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold, color: Palette.lightBlack)),
              ),
              calendar(),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: CustomButton(
                  height: 60, 
                  text: "Salvar", 
                  onClick: () => Navigator.pop(context, _chosedData)
                ),
              ),
            ],
          ) ,
        ),
      ),
    );
  }

  Widget calendar() {
    print(widget.initialDate);
    return SfDateRangePicker(
      controller: _chosedData,
      enablePastDates : false,
      showNavigationArrow: true,
      view: DateRangePickerView.month,
      selectionColor: Palette.darkOrange,
      initialSelectedDate: widget.initialDate,
      headerStyle: DateRangePickerHeaderStyle(
        textStyle: TextStyle(fontSize: 22, color: Palette.lightBlack),
      ),
      rangeTextStyle: const TextStyle(fontSize: 25),
      selectionTextStyle: TextStyle(fontSize: 20, color: Colors.white),
      monthViewSettings: DateRangePickerMonthViewSettings(dayFormat: 'EEE'),
      monthCellStyle: DateRangePickerMonthCellStyle(
        textStyle: TextStyle(fontSize: 22, color: Palette.lightBlack),
        todayTextStyle: TextStyle(fontSize: 22, color: Palette.lightBlack),
        todayCellDecoration: BoxDecoration(border: Border()),
        disabledDatesTextStyle: TextStyle(fontSize: 20, color: Colors.grey[500]),
      ),
    );
  }
}