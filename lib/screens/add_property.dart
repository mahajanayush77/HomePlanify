import 'dart:io';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:housing/constant.dart';
import 'package:housing/models/feature.dart';
import 'package:housing/models/property.dart';
import 'package:housing/provider/properties.dart' as newprop;
import 'package:housing/utilities/api-response.dart';
import 'package:housing/utilities/api_endpoints.dart';
import 'package:housing/utilities/api_helper.dart';
import 'package:housing/widgets/bottom_bar.dart';
import 'package:housing/widgets/image_bottom_sheet.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:housing/utilities/http_exception.dart';
import 'package:provider/provider.dart';

class AddProperty extends StatefulWidget {
  static const routeName = '/addProperty';

  @override
  _AddPropertyState createState() => _AddPropertyState();
}

class _AddPropertyState extends State<AddProperty> {
  var _type = {
    'B': "Buy",
    'S': "Sell",
    'R': "Rent",
  };
  var _status = {
    'RM': "Ready to Move",
    'UC': "Under Construction",
  };
  Map<String, dynamic> _initProduct = {
    'type': ' ',
    'property_name': ' ',
    'city': ' ',
    'bedrooms': ' ',
    'bathrooms': ' ',
    'rooms': ' ',
    'construction_status': ' ',
    'available_from': ' ',
    'total_price': ' ',
    'features': ' ',
    'youtube_video': ' ',
    'youtube_video_2': ' ',
    'owner': ' ',
  };
  int room = 0;
  int bedroom = 0;
  int bathroom = 0;
  bool _isLoading = false;
  File _imageFile;
  List<Feature> featuresList = [];
  List<String> features = [];
  final _formKey = GlobalKey<FormState>();
  final TextEditingController cityCtl = TextEditingController();
  final TextEditingController dateCtl = TextEditingController();
  final TextEditingController fDateCtl = TextEditingController();
  final TextEditingController titleCtl = TextEditingController();
  final TextEditingController priceCtl = TextEditingController();
  final TextEditingController areaCtl = TextEditingController();
  final TextEditingController descCtl = TextEditingController();
  final TextEditingController ytVideoLink1 = TextEditingController();
  final TextEditingController ytVideoLink2 = TextEditingController();
  final TextEditingController shiftTimeCtl = TextEditingController();
  String _typeValue;
  String _statusValue;
  bool _noImageError = false;
  Map<String, dynamic> _editedData;
  bool _initial = true;
  Future getImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: source);
    setState(() {
      _imageFile = File(pickedFile.path);
      _noImageError = false;
    });

    //cropImage();
  }

  @override
  void initState() {
    _fetchFeatures();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_initial) {
      final id = ModalRoute.of(context).settings.arguments as int;
      print(id);
      if (id != null) {
        _editedData = Provider.of<newprop.Property>(context).findById(id);
        _initProduct = {
          'type': _editedData['type'],
          'property_name': _editedData['property_name'],
          'city': _editedData['city'],
          'bedrooms': _editedData['bedrooms'],
          'bathrooms': _editedData['bathrooms'],
          'rooms': _editedData['rooms'],
          'construction_status': _editedData['construction_status'],
          'available_from': _editedData['available_from'],
          'total_price': _editedData['total_price'],
          'features': _editedData['features'],
          'youtube_video': _editedData['youtube_video'],
          'youtube_video_2': _editedData['youtube_video_2'],
          'owner': _editedData['owner'],
        };
        print(_editedData);
        print(_initProduct['property_name']);
        print(_editedData['property_name']);
      }
    }
    _initial = false;
    super.didChangeDependencies();
  }

  void _fetchFeatures() async {
    ApiResponse response =
        await ApiHelper().getWithoutAuthRequest(endpoint: eFeatures);
    if (!response.error) {
      final List featureData = response.data.toList();
      List<Feature> tempList = [];
      featureData.forEach((element) {
        final Feature feature = Feature(
            id: element['id'].toString(),
            title: element['title'],
            description: element['description']);
        tempList.add(feature);
      });
      setState(() {
        featuresList.addAll(tempList);
      });
    } else {
      Flushbar(
        message: 'Unable to fetch features',
        duration: Duration(seconds: 3),
      )..show(context);
    }
  }

  void _saveForm(BuildContext context) async {
    final isValid = _formKey.currentState.validate();
    if (!isValid) return;
    _formKey.currentState.save();

    if (_imageFile == null) {
      setState(() {
        _noImageError = true;
      });
      return;
    }
    setState(() {
      _isLoading = true;
    });

    Property property = Property(
        type: _editedData['type'],
        property_name: _editedData['property_name'],
        city: _editedData['city'],
        bedrooms: bedroom,
        bathrooms: bathroom,
        rooms: room,
        features: features,
        total_price: _editedData['total_price'],
        construction_status: _editedData['construction_status'],
        available_from: _editedData['available_from']);
    if (ytVideoLink1.text.isNotEmpty)
      property.youtube_video = ytVideoLink1.text;
    if (ytVideoLink2.text.isNotEmpty)
      property.youtube_video_2 = ytVideoLink2.text;
    String featuresString = '';
    property.features.forEach((element) {
      featuresString = '$featuresString#$element';
    });
    featuresString = featuresString.substring(1);
    Map<String, dynamic> data = {
      'type': property.type,
      'property_name': property.property_name,
      'city': property.city,
      'bedrooms': property.bedrooms,
      'bathrooms': property.bathrooms,
      'rooms': property.rooms,
      'construction_status': property.construction_status,
      'available_from': property.available_from,
      'total_price': property.total_price,
      'features': featuresString,
      'youtube_video': property.youtube_video,
      'youtube_video_2': property.youtube_video_2,
      'owner': ApiHelper().getUID(),
    };
    try {
      final ApiResponse response = await ApiHelper().postWithFileRequest(
          endpoint: '$eProperties',
          data: data,
          file: _imageFile,
          fileFieldName: 'main_image');
      if (!response.error)
        Flushbar(
          message: 'Property added successfully!',
          duration: Duration(seconds: 3),
        )..show(context);
      else {
        Flushbar(
          message: response.errorMessage ?? 'Unable to add',
          duration: Duration(seconds: 3),
        )..show(context);
      }
    } on HttpException catch (error) {
      throw HttpException(message: error.toString());
    } catch (error) {
      Flushbar(
        message: 'Unable to add',
        duration: Duration(seconds: 3),
      )..show(context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final prop = Provider.of<newprop.Property>(context, listen: false);
    final id = ModalRoute.of(context).settings.arguments as int;
    final size = DeviceSize(context: context);
    var myFormat = DateFormat('yyyy-MM-dd');
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryBackgroundColor,
        title: _initial ? Text('Edit Prperty') : Text('Add Property'),
      ),
      bottomNavigationBar: bottom_bar(1),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  initialValue: _initProduct['property_name'],
                  // controller: titleCtl,
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
                  validator: (value) {
                    if (value.isEmpty) return 'Title can\'t be empty';
                    return null;
                  },
                  onSaved: (value) {
                    _editedData['property_name'] = value;
                  },
                ),
                SizedBox(
                  height: 18.0,
                ),
                TextFormField(
                  initialValue: _initProduct['total_price'].toString(),
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
                  validator: (value) {
                    if (value.isEmpty) return 'Price can\'t be empty';
                    return null;
                  },
                  onSaved: (value) {
                    _editedData['total_price'] = value;
                  },
                ),
                SizedBox(
                  height: 18.0,
                ),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                      labelText: _initProduct['type'].toString().trim().isEmpty
                          ? 'Type'
                          : _initProduct['type'],
                      prefixText: _initProduct['type'].toString().trim().isEmpty
                          ? (_typeValue == null ? 'Select' : '')
                          : '',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0))),
                  value: (_initProduct['type'].toString().trim().isEmpty
                      ? _typeValue
                      : _initProduct['type']),
                  isDense: true,
                  items: _type
                      .map((key, value) {
                        return MapEntry(
                            key,
                            DropdownMenuItem<String>(
                              value: key,
                              child: Text(value),
                            ));
                      })
                      .values
                      .toList(),
                  // items: _type.map((String value) {
                  //   return DropdownMenuItem<String>(
                  //     value: value,
                  //     child: Text(value),
                  //   );
                  // }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _typeValue = newValue;
                      _editedData['type'] = newValue;
                    });
                  },
                  validator: (value) {
                    if (value?.isEmpty ?? true) return 'Type can\'t be empty';
                    return null;
                  },
                ),
                SizedBox(
                  height: 18.0,
                ),
                TextFormField(
                  //initialValue: _editedData[''],
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
                  validator: (value) {
                    if (value.isEmpty) return 'Area can\'t be empty';
                    return null;
                  },
                  // onSaved: (value){
                  //   _editedData['']
                  // },
                ),
                SizedBox(
                  height: 18.0,
                ),
                TextFormField(
                  controller: descCtl,
                  keyboardType: TextInputType.multiline,
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
                  validator: (value) {
                    if (value.isEmpty) return 'Description can\'t be empty';
                    return null;
                  },
                ),
                SizedBox(
                  height: 18.0,
                ),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                      labelText: _initProduct['construction_status']
                              .toString()
                              .trim()
                              .isEmpty
                          ? 'Construction Status'
                          : _initProduct['construction_status'],
                      hintText: 'Select',
                      prefixText: _initProduct['construction_status']
                              .toString()
                              .trim()
                              .isEmpty
                          ? (_statusValue == null ? 'Select' : '')
                          : '',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0))),
                  value: _initProduct['construction_status']
                          .toString()
                          .trim()
                          .isEmpty
                      ? _statusValue
                      : _initProduct['construction_status'],
                  isDense: true,
                  // items: _status.map((String value) {
                  //   return DropdownMenuItem<String>(
                  //     value: value,
                  //     child: Text(value),
                  //   );
                  // }).toList(),

                  items: _status
                      .map((key, value) {
                        return MapEntry(
                            key,
                            DropdownMenuItem<String>(
                              value: key,
                              child: Text(value),
                            ));
                      })
                      .values
                      .toList(),

                  onChanged: (newValue) {
                    setState(() {
                      _editedData['construction_status'] = newValue;
                    });
                  },
                  validator: (value) {
                    if (value?.isEmpty ?? true) return 'Status can\'t be empty';
                    return null;
                  },
                ),
                SizedBox(
                  height: 18.0,
                ),
                TextFormField(
                  initialValue: _initProduct['available_from'],
                  keyboardType: TextInputType.datetime,
                  // controller: dateCtl,
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
                    if (value.isEmpty) return 'Date can\'t be empty';
                    return null;
                  },
                  onSaved: (value) {
                    _editedData['available_from'] = value;
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
                        'Rooms : ' +
                            (_initProduct['rooms'].toString().trim().isEmpty
                                ? room.toString()
                                : _initProduct['rooms'].toString()),
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
                              _editedData['rooms'] = value.toInt();
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
                        'Bedrooms : ' +
                            (_initProduct['bedrooms'].toString().trim().isEmpty
                                ? room.toString()
                                : _initProduct['bedrooms'].toString()),
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
                              _editedData['bedrooms'] = value.toInt();
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
                        'Bathrooms : ' +
                            (_initProduct['bathrooms'].toString().trim().isEmpty
                                ? room.toString()
                                : _initProduct['bathrooms'].toString()),
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
                              _editedData['bathrooms'] = value.toInt();
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
                  initialValue: _initProduct['city'],
                  // controller: cityCtl,
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
                  validator: (value) {
                    if (value.isEmpty) return 'City can\'t be empty';
                    return null;
                  },
                  onSaved: (value) {
                    _editedData['city'] = value;
                  },
                ),
                SizedBox(
                  height: 18.0,
                ),
                TextFormField(
                  initialValue: _initProduct['youtube_video'],
                  keyboardType: TextInputType.url,
                  style: TextStyle(height: 1.0),
                  decoration: InputDecoration(
                    labelText: 'YouTube Video Link',
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  ),
                  onSaved: (value) {
                    _editedData['youtube_video'] = value;
                  },
                ),
                SizedBox(
                  height: 18.0,
                ),
                TextFormField(
                  initialValue: _initProduct['youtube_video_2'],
                  keyboardType: TextInputType.text,
                  style: TextStyle(height: 1.0),
                  decoration: InputDecoration(
                    labelText: 'YouTube Video 2 Link',
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  ),
                  onSaved: (value) {
                    _editedData['youtube_video_2'] = value;
                  },
                ),
                SizedBox(
                  height: 18.0,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Featured Image',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: GestureDetector(
                      child: Container(
                        height: size.height * 0.4,
                        width: double.infinity,
                        child: Hero(
                          tag: 'add_image',
                          child: (_imageFile == null)
                              ? Container(
                                  color: Colors.black.withOpacity(0.1),
                                  height: size.height * 0.3,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Center(
                                          child: Icon(
                                            Icons.add_circle,
                                            color: Colors.black26,
                                            size: size.width * 0.2,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(
                                  height: size.height * 0.3,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: FileImage(_imageFile),
                                          fit: BoxFit.fitWidth)),
                                ),
                        ),
                      ),
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) => Wrap(children: [
                                  ImageBottomSheet(
                                    onTapCamera: () async {
                                      getImage(ImageSource.camera);
                                      Navigator.pop(context);
                                    },
                                    onTapGallery: () async {
                                      getImage(ImageSource.gallery);
                                      Navigator.pop(context);
                                    },
                                  )
                                ]));
                        // Navigator.push(context, MaterialPageRoute(builder: (_) {
                        //   return FullScreenImage(
                        //       tag: sheet.uploader, url: sheet.imageUrl);
                        // }));
                      },
                    ),
                  ),
                ),
                if (_noImageError)
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Add a featured image',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Theme.of(context).errorColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                SizedBox(
                  height: 18.0,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Features',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                (featuresList.length > 0)
                    ? ListView.builder(
                        itemCount: featuresList.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return CheckboxListTile(
                              value: features.contains(featuresList[index].id),
                              title: Text(
                                featuresList[index].title,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                              onChanged: (_) {
                                if (features.contains(featuresList[index].id)) {
                                  setState(() {
                                    features.remove(featuresList[index].id);
                                  });
                                } else {
                                  setState(() {
                                    features.add(featuresList[index].id);
                                  });
                                }
                              });
                        },
                      )
                    : Text('Loading Features...'),
                SizedBox(
                  height: 10.0,
                ),
                (_isLoading)
                    ? SpinKitThreeBounce(
                        color: Theme.of(context).primaryColor,
                      )
                    : MaterialButton(
                        height: 30,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0)),
                        color: kPrimaryBackgroundColor,
                        textColor: Colors.white,
                        onPressed: () async {
                          _saveForm(context);
                        },
                        child: Text('Add'),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
