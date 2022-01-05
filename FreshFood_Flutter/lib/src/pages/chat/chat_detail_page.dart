import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freshfood/src/models/message_model.dart';
import 'package:freshfood/src/pages/Admin/controller/chat_admin_controller.dart';
import 'package:freshfood/src/providers/user_provider.dart';
import 'package:freshfood/src/routes/app_pages.dart';
import 'package:freshfood/src/services/socket_emit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ChatDetailScreen extends StatefulWidget {
  final String id;
  final String name;
  final String image;

  ChatDetailScreen({this.id, this.name, this.image});

  @override
  _ChatDetailScreenState createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  TextEditingController msgController = TextEditingController();
  ScrollController scrollController = ScrollController();

  String message = "";

  @override
  void initState() {
    super.initState();
    messageAdminController.initialMessage(widget.id);
    messageAdminController.getListMessage(widget.id);
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels == 0) {
          // You're at the top.
        } else {
          messageAdminController.getListMessage(widget.id);
        }
      }
    });
  }

  _ChatDetailBubble(MessageModel message, bool isMe, bool isSameUser) {
    if (isMe) {
      return Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topRight,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.80,
              ),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Text(
                message.message,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          !isSameUser
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      // DateFormat("dd-MM-yyyy HH:mm:ss")
                      DateFormat("HH:mm dd-MM")
                          .format(message.createdAt.toLocal())
                          .toString(),

                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black45,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 15,
                        //sender img
                        backgroundImage: NetworkImage(
                            Provider.of<UserProvider>(context).user.avatar),
                      ),
                    ),
                  ],
                )
              : Container(
                  child: null,
                ),
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.80,
              ),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Text(
                message.message,
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
            ),
          ),
          !isSameUser
              ? Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 15,
                        //sender image url
                        backgroundImage: NetworkImage(widget.image),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      DateFormat("HH:mm dd-MM")
                          .format(message.createdAt.toLocal())
                          .toString(),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                )
              : Container(
                  child: null,
                ),
        ],
      );
    }
  }

  _sendMessageArea() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      height: 70,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          // IconButton(
          //   icon: Icon(Icons.photo),
          //   iconSize: 25,
          //   color: Theme.of(context).primaryColor,
          //   onPressed: () {},
          // ),
          SizedBox(width: 20.sp),
          Expanded(
            child: TextField(
              controller: msgController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration.collapsed(
                hintText: 'Send a message..',
              ),
              // textCapitalization: TextCapitalization.sentences,
              onChanged: (mes) {
                setState(() {
                  message = mes.trim();
                });
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25,
            color: Theme.of(context).primaryColor,
            onPressed: () {
              if (message.trim().length > 0) {
                SocketEmit().sendMessage(message);
                setState(() {
                  message = '';
                  msgController.text = '';
                });
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String prevUserId;
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      appBar: AppBar(
        brightness: Brightness.dark,
        centerTitle: true,
        title: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                  text: widget.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  )),
              TextSpan(text: '\n'),
              // widget.user.isOnline
              true
                  ? TextSpan(
                      text: 'Online',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  : TextSpan(
                      text: 'Offline',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ),
                    )
            ],
          ),
        ),
        leading: Get.currentRoute == Routes.CHAT_DETAIL
            ? IconButton(
                icon: Icon(Icons.arrow_back_ios),
                color: Colors.white,
                onPressed: () {
                  messageAdminController.leaveChannel(widget.id);
                  Get.back();
                })
            : null,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder(
                stream: messageAdminController.listMessages,
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  }

                  return ListView.builder(
                    controller: scrollController,
                    reverse: true,
                    padding: EdgeInsets.all(15.sp),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      // final Message message = messages[index];
                      MessageModel message =
                          MessageModel.fromMap(snapshot.data[index]);
                      final bool isMe =
                          message.creatorUser == userProvider.user.id;
                      final bool isSameUser = prevUserId == message.creatorUser;
                      prevUserId = message.creatorUser;
                      return _ChatDetailBubble(message, isMe, isSameUser);
                    },
                  );
                }),
          ),
          _sendMessageArea(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    messageAdminController.leaveChannel(widget.id);
    super.dispose();
  }
}
