import 'package:flutter/material.dart';
import 'package:housing/constant.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:housing/provider/filter.dart' as filter;
import 'package:housing/provider/properties.dart' as prop;

class Filter extends StatefulWidget {
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  bool _initial=false;

  var format = NumberFormat.compactCurrency(locale: 'en_IN', symbol: "₹", decimalDigits: 0);

  String type;
  var selectedRange = RangeValues(20000, 9000000);
  int bedrooms;
  int bathrooms;
  int rooms;
  String construction_status;
  bool featured;
  String orderby;
  List features;

  @override
  void didChangeDependencies() {
    if(!_initial){
      final filterQ=Provider.of<filter.Filter>(context,listen: false);
      type = filterQ.type;
      bedrooms = filterQ.bedrooms;
      bathrooms = filterQ.bathrooms;
      rooms = filterQ.rooms;
      construction_status = filterQ.construction_status;
      featured = filterQ.featured;
      orderby = filterQ.orderby;
      // selectedRange.start = filterQ.price_start;
      // selectedRange.end = filterQ.price_end;

    }
    _initial=true;
  }


  Widget _buildTypeChips() {
    List<List> _options = [
      ["Buy", "B"],
      ["Sell", "S"],
      ["Rent", "R"],
    ];

    return Wrap(
      spacing: 10,
      children: List<Widget>.generate(
        _options.length, (int index) {
        return ChoiceChip(
          label: Text(_options[index][0]),
          selected: type == _options[index][1],
          backgroundColor: Colors.grey[200],
          selectedColor: kPrimaryColor,
          onSelected: (bool selected) {
            setState(() {
              type = selected ? _options[index][1] : null;
            });
          },
        );
      },
      ).toList(),
    );
  }
  Widget _buildBedroomChips() {
    List<List> _options = [
      ["Any", 0],
      ["1", 1],
      ["2", 2],
      ["3", 3],
      ["4", 4],
      ["4+", 5],
    ];

    return Wrap(
      spacing: 10,
      children: List<Widget>.generate(
        _options.length, (int index) {
        return ChoiceChip(
          label: Text(_options[index][0]),
          selected: bedrooms == _options[index][1],
          backgroundColor: Colors.grey[200],
          selectedColor: kPrimaryColor,
          onSelected: (bool selected) {
            setState(() {
              bedrooms = selected ? _options[index][1] : null;
            });
          },
        );
      },
      ).toList(),
    );
  }
  Widget _buildRoomChips() {
    List<List> _options = [
      ["Any", 0],
      ["1", 1],
      ["2", 2],
      ["3", 3],
      ["4", 4],
      ["4+", 5],
    ];

    return Wrap(
      spacing: 10,
      children: List<Widget>.generate(
        _options.length, (int index) {
        return ChoiceChip(
          label: Text(_options[index][0]),
          selected: rooms == _options[index][1],
          backgroundColor: Colors.grey[200],
          selectedColor: kPrimaryColor,
          onSelected: (bool selected) {
            setState(() {
              rooms = selected ? _options[index][1] : null;
            });
          },
        );
      },
      ).toList(),
    );
  }
  Widget _buildBathroomChips() {
    List<List> _options = [
      ["Any", 0],
      ["1", 1],
      ["2", 2],
      ["3", 3],
      ["3+", 4],
    ];

    return Wrap(
      spacing: 10,
      children: List<Widget>.generate(
        _options.length, (int index) {
          return ChoiceChip(
            label: Text(_options[index][0]),
            selected: bathrooms == _options[index][1],
            backgroundColor: Colors.grey[200],
            selectedColor: kPrimaryColor,
            onSelected: (bool selected) {
              setState(() {
                bathrooms = selected ? _options[index][1] : null;
              });
            },
          );
        },
      ).toList(),
    );
  }
  Widget _buildConstructionChips() {
    List<List> _options = [
      ['Ready to Move', "RM"],
      ['Under Construction', "UC"],
    ];

    return Wrap(
      spacing: 10,
      children: List<Widget>.generate(
        _options.length, (int index) {
        return ChoiceChip(
          label: Text(_options[index][0]),
          selected: construction_status == _options[index][1],
          backgroundColor: Colors.grey[200],
          selectedColor: kPrimaryColor,
          onSelected: (bool selected) {
            setState(() {
              construction_status = selected ? _options[index][1] : null;
            });
          },
        );
      },
      ).toList(),
    );
  }
  Widget _buildOrderByChips() {
    List<List> _options = [
      ['Price', "price"],
      ['Bedrooms', "bhk"],
      ['Views', "views"],
      ['Date', "date"],
    ];

    return Wrap(
      spacing: 10,
      children: List<Widget>.generate(
        _options.length, (int index) {
        return ChoiceChip(
          label: Text(_options[index][0]),
          selected: orderby == _options[index][1],
          backgroundColor: Colors.grey[200],
          selectedColor: kPrimaryColor,
          onSelected: (bool selected) {
            setState(() {
              orderby = selected ? _options[index][1] : null;
            });
          },
        );
      },
      ).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 24, left: 24, top: 24, bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    "Filter Your Search",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              FlatButton(
                color: kPrimaryColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(new Radius.circular(20.0))),
                child: Text('Apply'),
                onPressed: (){
                  final query=Provider.of<filter.Filter>(context, listen: false);
                  final proper = Provider.of<prop.Properties>(context, listen: false);
                  query.saveFilters(type, bedrooms, bathrooms, rooms, construction_status, selectedRange.start.toInt(), selectedRange.end.toInt(), featured, orderby);
                  print("Filters saved");
                  Map<String, String> query1 = query.toQuery();
                  print('You tapped on FlatButton');
                  print(query1);
                  // proper.fetchProperties(query1);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            "Type",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(
            height: 8,
          ),
          _buildTypeChips(),
          Row(
            children: [
              Text(
                "Price Range",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 20,),
              Text(
                  format.format(selectedRange.start) + " - " + format.format(selectedRange.end).toString(),
              ),
            ],
          ),

          RangeSlider(
            values: selectedRange,
            onChanged: (RangeValues newRange) {
              setState(() {
                selectedRange = newRange;
              });
            },
            min: 10000,
            max: 10000000,
            activeColor: kPrimaryColor,
            inactiveColor: Colors.grey[300],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Text(
                r"₹ 10k",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),

              Text(
                r"₹ 1 cr",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),

            ],
          ),

          SizedBox(
            height: 16,
          ),


          Text(
            "Bedrooms",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(
            height: 8,
          ),
          _buildBedroomChips(),
          Text(
            "Rooms",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(
            height: 8,
          ),
          _buildRoomChips(),

          SizedBox(
            height: 8,
          ),

          Text(
            "Bathrooms",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          _buildBathroomChips(),
          Text(
            "Construction Status",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          _buildConstructionChips(),


          Text(
            "Order By",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          _buildOrderByChips(),


        ],
      ),
    );
  }
}