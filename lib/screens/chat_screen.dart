import 'package:flutter/material.dart';
import 'package:flutter_chat/widgets/chat_message.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  // 변수 앞에 _ 표시하면 private 선언
  final List<ChatMessage> _message = <ChatMessage>[];

  TextEditingController _textEditingController = TextEditingController();

  //TextField에 글자가 입력되면 true 가됩니다.
  bool _isComposing = false;

  @override
  void dispose() {
    _textEditingController.dispose();

    for (ChatMessage message in _message) {
      message.animationController.dispose();
      super.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CoreWeb Chat App'),
      ),
      body: new GestureDetector(
        // 화면을 찍으면 키보드를 내려준다.(인풋 박스 제외)
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: Column(
          children: <Widget>[
            Flexible(
              child: ListView.builder(
                padding: EdgeInsets.all(8.0),
                reverse: true,
                itemBuilder: (context, int index) => _message[index],
                itemCount: _message.length,
              ),
            ),
            Divider(
              height: 1.0,
            ),
            Container(
              // 텍스트필드에 엔터를 많이 넣으면 overflow 발생 가능하여 Container height를 주어 늘어난 화면은 보이지 않도록 한다.
              height: 50,
              decoration: BoxDecoration(color: Theme.of(context).cardColor),
              child: _buildTextComposer(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 0.8),
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Row(
            children: <Widget>[
              Flexible(
                child: TextField(
                  expands: true,
                  controller: _textEditingController,
//                onSubmitted: _handleSubmitted,
                  onChanged: (String text) {
                    setState(() {
                      _isComposing = text.trim().isNotEmpty;
                    });
                  },
                  maxLines: null,
                  textAlignVertical: TextAlignVertical(y: 0.0),
                  decoration: InputDecoration.collapsed(
                    hintText: 'Send a message',
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 0.4),
                child: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _isComposing
                      ? () => _handleSubmitted(_textEditingController.text)
                      : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _handleSubmitted(String text) {
    if (text.isNotEmpty) {
      _textEditingController.clear();
      ChatMessage message = new ChatMessage(
        text: text.trim(),
        animationController: AnimationController(
          duration: Duration(milliseconds: 400),
          vsync: this,
        ),
      );

      setState(() {
        _isComposing = !_isComposing;
        _message.insert(0, message);
      });
      message.animationController.forward();
    }
  }
}
