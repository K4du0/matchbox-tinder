/// Data model for a single match candidate shown on the "Like or Not"
/// screen. Keeping this in one place (instead of spreading name/photo/etc.
/// across widgets) is what lets the screen work with several profiles now,
/// and later be pointed at an API/database without touching the UI code —
/// only where [mockProfiles] comes from would need to change.
class Profile {
  final String name;
  final int age;
  final String photoUrl;
  final int friendsInCommon;
  final int interestsInCommon;

  /// Thumbnail photos shown in the "Things In Common" box (reference image
  /// shows 4).
  final List<String> thingsInCommonPhotos;

  /// How many additional "things in common" exist beyond the thumbnails
  /// shown, e.g. 48 -> "And 48 more...".
  final int thingsInCommonMoreCount;

  /// Thumbnail photos shown in the "Friends In Common" box (reference image
  /// shows 4).
  final List<String> friendsInCommonPhotos;

  /// How many additional mutual friends exist beyond the thumbnails shown.
  final int friendsInCommonMoreCount;

  const Profile({
    required this.name,
    required this.age,
    required this.photoUrl,
    required this.friendsInCommon,
    required this.interestsInCommon,
    required this.thingsInCommonPhotos,
    required this.thingsInCommonMoreCount,
    required this.friendsInCommonPhotos,
    required this.friendsInCommonMoreCount,
  });

  String get subtitle =>
      '$friendsInCommon friends & $interestsInCommon interests in common';

  /// Shorter form used on the Matches list, e.g. "20 friends & 2 interests"
  /// (no trailing "in common" there, per the reference image).
  String get matchSubtitle =>
      '$friendsInCommon friends & $interestsInCommon interests';

  String get thingsInCommonMoreText => 'And $thingsInCommonMoreCount more...';

  String get friendsInCommonMoreText =>
      'And $friendsInCommonMoreCount more...';
}

/// NOTE: The project still has no `assets/` folder / local images declared
/// in pubspec.yaml, so every photo below is a network placeholder (Lorem
/// Picsum, seeded so each profile keeps a consistent picture). Once real
/// photos are added to the project (e.g. under `assets/images/`), replace
/// these URLs with the real asset paths — nothing else in the screen needs
/// to change, since it only reads from `Profile`.
const List<Profile> mockProfiles = [
  Profile(
    name: 'Brittany Michaels',
    age: 26,
    photoUrl: 'https://picsum.photos/seed/brittany/500/625',
    friendsInCommon: 20,
    interestsInCommon: 50,
    thingsInCommonPhotos: [
      'https://picsum.photos/seed/thing1/120',
      'https://picsum.photos/seed/thing2/120',
      'https://picsum.photos/seed/thing3/120',
      'https://picsum.photos/seed/thing4/120',
    ],
    thingsInCommonMoreCount: 48,
    friendsInCommonPhotos: [
      'https://picsum.photos/seed/friend1/120',
      'https://picsum.photos/seed/friend2/120',
      'https://picsum.photos/seed/friend3/120',
      'https://picsum.photos/seed/friend4/120',
    ],
    friendsInCommonMoreCount: 18,
  ),
  Profile(
    name: 'Sofia Ramirez',
    age: 24,
    photoUrl: 'https://picsum.photos/seed/sofia/500/625',
    friendsInCommon: 12,
    interestsInCommon: 33,
    thingsInCommonPhotos: [
      'https://picsum.photos/seed/thingA/120',
      'https://picsum.photos/seed/thingB/120',
      'https://picsum.photos/seed/thingC/120',
      'https://picsum.photos/seed/thingD/120',
    ],
    thingsInCommonMoreCount: 29,
    friendsInCommonPhotos: [
      'https://picsum.photos/seed/friendA/120',
      'https://picsum.photos/seed/friendB/120',
      'https://picsum.photos/seed/friendC/120',
      'https://picsum.photos/seed/friendD/120',
    ],
    friendsInCommonMoreCount: 9,
  ),
  Profile(
    name: 'Jessica Turner',
    age: 28,
    photoUrl: 'https://picsum.photos/seed/jessica/500/625',
    friendsInCommon: 7,
    interestsInCommon: 41,
    thingsInCommonPhotos: [
      'https://picsum.photos/seed/thingW/120',
      'https://picsum.photos/seed/thingX/120',
      'https://picsum.photos/seed/thingY/120',
      'https://picsum.photos/seed/thingZ/120',
    ],
    thingsInCommonMoreCount: 37,
    friendsInCommonPhotos: [
      'https://picsum.photos/seed/friendW/120',
      'https://picsum.photos/seed/friendX/120',
      'https://picsum.photos/seed/friendY/120',
      'https://picsum.photos/seed/friendZ/120',
    ],
    friendsInCommonMoreCount: 4,
  ),
];
