import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/message_controller.dart';
import 'package:chat_bubbles/chat_bubbles.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final MessageController chatMessageController = Get.put(MessageController());
  final TextEditingController messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Auto-scroll when new messages arrive
    chatMessageController.messages.listen((_) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("VBot - Ultimate Ai"),
        backgroundColor: Colors.deepPurple.shade900.withOpacity(.98),
        titleTextStyle: GoogleFonts.lato(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        centerTitle: true,
        toolbarHeight: 70,
        shadowColor: Colors.black,
        elevation: 12,
      ),
      body: Column(
        children: [
          /// ========= MESSAGES ========= ///
          Expanded(
            child: Obx(
                  () => ListView.builder(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(16.0),
                itemCount: chatMessageController.messages.length,
                itemBuilder: (context, index) {
                  final message = chatMessageController.messages[index];
                  final bool isUser = message['isUser'];
                  final String time = message['time'];

                  return Align(
                    alignment:
                    isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: isUser
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        BubbleSpecialTwo(
                          isSender: isUser,
                          color: isUser
                              ? const Color(0XFF434343)           // user bubble
                              : const Color(0XFFe2ebf0),          // bot bubble
                          seen: true,
                          text: message['text'],
                          tail: true,
                          textStyle: GoogleFonts.lato(
                            fontSize: 14.0,
                            color: isUser
                                ? Colors.white                    // user text
                                : Colors.black,                   // bot text
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.only(right: 10, left: 20),
                          child: Text(
                            time,
                            style: const TextStyle(
                              fontSize: 10,
                              color: Color(0XFF808080),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),

          /// ========= “TYPING …” INDICATOR ========= ///
          Obx(
                () => chatMessageController.isTypeing.value
                ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    chatMessageController.responseText.value,
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
                : const SizedBox.shrink(),
          ),

          /// ========= TEXT FIELD + SEND BUTTON ========= ///
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      hintStyle:  GoogleFonts.getFont("Lato",color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: Colors.black45, width: 2),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.emoji_emotions_outlined),
                      ),
                    ),
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  heroTag: "send_button",
                  backgroundColor: Colors.deepPurple.shade900.withOpacity(.80),
                  foregroundColor: Colors.white,
                  onPressed: () {
                    if (messageController.text.trim().isNotEmpty) {
                      chatMessageController
                          .sendMessage(messageController.text.trim());
                      messageController.clear();
                    }
                  },
                  child: const Icon(Icons.send),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
