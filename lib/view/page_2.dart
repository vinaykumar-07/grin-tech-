import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:grin_tech/view_model/methods.dart';
import 'package:grin_tech/model/model.dart'; 

class Page2 extends StatefulWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  List<Data> dataList = [];
  Data? lastPage1Item;

  @override
  void initState() {
    super.initState();
    getUserDetail1();
    getUserDetail2();
  }

  Future<void> getUserDetail1() async {
    String page = "1";
    var response = await ApiCall().userDetail(page);
    if (response.statusCode == 200) {
      var parsedJson = jsonDecode(response.body);
      Autogenerated autogenerated = Autogenerated.fromJson(parsedJson);

      if (autogenerated.data != null && autogenerated.data!.isNotEmpty) {
        setState(() {
          // Store the last item from Page1 API response
          lastPage1Item = autogenerated.data!.last;
        });
      }
    } else {
      // Handle error scenario
      print('Failed to load user details from Page1: ${response.statusCode}');
    }
  }

  Future<void> getUserDetail2() async {
    String page = "2";
    var response = await ApiCall().userDetail(page);
    if (response.statusCode == 200) {
      var parsedJson = jsonDecode(response.body);
      Autogenerated autogenerated = Autogenerated.fromJson(parsedJson);

      if (autogenerated.data != null) {
        setState(() {
          // Store the first 4 items from Page2 API response
          dataList = autogenerated.data!.take(4).toList();
        });
      }
    } else {
      // Handle error scenario
      print('Failed to load user details from Page2: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Page 2',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF012B5B),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            dataList.clear();
          });
          // Refresh logic here
          await getUserDetail1();
          await getUserDetail2();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (lastPage1Item != null)
              Card(
                margin: EdgeInsets.all(8.0),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(lastPage1Item!.avatar ?? ''),
                  ),
                  title: Text(
                      '${lastPage1Item!.firstName ?? ''} ${lastPage1Item!.lastName ?? ''}'),
                  subtitle: Text(lastPage1Item!.email ?? ''),
                ),
              ),
            Expanded(
              child: dataList.isEmpty
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: dataList.length,
                      itemBuilder: (context, index) {
                        Data userData = dataList[index];
                        return Card(
                          margin: EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(userData.avatar ?? ''),
                            ),
                            title: Text(
                                '${userData.firstName ?? ''} ${userData.lastName ?? ''}'),
                            subtitle: Text(userData.email ?? ''),
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
}
