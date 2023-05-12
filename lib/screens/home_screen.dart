import 'package:count_down/controller/list_controller.dart';
import 'package:count_down/model/count_down.dart';
import 'package:count_down/screens/timer_view.dart';
import 'package:count_down/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  ListController controller = Get.put(ListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(txtAppName)),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: GetBuilder<ListController>(
            builder: (controller) {
              return controller.data.isEmpty
                  ? Center(child: Text("No Data Found\nAdd Data by clicking +", textAlign: TextAlign.center,),)
              : ListView.separated(
                itemCount: controller.data.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var data = controller.data[index];
                  return TimerView(data: data);
                }, separatorBuilder: (BuildContext context, int index) {
                return const Divider(thickness: 1, color: Colors.grey);
              },
              );
            }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          controller.data.add(TimerData(count: TextEditingController(), status: 0));
          controller.update();
          Get.back();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
