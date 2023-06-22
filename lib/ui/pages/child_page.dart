import 'package:flutter/material.dart';
import 'package:posyandu/models/children_model.dart';
import 'package:posyandu/services/children_services.dart';
import 'package:posyandu/shared/theme.dart';
import 'package:posyandu/ui/widget/custom_card_child.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChildPage extends StatefulWidget {
  const ChildPage({super.key});

  @override
  State<ChildPage> createState() => _ChildPageState();
}

class _ChildPageState extends State<ChildPage> {
  List<ChildrenResponseModel> _children = [];
  late SharedPreferences _prefs;
  String? id;

  @override
  void initState() {
    super.initState();
    _getUserData();
    _fetchChildren();
  }

  void _getUserData() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      id = _prefs.getString('userId');
    });
  }

  Future<void> _fetchChildren() async {
    try {
      List<ChildrenResponseModel> childrenList =
          await ChildrenService.fetchChildren(id.toString());
      setState(() {
        _children = childrenList;
      });
    } catch (e) {
      print('Failed to fetch children: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kTransparentColor,
        centerTitle: true,
        elevation: 0,
        title: Image.asset(
          'assets/images/Posyandu_Logo_Blue_Icon.png',
          height: 40,
          width: 40,
          alignment: Alignment.center,
        ),
      ),
      body: Column(
        children: [
          Align(
            child: Text(
              "Data Anak",
              style: blackTextStyle.copyWith(
                fontSize: 18,
                fontWeight: semiBold,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          for (int i = 0; i < _children.length; i++)
            CustomCardChild(
              childId: _children[i].childId!.toString(),
              name: _children[i].name!,
              dateOfBirth: _children[i].birtOfDate!,
              gender: _children[i].gender!,
              address: _children[i].address!,
              parentName: _children[i].parentName!,
              parentPhoneNumber: _children[i].parentPhoneNumber!,
              userId: _children[i].userId.toString(),
            ),
        ],
      ),
    );
  }
}
