import 'package:car_pooling/controller/inbox_controller.dart';
import 'package:car_pooling/core/components/custom_app_bar.dart';
import 'package:car_pooling/model/chat_model.dart';
import 'package:car_pooling/view/inbox/local%20components/chat_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class InboxScreen extends StatelessWidget {
  InboxScreen({super.key});
  final InboxController controller = Get.find<InboxController>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: customAppBar1(
          "Inbox",
          hasBack: false,
          hasTabBar: true,
          tabs: [Tab(text: "Chats"), Tab(text: "Invitations")],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: TabBarView(
            children: [
              buildTabView(controller.myChatLists),
              buildTabView(controller.myChatLists),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTabView(List<ChatModel> carpools) {
    return carpools.isEmpty
        ? Center(child: Text('No chats yet'))
        : ListView.builder(
          itemCount: carpools.length,
          itemBuilder: (context, index) {
            final item = carpools[index];
            return ChatCard(
              fullName: "${item.firstName} ${item.lastName}",
              image: item.image,
              lstMsg: item.lastMessage,
              lstMsgTime: item.lastMsgTime,
            );
          },
        );
  }
}
