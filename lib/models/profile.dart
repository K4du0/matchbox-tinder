class Profile {
  final String name;
  final int age;
  final String photoUrl;
  final int friendsInCommon;
  final int interestsInCommon;


  final List<String> thingsInCommonPhotos;


  final int thingsInCommonMoreCount;


  final List<String> friendsInCommonPhotos;


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


  String get matchSubtitle =>
      '$friendsInCommon friends & $interestsInCommon interests';

  String get thingsInCommonMoreText => 'And $thingsInCommonMoreCount more...';

  String get friendsInCommonMoreText =>
      'And $friendsInCommonMoreCount more...';
}


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
