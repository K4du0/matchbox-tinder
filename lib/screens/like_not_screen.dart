import 'package:flutter/material.dart';
import '../widgets/top_navigation.dart';
import '../widgets/twin_dot.dart';
import '../themes/app_colors.dart';
import '../models/profile.dart';

class LikeScreen extends StatefulWidget {
  const LikeScreen({super.key});

  @override
  State<LikeScreen> createState() => _LikeScreenState();
}

class _LikeScreenState extends State<LikeScreen> {
  final PageController _pageController = PageController();

  // Local, in-memory list of candidates. `mockProfiles` stands in for a
  // future API/database call — everything past this line only ever reads
  // `Profile` objects, so swapping the source later doesn't touch the UI.
  final List<Profile> _profiles = List.of(mockProfiles);

  int _currentIndex = 0;

  // Kept for future use (e.g. a real Matches screen) without adding any
  // UI right now, per the current scope.
  final List<Profile> _likedProfiles = [];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  bool get _isLastProfile => _currentIndex >= _profiles.length - 1;

  void _goToNextProfile() {
    if (_isLastProfile) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("That's everyone for now!")),
      );
      return;
    }
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void _handleLike(Profile profile) {
    setState(() => _likedProfiles.add(profile));
    _goToNextProfile();
  }

  void _handleNot(Profile profile) {
    _goToNextProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const TopNavigation(selectedIndex: 0),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _profiles.length,
              onPageChanged: (index) => setState(() => _currentIndex = index),
              itemBuilder: (context, index) {
                final profile = _profiles[index];
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      _ProfileCard(profile: profile),

                      const SizedBox(height: 12),

                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () => _handleLike(profile),
                              icon: const Icon(Icons.thumb_up),
                              label: const Text('Like'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.blue,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 8),

                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () => _handleNot(profile),
                              icon: const Icon(Icons.thumb_down),
                              label: const Text('Not'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _CommonInfoBox(
                              title: 'Things In Common',
                              moreText: profile.thingsInCommonMoreText,
                              photoUrls: profile.thingsInCommonPhotos,
                            ),
                          ),

                          const SizedBox(width: 8),

                          Expanded(
                            child: _CommonInfoBox(
                              title: 'Friends In Common',
                              moreText: profile.friendsInCommonMoreText,
                              photoUrls: profile.friendsInCommonPhotos,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Photo + name + "friends & interests" line, framed as a bordered,
/// slightly rounded, slightly elevated card — matching the reference image.
class _ProfileCard extends StatelessWidget {
  final Profile profile;

  const _ProfileCard({required this.profile});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 670),
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: AppColors.cardBorder),
            boxShadow: const [
              BoxShadow(
                color: AppColors.cardShadow,
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          // Landscape-ish photo with the name and "friends & interests" line
          // overlaid directly on top of it, matching the reference image —
          // there is no separate text block below the photo.
          child: ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: AspectRatio(
              aspectRatio: 6 / 7,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    profile.photoUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return Container(
                        color: Colors.grey.shade300,
                        child: const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey.shade300,
                      child: const Icon(
                        Icons.person,
                        size: 100,
                        color: Colors.grey,
                      ),
                    ),
                  ),

                  Positioned(
                    top: 10,
                    left: 12,
                    right: 12,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          profile.name,
                          style: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                color: Colors.black54,
                                blurRadius: 4,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const TwinDot(),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                profile.subtitle,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black54,
                                      blurRadius: 4,
                                      offset: Offset(0, 1),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// "Things In Common" / "Friends In Common" panel: title, a 2x2 photo
/// collage, and a trailing "And N more..." line.
class _CommonInfoBox extends StatelessWidget {
  final String title;
  final String moreText;
  final List<String> photoUrls;

  const _CommonInfoBox({
    required this.title,
    required this.moreText,
    required this.photoUrls,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: const Color(0xFFF5F5F5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 8),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            childAspectRatio: 1.35,
            children: photoUrls
                .map(
                  (url) => ClipRRect(
                    borderRadius: BorderRadius.circular(2),
                    child: Image.network(
                      url,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey.shade300,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 8),
          Text(
            moreText,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
