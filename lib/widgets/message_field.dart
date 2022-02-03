import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:twitter_ui/models/messages_model.dart';

class TweetMessage extends StatelessWidget {
  const TweetMessage({Key? key, required this.messagedUser}) : super(key: key);

  final Map<String, dynamic> messagedUser;

  void _tapedActionedUsers() {
    print("_tapedActionedUsers");
    HapticFeedback.vibrate();
  }

  void _tapedUserName() {
    print("_tapedUserName");
    HapticFeedback.vibrate();
  }

  void _tapedShowThread() {
    print("_tapedShowThread");
    HapticFeedback.vibrate();
  }

  @override
  Widget build(BuildContext context) {
    final isShowedThread = messagedUser['showThisThread'];

    Widget current = Column(
      children: [
        /// * const space
        const SizedBox(height: 8),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// * image and actionIcon
            userAndActionIconField(isShowedThread),

            /// * content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// ! actioned users
                    actionedUsersField(),

                    /// * fixed spice
                    const SizedBox(height: 3),

                    /// ! userName nikName time
                    headerUserNameAndTimeField(),

                    /// * fixed spice
                    const SizedBox(height: 3),

                    /// ! content
                    contentField(),

                    /// ! image
                    if (messagedUser['contentImage'].length != 0)
                      contentImageField(),

                    /// * fixed space
                    const SizedBox(height: 8),

                    /// ! icon comment
                    commentIconsField(),

                    /// ! show this thread
                    if (isShowedThread)
                      Column(
                        children: [
                          const SizedBox(height: 10),
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 16,
                              ),
                              text: 'Show this Thread',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => _tapedShowThread(),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const Divider(),
      ],
    );

    current = Container(child: current);

    /// ! returned all
    return current;
  }

  Padding userAndActionIconField(bool isShowedThread) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              /// * fixed space
              const SizedBox(height: 3),

              /// ! action icon
              Image.asset(
                messagedUser['actionIcon'],
                height: 12,
              ),

              /// ! user Image
              CircleAvatar(
                radius: 27.5,
                backgroundImage: AssetImage(messagedUser['userImage']),
              ),
            ],
          ),
          const VerticalDivider(),
          if (isShowedThread)
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  radius: 18.5,
                  backgroundImage: AssetImage(messagedUser['userImage']),
                ),
              ],
            )
        ],
      ),
    );
  }

  RichText actionedUsersField() {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          color: Color(0xff687684),
          fontSize: 14,
        ),
        children: [
          TextSpan(
            text: "${messagedUser['actionUserName']} ",
          ),
          TextSpan(
            text: "${messagedUser['actionType']} ",
          ),
        ],
        recognizer: TapGestureRecognizer()..onTap = () => _tapedActionedUsers(),
      ),
    );
  }

  Row headerUserNameAndTimeField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                    text: "${messagedUser['userName']} ",
                  ),
                  TextSpan(
                    style: const TextStyle(
                      color: Color(0xff687684),
                    ),
                    text: "@${messagedUser['nickName']} ",
                  ),
                ],
                recognizer: TapGestureRecognizer()
                  ..onTap = () => _tapedUserName(),
              ),
              style: const TextStyle(
                fontSize: 15,
              ),
              overflow: TextOverflow.ellipsis,
            ),

            /// * time
            Text(
              "• ${messagedUser['tweetTime']} ",
              style: const TextStyle(
                color: Color(0xff687684),
              ),
            ),
          ],
        ),

        /// * arrow down
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Icon(
            Icons.keyboard_arrow_down,
            color: Color(0x9f687684),
            size: 20,
          ),
        ),
      ],
    );
  }

  RichText contentField() {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 15,
          color: Colors.black,
        ),
        children:
            messagedUser['textContent'].split(" ").map<InlineSpan>((element) {
          if (RegExp(r'^((#|@)(.)+)?$').hasMatch(element)) {
            return TextSpan(
                style: const TextStyle(color: Colors.blue), text: '$element ');
          } else {
            return TextSpan(text: '$element ');
          }
        }).toList(),
      ),
    );
  }

  Container contentImageField() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          messagedUser['contentImage'],
        ),
      ),
    );
  }

  Row commentIconsField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ...["message", "retweet", "heart", "share"]
            .map((e) => Row(
                  children: [
                    Image.asset(
                      commentIcons[e]!,
                      height: 15,
                      color: const Color(0xff687684),
                    ),
                    const SizedBox(width: 3.5),
                    Text(
                      messagedUser['comment'][e],
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xff687684),
                      ),
                    ),
                  ],
                ))
            .toList(),
        Container(),
      ],
    );
  }
}
