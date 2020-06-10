import 'package:flutter/material.dart';
import 'package:wechat_app/constants.dart';
import 'package:wechat_app/model/conversation.dart' show ConversationPageData, Conversation;

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ConversationPageData data = ConversationPageData.mock();

  @override
  Widget build(BuildContext context) {
    var mockConversations = data.conversations;

    return ListView.builder(
      itemBuilder: (BuildContext contex, int index) {
        if (data.device != null) {
          if (index == 0) {
            return Container(
              height: 20.0,
              color: Colors.blue,
            );
          }
          return ChatItem(item: mockConversations[index - 1],);
        } else {
          return ChatItem(item: mockConversations[index],);
        }
      },
      itemCount: mockConversations.length,
    );
  }
}


class ChatItem extends StatelessWidget {
  static const VERTICAL_PADDING = 12.0;
  static const HORIZONTAL_PADDING = 18.0;
  static const UN_READ_MSG_CIRCLE_SIZE = 20.0;
  static const UN_READ_MSG_DOT_SIZE = 12.0;

  ChatItem({Key key, this.item}) : assert(item != null), super(key: key);
  final Conversation item;


  @override
  Widget build(BuildContext context) {
    // 头像
    Widget avatar;
    if (item.isAvatarFromNet()) {
      avatar = Image.network(
        item.avatar,
        width: Constants.ConversationAvatarSize,
        height: Constants.ConversationAvatarSize,
        fit: BoxFit.fill,
      );
    } else {
      avatar = Image.asset(
        item.avatar,
        width: Constants.ConversationAvatarSize,
        height: Constants.ConversationAvatarSize,
        fit: BoxFit.fill,
      );
    }
    // 左侧头像
    Widget avatarContainer;
    if (item.unreadMsgCount > 0) {
      // 未读消息图标
      Widget unreadMsgCountText;
      if (item.displayDot) {
        unreadMsgCountText = Container(
          width: UN_READ_MSG_DOT_SIZE,
          height: UN_READ_MSG_DOT_SIZE,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(UN_READ_MSG_DOT_SIZE / 2.0),
            color: Color(AppColors.NotifyDotBg)
          ),
        );
      } else {
        unreadMsgCountText = Container(
          width: UN_READ_MSG_CIRCLE_SIZE,
          height: UN_READ_MSG_CIRCLE_SIZE,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(UN_READ_MSG_CIRCLE_SIZE / 2.0),
            color: Color(AppColors.NotifyDotBg),
          ),
          child: Text(item.unreadMsgCount > 99 ? '99' : item.unreadMsgCount.toString(),
              style: AppStyles.UnreadMsgCountDotStyle),
        );
      }
      avatarContainer = Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          avatar,
          Positioned(
            right: item.displayDot ? -4.0 : -6.0,
            top: item.displayDot ? -4.0 : -6.0,
            child: unreadMsgCountText,
          )
        ],
      );
    } else {
      avatarContainer = avatar;
    }
    // 聊天右侧
    var _rightArea = <Widget>[
      Text(item.updateAt, style: AppStyles.DesStyle),
      SizedBox(height: 10.0),
    ];
    if (item.isMute) {
      _rightArea.add(
        Icon(
          IconData(
            0xe755,
            fontFamily: Constants.IconFontFamily,
          ),
          color: Color(AppColors.ConversationMuteIcon),
          size: Constants.ConversationMuteIconSize,
        )
      );
    } else {
      _rightArea.add(Icon(
          IconData(
            0xe755,
            fontFamily: Constants.IconFontFamily,
          ),
          color: Colors.transparent,
          size: Constants.ConversationMuteIconSize));
    }

    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(AppColors.DividerColor),
            width: 1))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          avatarContainer,
          Container(width: 12.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(item.title, style: AppStyles.TitleStyle, maxLines: 1,),
                SizedBox(height: 2.0),
                Text(item.des, style: AppStyles.DesStyle, maxLines: 1)
              ],
            ),
          ),
          Container(width: 10.0),
          Column(
            children: _rightArea
          )
      ],),
    );
  }
}

