import 'package:flutter/material.dart';
import 'package:housing/constant.dart';
import 'package:housing/widgets/bottom_bar.dart';
import 'package:intl/intl.dart';

class AddProperty extends StatefulWidget {
  static const routeName = 'addProperty';
  @override
  _AddPropertyState createState() => _AddPropertyState();
}

class _AddPropertyState extends State<AddProperty> {
  var _type = [
    "Buy",
    "Sell",
    "Rent",
  ];
  var _status = [
    "Ready to Move",
    "Under Construction",
  ];
  int room = 0;
  int bedroom = 0;
  int bathroom = 0;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController cityCtl = TextEditingController();
  final TextEditingController dateCtl = TextEditingController();
  final TextEditingController fDateCtl = TextEditingController();
  final TextEditingController titleCtl = TextEditingController();
  final TextEditingController priceCtl = TextEditingController();
  final TextEditingController areaCtl = TextEditingController();
  final TextEditingController descCtl = TextEditingController();
  final TextEditingController shiftTimeCtl = TextEditingController();
  String _typeValue;
  String _statusValue;
  @override
  Widget build(BuildContext context) {
    var myFormat = DateFormat('yyyy-MM-dd');
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryBackgroundColor,
        title: Text('Add Property'),
      ),
      bottomNavigationBar: bottom_bar(1),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: titleCtl,
                keyboardType: TextInputType.text,
                style: TextStyle(height: 1.0),
                decoration: InputDecoration(
                  labelText: 'Property Title',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                ),
              ),
              SizedBox(
                height: 18.0,
              ),
              TextFormField(
                controller: priceCtl,
                keyboardType: TextInputType.number,
                style: TextStyle(height: 1.0),
                decoration: InputDecoration(
                  labelText: 'Price',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                ),
              ),
              SizedBox(
                height: 18.0,
              ),
              FormField<String>(
                builder: (FormFieldState<String> state) {
                  return InputDecorator(
                    decoration: InputDecoration(
                        labelText: 'Type',
                        prefixText: _typeValue == null ? 'Select' : '',
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0))),
                    isEmpty: _typeValue == '',
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _typeValue,
                        isDense: true,
                        onChanged: (String newValue) {
                          setState(() {
                            _typeValue = newValue;
                            state.didChange(newValue);
                          });
                        },
                        items: _type.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 18.0,
              ),
              TextFormField(
                controller: areaCtl,
                keyboardType: TextInputType.number,
                style: TextStyle(height: 1.0),
                decoration: InputDecoration(
                  labelText: 'Area (In sq m)',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                ),
              ),
              SizedBox(
                height: 18.0,
              ),
              TextFormField(
                controller: descCtl,
                keyboardType: TextInputType.datetime,
                style: TextStyle(height: 1.0),
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                ),
              ),
              SizedBox(
                height: 18.0,
              ),
              FormField<String>(
                builder: (FormFieldState<String> state) {
                  return InputDecorator(
                    decoration: InputDecoration(
                        labelText: 'Construction Status',
                        prefixText: _statusValue == null ? 'Select' : '',
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0))),
                    isEmpty: _statusValue == '',
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _statusValue,
                        isDense: true,
                        onChanged: (String newValue) {
                          setState(() {
                            _statusValue = newValue;
                            state.didChange(newValue);
                          });
                        },
                        items: _status.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 18.0,
              ),
              TextFormField(
                keyboardType: TextInputType.datetime,
                controller: dateCtl,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(Icons.date_range),
                    iconSize: 20.0,
                    onPressed: () async {
                      DateTime date = DateTime(1900);
                      FocusScope.of(context).requestFocus(new FocusNode());

                      date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2050));

                      dateCtl.text = myFormat.format(date);
                    },
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                  border: OutlineInputBorder(
                    // width: 0.0 produces a thin "hairline" border
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    //borderSide: const BorderSide(),
                  ),
                  hintText: 'Available From',
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                onChanged: (val) {},
                validator: (value) {
                  return null;
                },
              ),
              SizedBox(
                height: 18.0,
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    width: 155.0,
                    child: Text(
                      'Rooms : ' + room.toString(),
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                        thumbShape:
                            RoundSliderThumbShape(enabledThumbRadius: 15),
                        overlayShape:
                            RoundSliderOverlayShape(overlayRadius: 30)),
                    child: Expanded(
                      child: Slider(
                        value: room.toDouble(),
                        min: 0,
                        max: 10,
                        onChanged: (value) {
                          setState(() {
                            room = value.toInt();
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    width: 155.0,
                    child: Text(
                      'Bedrooms : ' + bedroom.toString(),
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                        thumbShape:
                            RoundSliderThumbShape(enabledThumbRadius: 15),
                        overlayShape:
                            RoundSliderOverlayShape(overlayRadius: 30)),
                    child: Expanded(
                      child: Slider(
                        value: bedroom.toDouble(),
                        min: 0,
                        max: 10,
                        onChanged: (value) {
                          setState(() {
                            bedroom = value.toInt();
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    width: 155.0,
                    child: Text(
                      'Bathrooms : ' + bathroom.toString(),
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                        thumbShape:
                            RoundSliderThumbShape(enabledThumbRadius: 15),
                        overlayShape:
                            RoundSliderOverlayShape(overlayRadius: 30)),
                    child: Expanded(
                      child: Slider(
                        value: bathroom.toDouble(),
                        min: 0,
                        max: 10,
                        onChanged: (value) {
                          setState(() {
                            bathroom = value.toInt();
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 18.0,
              ),
              TextFormField(
                controller: cityCtl,
                keyboardType: TextInputType.text,
                style: TextStyle(height: 1.0),
                decoration: InputDecoration(
                  labelText: 'City',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              MaterialButton(
                height: 30,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0)),
                color: kPrimaryBackgroundColor,
                textColor: Colors.white,
                onPressed: () async {},
                child: Text('Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
