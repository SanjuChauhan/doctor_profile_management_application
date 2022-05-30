import 'package:doctor_profile_management_application/models/contactModel.dart';
import 'package:flutter/material.dart';

import '../services/apiCallService.dart';
import '../utility/utility.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ContactsData> contactListData = [];

  @override
  void initState() {
    super.initState();
    print("initState");

    this.getContactListData();
  }

  //----UI-TEMPLATES----------------------------------------

  @override
  Widget build(BuildContext context) {
    print("Widget build(BuildContext context");

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("ABC"),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: contactListData.length,
                itemBuilder: (content, index) {
                  return Card(
                    child: ListTile(
                      onTap: (){
                        print(this.contactListData[index].id);
                      },
                      leading: ClipOval(
                        child: SizedBox.fromSize(
                          size: Size.fromRadius(25), // Image radius
                          child: Image.network(
                              this.contactListData[index].profile_pic,
                              fit: BoxFit.cover),
                        ),
                      ),
                      title: Text(this.contactListData[index].first_name +
                          " " +
                          this.contactListData[index].last_name),
                      trailing: SizedBox(
                        height: 30.0,
                        width: 30.0,
                        child: MaterialButton(
                          key: Key(index.toString()),
                          onPressed: () {
                            print(this.contactListData[index].id);
                          },
                          child: Icon(Icons.arrow_forward_ios, size: 25),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(covariant HomeScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget");
  }

  void getContactListData() async {
    var contactDataList = await APICalls.shared.getContactsDataList();

    if (contactDataList != null) {
      print("Directory List = $contactListData");
      setState(() {
        contactListData = contactDataList;
      });
    } else {
      Utility.showToast(msg: "Fail To Load Contact data");
    }
  }
}
