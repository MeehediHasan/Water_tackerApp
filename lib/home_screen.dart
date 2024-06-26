import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _glasscountTEController = TextEditingController(text: "1");
  List<WaterConsume> waterConsumeList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: addWaterConsume,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.amber, width: 5),
                          borderRadius: BorderRadius.circular(120),
                        ),
                        child: const Padding(
                            padding: EdgeInsets.all(24),
                            child: Column(
                              children: [
                                Icon(Icons.water_drop_outlined, size: 32),
                                Text("Tap Here")
                              ],
                            )),
                      ),
                    ),
                     SizedBox(height: 16),
                    SizedBox(
                      width: 90,
                      child: TextField(
                        controller: _glasscountTEController,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "No of Glass",
                         contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 8),
                         enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.amber),
                          ),
                        ),
                      ),
                    ),
                     SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [const Text("History",style: TextStyle(fontWeight: FontWeight.bold),),
                      Text("Total:${_getTotalWaterConsumeCount().toString()}",style: TextStyle(fontWeight: FontWeight.bold),)],
                    ),
                    
                   const  Divider(height: 20,),
                  ],
                ),
              ),
               SizedBox(height: 16),
              SizedBox(
                height:
                    400, // You can set a fixed height as per your requirement
                child: ListView.builder(
                  reverse: false,
                  itemCount: waterConsumeList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(DateFormat.yMEd().add_jms().format(waterConsumeList[index].time)),
                      leading: CircleAvatar(child: Text("${index + 1}")),
                      trailing: Text(
                        waterConsumeList[index].glassCount.toString(),
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addWaterConsume() {
    int glassCount = int.parse(_glasscountTEController.text) ?? 1;
    WaterConsume waterConsume =
        WaterConsume(time: DateTime.now(), glassCount: glassCount);
    waterConsumeList.add(waterConsume);
    setState(() {});
  }

  int _getTotalWaterConsumeCount() {
    int totalWaterConsumeCount = 0;
    for (WaterConsume waterConsume in waterConsumeList) {
      totalWaterConsumeCount += waterConsume.glassCount;
    }
    return totalWaterConsumeCount;
  }
}

class WaterConsume {
  final DateTime time;
  final int glassCount;

  WaterConsume({required this.time, required this.glassCount});
}
