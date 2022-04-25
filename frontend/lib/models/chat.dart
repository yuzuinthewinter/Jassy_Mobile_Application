class ChatTitleType {
  int unseenCount;
  String lastMessageSentId;
  List<String> member;

  ChatTitleType({
    this.unseenCount = 0,
    this.lastMessageSentId = '',
    required this.member,
  });
}

enum MessageStatus { sending, sent, read }
enum ChatMessageType { text, audio, image, video }

class MessagesType {
  String chatId;
  String sender;
  String timestamp;
  String message;
  MessageStatus messageStatus;
  ChatMessageType messageType;

  //https://www.geeksforgeeks.org/format-dates-in-flutter/

  MessagesType({
    this.chatId = '',
    this.sender = '',
    this.timestamp = '',
    this.message = '',
    this.messageStatus = MessageStatus.sending,
    this.messageType = ChatMessageType.text,
  });
}
