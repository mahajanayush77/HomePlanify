// necessary imports
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
// packages
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flushbar/flushbar.dart';
import 'package:image_picker/image_picker.dart';

// packages
import '../constant.dart';
import '../models/feature.dart';
import '../models/property.dart';
import '../provider/my_properties.dart';
import '../provider/properties.dart' as newprop;
import '../utilities/api-response.dart';
import '../utilities/api_endpoints.dart';
import '../utilities/api_helper.dart';
import '../widgets/bottom_bar.dart';
import '../widgets/image_bottom_sheet.dart';
import '../utilities/http_exception.dart';

// Add property form
class AddProperty extends StatefulWidget {
  static const routeName = '/addProperty';

  @override
  _AddPropertyState createState() => _AddPropertyState();
}

class _AddPropertyState extends State<AddProperty> {
  // type of property
  var _type = {
    'B': "Buy",
    'S': "Sell",
    'R': "Rent",
  };
  // status of the property
  var _status = {
    'RM': "Ready to Move",
    'UC': "Under Construction",
  };
  // required for POST
  int room = 0;
  int bedroom = 0;
  int bathroom = 0;
  bool _isLoading = false;
  File _imageFile;
  String _featuredImage;
  List<Feature> featuresList = [];
  List<int> features = [];
  List<File> _propertyImages = [];
  int propId;
  String _typeValue;
  String _statusValue;
  bool _noImageError = false;
  Property _editedData;
  bool _initial = true;

  // Form Key
  final _formKey = GlobalKey<FormState>();

  // Text box controller
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

  // for picking images from gallery/camera
  Future<File> getImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: source);
    setState(() {
      _imageFile = File(pickedFile.path);
      _noImageError = false;
    });
    return File(pickedFile.path);
  }

  @override
  void initState() {
    _fetchFeatures(); // fetch the list of available features
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // editing a listed property
    if (_initial) {
      final id = ModalRoute.of(context).settings.arguments as int;
      print(id);
      if (id != null) {
        _editedData = Provider.of<MyProperties>(context).findById(id);
        propId = _editedData.id;
        _typeValue = _editedData.type;
        titleCtl.text = _editedData.property_name;
        cityCtl.text = _editedData.city;
        bedroom = _editedData.bedrooms;
        bathroom = _editedData.bathrooms;
        room = _editedData.rooms;
        descCtl.text = _editedData.description;
        features = _editedData.features.map((e) => e as int).toList();
        priceCtl.text = _editedData.total_price.toString();
        _statusValue = _editedData.construction_status;
        dateCtl.text = _editedData.available_from;
        ytVideoLink1.text = _editedData.youtube_video ??= "";
        ytVideoLink2.text = _editedData.youtube_video_2 ??= "";
        _featuredImage = _editedData.main_image;
      }
    }
    _initial = false;
    super.didChangeDependencies();
  }

  // fetch features
  void _fetchFeatures() async {
    ApiResponse response =
        await ApiHelper().getWithoutAuthRequest(endpoint: eFeatures);
    if (!response.error) {
      final List featureData = response.data.toList();
      List<Feature> tempList = [];
      featureData.forEach((element) {
        final Feature feature = Feature(
            id: element['id'],
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

  // saving the form and making a POST request
  _saveForm() async {
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
        type: _typeValue,
        property_name: titleCtl.text,
        city: cityCtl.text,
        bedrooms: bedroom,
        bathrooms: bathroom,
        rooms: room,
        features: features,
        total_price: int.parse(priceCtl.text),
        construction_status: _statusValue,
        available_from: dateCtl.text);
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
      if (!response.error) {
        var id = response.data['id'];
        Map<String, dynamic> data2 = {
          'property': id,
        };
        if (_propertyImages.length > 0) {
          for (var img in _propertyImages) {
            final ApiResponse response2 = await ApiHelper().postWithFileRequest(
              endpoint: '$eImages',
              data: data2,
              file: img,
              fileFieldName: 'image',
            );
          }
        }
        ;
        Flushbar(
          message: 'Property Added Successfully',
          duration: Duration(seconds: 3),
        )..show(context);
      } else {
        Flushbar(
          message: response.errorMessage ?? 'Unable to add',
          duration: Duration(seconds: 3),
        )..show(context);
      }
    } on HttpException catch (error) {
      throw HttpException(message: error.toString());
    } catch (error) {
      print(error);
      Flushbar(
        message: 'Unable to add',
        duration: Duration(seconds: 3),
      )..show(context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  // saving form and making a Patch request on existing property
  _updateForm() async {
    _formKey.currentState.save();

    setState(() {
      _isLoading = true;
    });

    Property property = Property(
        type: _typeValue,
        property_name: titleCtl.text,
        city: cityCtl.text,
        bedrooms: bedroom,
        bathrooms: bathroom,
        rooms: room,
        features: features,
        total_price: int.parse(priceCtl.text),
        construction_status: _statusValue,
        available_from: dateCtl.text);
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
      'bedrooms': property.bedrooms.toString(),
      'bathrooms': property.bathrooms.toString(),
      'rooms': property.rooms.toString(),
      'description': property.description ?? "",
      'construction_status': property.construction_status,
      'available_from': property.available_from,
      'total_price': property.total_price.toString(),
      'features': featuresString,
      'youtube_video': property.youtube_video ?? "",
      'youtube_video_2': property.youtube_video_2 ?? "",
      'owner': ApiHelper().getUID(),
    };
//    print(data);
    try {
      ApiResponse response;

      response = await ApiHelper().patchRequestwithFile(
          endpoint: '$eProperties$propId/',
          data: data,
          file: _imageFile,
          fileFieldName: 'main_image');

      if (!response.error)
        Flushbar(
          message: 'Property Updated successfully!',
          duration: Duration(seconds: 3),
        )..show(context);
      else {
        Flushbar(
          message: response.errorMessage ?? 'Unable to Update',
          duration: Duration(seconds: 3),
        )..show(context);
      }
    } on HttpException catch (error) {
      throw HttpException(message: error.toString());
    } catch (error) {
      print(error);
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
    final size = DeviceSize(context: context);
    var myFormat = DateFormat('yyyy-MM-dd');


    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryBackgroundColor,
        title: (propId != null) ? Text('Edit Property') : Text('Add Property'),
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
                  validator: (value) {
                    if (value.isEmpty) return 'Title can\'t be empty';
                    return null;
                  },
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
                  validator: (value) {
                    if (value.isEmpty) return 'Price can\'t be empty';
                    return null;
                  },
                ),
                SizedBox(
                  height: 18.0,
                ),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                      labelText: 'Type',
                      prefixText: _typeValue == null ? 'Select' : '',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0))),
                  value: _typeValue,
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

                  onChanged: (String newValue) {
                    setState(() {
                      _typeValue = newValue;
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
                      labelText: 'Construction Status',
                      hintText: 'Select',
                      prefixText: _statusValue == null ? 'Select' : '',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0))),
                  value: _statusValue,
                  isDense: true,

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

                  onChanged: (String newValue) {
                    setState(() {
                      _statusValue = newValue;
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
                    if (value.isEmpty) return 'Date can\'t be empty';
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
                  validator: (value) {
                    if (value.isEmpty) return 'City can\'t be empty';
                    return null;
                  },
                ),
                SizedBox(
                  height: 18.0,
                ),
                TextFormField(
                  controller: ytVideoLink1,
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
                ),
                SizedBox(
                  height: 18.0,
                ),
                TextFormField(
                  controller: ytVideoLink2,
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
                              ? (_featuredImage != null)
                                  ? Image.network(_featuredImage)
                                  : Container(
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
                                        fit: BoxFit.fitWidth),
                                  ),
                                ),
                        ),
                      ),
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) => Wrap(children: [
                                  ImageBottomSheet(
                                    onTapCamera: () async {
                                      File file =
                                          await getImage(ImageSource.camera);
                                      setState(() {
                                        _imageFile = file;
                                        _noImageError = false;
                                      });
                                      Navigator.pop(context);
                                    },
                                    onTapGallery: () async {
                                      File file =
                                          await getImage(ImageSource.gallery);
                                      setState(() {
                                        _imageFile = file;
                                        _noImageError = false;
                                      });
                                      Navigator.pop(context);
                                    },
                                  )
                                ]));
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
                    'Property Images',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: size.height * 0.2,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _propertyImages.length + 1,
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4.0, vertical: 10.0),
                        child: (i == _propertyImages.length)
                            ? GestureDetector(
                                child: AspectRatio(
                                  aspectRatio: 3 / 2,
                                  child: Container(
                                    // width: size.width*0.5,

                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.1),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    // height: size.height * 0.3,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Center(
                                            child: Icon(
                                              Icons.add_circle,
                                              color: Colors.black26,
                                              size: size.width * 0.14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) => Wrap(children: [
                                            ImageBottomSheet(
                                              onTapCamera: () async {
                                                File file = await getImage(
                                                    ImageSource.camera);
                                                setState(() {
                                                  _propertyImages.add(file);
                                                });
                                                Navigator.pop(context);
                                              },
                                              onTapGallery: () async {
                                                File file = await getImage(
                                                    ImageSource.gallery);
                                                setState(() {
                                                  _propertyImages.add(file);
                                                });
                                                Navigator.pop(context);
                                              },
                                            )
                                          ]));
                                },
                              )
                            : AspectRatio(
                                aspectRatio: 3 / 2,
                                child: Container(
                                  // width: size.width*0.5,
                                  // height: size.height * 0.3,
                                  alignment: Alignment.topRight,

                                  child: IconButton(
                                    icon: Icon(Icons.cancel),
                                    onPressed: () {
                                      setState(() {
                                        _propertyImages.removeAt(i);
                                      });
                                    },
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      image: DecorationImage(
                                          image: FileImage(_propertyImages[i]),
                                          fit: BoxFit.fitWidth)),
                                ),
                              ),
                      );
                    },
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
                          if (propId != null) {
                            await _updateForm();
                          } else {
                            await _saveForm();
                            _formKey.currentState.reset();
                            setState(() {
                              _imageFile = null;
                              _featuredImage = null;
                              room = 0;
                              bedroom = 0;
                              bathroom = 0;
                              features = [];
                              _propertyImages = [];
                              _typeValue = null;
                              _statusValue = null;
                            });

                            cityCtl.clear();
                            dateCtl.clear();
                            fDateCtl.clear();
                            titleCtl.clear();
                            priceCtl.clear();
                            areaCtl.clear();
                            descCtl.clear();
                            ytVideoLink1.clear();
                            ytVideoLink2.clear();
                            shiftTimeCtl.clear();
                          }
                        },
                        child: (propId != null) ? Text('Update') : Text('Add'),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
