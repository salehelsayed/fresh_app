import 'package:flutter/material.dart';
import '../widgets/bottom_navigation_bar.dart';
import 'package:go_router/go_router.dart';

class Message {
  final String text;
  final String sender;
  final DateTime timestamp;
  final bool isMe;

  Message({
    required this.text,
    required this.sender,
    required this.timestamp,
    required this.isMe,
  });
}

class FeedPage extends StatefulWidget {
  final String channelId;
  final String channelName;

  const FeedPage({
    super.key,
    required this.channelId,
    required this.channelName,
  });

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final List<Message> _messages = [
    Message(
      text: "Hey everyone! Welcome to the channel! 👋",
      sender: "Alice",
      timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
      isMe: false,
    ),
    Message(
      text: "Thanks for having us! Excited to be here 🎉",
      sender: "Bob",
      timestamp: DateTime.now().subtract(const Duration(minutes: 25)),
      isMe: true,
    ),
    Message(
      text: "Has anyone tried the new feature?",
      sender: "Charlie",
      timestamp: DateTime.now().subtract(const Duration(minutes: 20)),
      isMe: false,
    ),
    Message(
      text: "Yes! It's amazing! Really improved my workflow.",
      sender: "Bob",
      timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
      isMe: true,
    ),
    Message(
      text: "I can help you set it up if you need assistance.",
      sender: "Alice",
      timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
      isMe: false,
    ),
  ];

  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      _messages.add(Message(
        text: _messageController.text,
        sender: "Bob",
        timestamp: DateTime.now(),
        isMe: true,
      ));
    });
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.channelName),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => context.push('/filter'),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              itemBuilder: (context, index) {
                final message = _messages[_messages.length - 1 - index];
                return MessageBubble(
                  message: message.text,
                  isMe: message.isMe,
                  timestamp: message.timestamp,
                  sender: message.sender,
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, -2),
                  blurRadius: 4,
                  color: Colors.black.withOpacity(0.1),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        hintText: 'Type a message...',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: _sendMessage,
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const AppBottomNavigationBar(currentIndex: 2),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final DateTime timestamp;
  final String sender;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isMe,
    required this.timestamp,
    required this.sender,
  });

  String _formatTime(DateTime time) {
    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMe) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.grey[300],
              child: Text(
                sender[0].toUpperCase(),
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.75,
                  ),
                  decoration: BoxDecoration(
                    color: isMe ? Theme.of(context).primaryColor : Colors.grey[300],
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(16),
                      topRight: const Radius.circular(16),
                      bottomLeft: Radius.circular(isMe ? 16 : 4),
                      bottomRight: Radius.circular(isMe ? 4 : 16),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message,
                        style: TextStyle(
                          color: isMe ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _formatTime(timestamp),
                        style: TextStyle(
                          color: isMe ? Colors.white70 : Colors.black54,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (isMe) ...[
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.grey[300],
              child: Text(
                sender[0].toUpperCase(),
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
