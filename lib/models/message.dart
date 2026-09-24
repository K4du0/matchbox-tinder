
class Message {
  final String senderName;
  final String senderPhotoUrl;
  final String content;


  final String timestamp;

  
  final bool isMe;

  const Message({
    required this.senderName,
    required this.senderPhotoUrl,
    required this.content,
    required this.timestamp,
    this.isMe = false,
  });
}


const String currentUserName = 'Matt Pouldar';
const String currentUserPhotoUrl = 'https://picsum.photos/seed/mattpouldar/120';


final Map<String, List<Message>> mockConversations = {
  'Brittany Michaels': [
    const Message(
      senderName: 'Matt Pouldar',
      senderPhotoUrl: currentUserPhotoUrl,
      content: 'Hey Brittany! Looks like we have so much in common. '
          'Great to meet you!',
      timestamp: '2 min ago',
    ),
    const Message(
      senderName: 'Brittany Michaels',
      senderPhotoUrl: 'https://picsum.photos/seed/brittany/120',
      content: 'Heyyyy. Haha, yes we do. Wow this MatchBox thing is '
          'amazing! Surprised it works.',
      timestamp: '1 min ago',
    ),
    const Message(
      senderName: 'Matt Pouldar',
      senderPhotoUrl: currentUserPhotoUrl,
      content: "Well, we're already getting along, so yes, I guess this "
          'thing does really work!',
      timestamp: '1 min ago',
    ),
  ],
};
