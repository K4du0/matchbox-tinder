import 'package:flutter/material.dart';
import '../themes/app_colors.dart';
import '../models/profile.dart';
import '../models/message.dart';

/// Individual conversation with a single match. Reached by tapping a row on
/// the Matches screen (`Navigator.push`, not a named route — no second
/// navigation system, just the existing `Navigator`). Unlike the other
/// three screens, this one does not show the shared [TopNavigation] tab
/// bar: the reference image replaces it with its own header (Back + name),
/// which is normal for a drill-down/detail screen.
class DirectScreen extends StatefulWidget {
  final Profile match;

  const DirectScreen({super.key, required this.match});

  @override
  State<DirectScreen> createState() => _DirectScreenState();
}

class _DirectScreenState extends State<DirectScreen> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late final List<Message> _messages;

  @override
  void initState() {
    super.initState();
    // Copy so this conversation's local edits don't mutate the shared mock
    // data if the same match is opened again.
    _messages = List.of(mockConversations[widget.match.name] ?? const []);
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  void _handleSend() {
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(
        Message(
          senderName: currentUserName,
          senderPhotoUrl: currentUserPhotoUrl,
          content: text,
          timestamp: 'Just now',
          isMe: true,
        ),
      );
    });
    _textController.clear();
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _DirectHeader(name: widget.match.name),
            Container(height: 1, color: Colors.grey.shade300),

            Expanded(
              child: _messages.isEmpty
                  ? Center(
                      child: Text(
                        'Say hi to ${widget.match.name}!',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(16),
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        return _MessageRow(message: _messages[index]);
                      },
                    ),
            ),

            _ComposeBar(
              controller: _textController,
              onSend: _handleSend,
            ),
          ],
        ),
      ),
    );
  }
}

/// Back button (arrow/tag shape) + conversation partner's name, replacing
/// the tab bar on this screen.
class _DirectHeader extends StatelessWidget {
  final String name;

  const _DirectHeader({required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFEDEBE9),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          _BackButton(onTap: () => Navigator.pop(context)),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF666666),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// The pointed "tag" shaped Back button from the reference image — a
/// pentagon (rectangle with a leftward point) with a light-to-dark gradient
/// fill, deliberately not swapped for a generic Material back icon.
class _BackButton extends StatelessWidget {
  final VoidCallback onTap;

  const _BackButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    const size = Size(78, 30);
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(size: size, painter: _BackButtonPainter()),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Back',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  shadows: [
                    Shadow(color: Colors.black45, offset: Offset(0, 1)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BackButtonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final pointCut = size.height / 2;
    final path = Path()
      ..moveTo(pointCut, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(pointCut, size.height)
      ..lineTo(0, size.height / 2)
      ..close();

    final fill = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFD6D2C4), Color(0xFF7E7160)],
      ).createShader(Offset.zero & size);

    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = const Color(0xFF5A4F42);

    canvas.drawPath(path, fill);
    canvas.drawPath(path, stroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// One chat message: small avatar, then sender name + timestamp on one
/// line, with the message text below. Every message uses the same layout
/// regardless of sender — the reference identifies who's talking only via
/// name + photo, not through left/right bubble alignment.
class _MessageRow extends StatelessWidget {
  final Message message;

  const _MessageRow({required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: Image.network(
              message.senderPhotoUrl,
              width: 42,
              height: 38,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 42,
                height: 38,
                color: Colors.grey.shade300,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        message.senderName,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Color(0xFF444444),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      message.timestamp,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  message.content,
                  style: const TextStyle(
                    color: Color(0xFF777777),
                    fontSize: 14,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Bottom text field + Send button.
class _ComposeBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const _ComposeBar({required this.controller, required this.onSend});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
      decoration: BoxDecoration(
        color: const Color(0xFFE4E2DF),
        border: Border(top: BorderSide(color: Colors.grey.shade400)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 34,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: TextField(
                controller: controller,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => onSend(),
                decoration: const InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  hintText: 'Type a message...',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: onSend,
            child: Container(
              height: 34,
              padding: const EdgeInsets.symmetric(horizontal: 18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF5FCBEF), AppColors.blue],
                ),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: const Color(0xFF1A87A8)),
              ),
              alignment: Alignment.center,
              child: const Text(
                'Send',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
