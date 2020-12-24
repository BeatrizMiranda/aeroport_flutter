import 'package:airport/components/button.dart';
import 'package:airport/globals/pallets.dart';
import 'package:flutter/material.dart';

class PassangersPicker extends StatefulWidget {
  PassangersPicker({Key key, this.adults, this.childs}) : super(key: key);

  final int adults;
  final int childs;

  _PassangersPicker createState() => _PassangersPicker();
}

class _PassangersPicker extends State<PassangersPicker> {
  int _adults = 0;
  int _child = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      _adults = widget.adults;
      _child = widget.childs;
    });
  }

  void stepAdults(int qtd) {
    setState(() {
      if(_adults + qtd >= 0) {
        _adults = _adults + qtd;
      }
    });
  }

  void stepChils(int qtd) {
    setState(() {
      if(_child + qtd >= 0) {
        _child = _child + qtd;
      }
    });
  }

  void handleSubmit() {
    Navigator.pop(context, {
      "Adult": _adults,
      "Child": _child
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      backgroundColor: Palette.background,
    );
  }

  Widget _body() {
    return Stack(children: <Widget>[
      ClipRRect(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
        child: Image.asset("src/img/SearchImg.png",
            fit: BoxFit.cover, height: 325),
      ),
      Center(
        child: SingleChildScrollView(
          child: Positioned(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _card(),
              ],
            ),
          ),
        ),
      ),
    ]);
  }

  Widget _card() {
    return Card(
      margin: EdgeInsets.fromLTRB(15, 10, 20, 20),
      elevation: 10,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                  onPressed: handleSubmit,
                  icon: Icon(Icons.close, size: 30)),
            ),
            Text("Opções de Voo",
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
                color: Palette.lightBlack
              )
            ),
            Padding(
              padding: EdgeInsets.only(top: 70, bottom: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Adultos",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Palette.lightBlack
                        )
                      ),
                      Text("A partir de 13 anos",
                        style: TextStyle(
                          fontSize: 15,
                          color: Palette.lightBlack
                        )
                      ),
                    ],
                  ),
                  QtdStepper(value: _adults, functionToChange: stepAdults),
                ],
              ),
            ),
              Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Crianças",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Palette.lightBlack
                      )
                    ),
                    Text("Até 12 anos",
                      style: TextStyle(
                        fontSize: 15,
                        color: Palette.lightBlack
                      )
                    ),
                  ],
                ),
                QtdStepper(value: _child, functionToChange: stepChils),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 80, bottom: 50),
              child: CustomButton(
                  height: 60,
                  text: "Salvar",
                  onClick: handleSubmit),
            ),
          ],
        ),
      ),
    );
  }
}

class QtdStepper extends StatelessWidget {
  const QtdStepper({
    Key key,
    this.value,
    this.functionToChange
  }) : super(key: key);

  final int value;
  final Function functionToChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        border:  Border.all(
          width: 1, color: Palette.lightBlue
        ),
      ),
      child: Row(
        children: [
          RawMaterialButton(
            constraints: BoxConstraints.tightFor(width: 35, height: 35),
            elevation: 6.0,
            onPressed: () => functionToChange(-1),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35*0.2)),
            child: Icon(
              Icons.remove,
              color: Palette.lightBlack,
              size: 30 * 0.8,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(width: 1, color: Palette.lightBlack),
                right: BorderSide(width: 1, color: Palette.lightBlack),
              ),
            ),
            width: 70,
            child: Text(
              '$value',
              style: TextStyle(
                fontSize: 30 * 0.8,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          RawMaterialButton(
            constraints: BoxConstraints.tightFor(width: 35, height: 35),
            elevation: 6.0,
            onPressed: () => functionToChange(1),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35*0.2)),
            child: Icon(
              Icons.add,
              color: Palette.lightBlack,
              size: 30 * 0.8,
            ),
          ),
        ],
      ),
    );
  }
}
