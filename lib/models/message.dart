/// A single message inside a Direct conversation.
class Message {
  final String senderName;
  final String senderPhotoUrl;
  final String content;

  /// Display string, matching the reference ("2 min ago", "Just now"...).
  /// Kept as plain text rather than a computed DateTime diff since there is
  /// no backend/clock source yet — see the "possible improvements" note in
  /// the implementation report.
  final String timestamp;

  /// Whether this message was sent by the app's current user. Not used for
  /// bubble alignment (the reference shows every message the same way,
  /// identified only by name + photo) — kept so the compose field knows
  /// which name/photo to attach to a new message, and so a future redesign
  /// could use it without changing the data layer.
  final bool isMe;

  const Message({
    required this.senderName,
    required this.senderPhotoUrl,
    required this.content,
    required this.timestamp,
    this.isMe = false,
  });
}

/// Stand-in identity for the app's own user when composing a new message.
/// The reference conversation is between "Brittany Michaels" (a match) and
/// "Matt Pouldar" — since the project has no login/user-profile system yet,
/// "Matt Pouldar" is reused here as that same placeholder identity rather
/// than inventing a generic "You" that doesn't appear in the reference.
const String currentUserName = 'Matt Pouldar';
const String currentUserPhotoUrl = 'https://picsum.photos/seed/mattpouldar/120';

/// Mocked opening messages per match, keyed by [Profile.name]. Matches with
/// no entry here just start an empty conversation. Swapping this for a real
/// backend later only means changing where this map's data comes from.
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
