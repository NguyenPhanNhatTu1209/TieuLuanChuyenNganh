class User {
  final int id;
  final String name;
  final String imageUrl;
  final bool isOnline;

  User({
    this.id,
    this.name,
    this.imageUrl,
    this.isOnline,
  });
}

// YOU - current user
final User currentUser = User(
  id: 0,
  name: 'Nick Fury',
  imageUrl:
      'https://vcdn-giaitri.vnecdn.net/2018/07/27/tom-cruise-joins-instagram-2033-1532682112.jpg',
  isOnline: true,
);

// USERS
final User ironMan = User(
  id: 1,
  name: 'Iron Man',
  imageUrl:
      'https://marvelvietnam.com/wp-content/uploads/2021/06/Iron-Man-4-905x613.jpg',
  isOnline: true,
);
final User captainAmerica = User(
  id: 2,
  name: 'Captain America',
  imageUrl:
      'https://vcdn-giaitri.vnecdn.net/2018/07/27/tom-cruise-joins-instagram-2033-1532682112.jpg',
  isOnline: true,
);
final User hulk = User(
  id: 3,
  name: 'Hulk',
  imageUrl:
      'https://vcdn-giaitri.vnecdn.net/2018/07/27/tom-cruise-joins-instagram-2033-1532682112.jpg',
  isOnline: false,
);
final User scarletWitch = User(
  id: 4,
  name: 'Scarlet Witch',
  imageUrl:
      'https://vcdn-giaitri.vnecdn.net/2018/07/27/tom-cruise-joins-instagram-2033-1532682112.jpg',
  isOnline: false,
);
final User spiderMan = User(
  id: 5,
  name: 'Spider Man',
  imageUrl:
      'https://vcdn-giaitri.vnecdn.net/2018/07/27/tom-cruise-joins-instagram-2033-1532682112.jpg',
  isOnline: true,
);
final User blackWindow = User(
  id: 6,
  name: 'Black Widow',
  imageUrl:
      'https://vcdn-giaitri.vnecdn.net/2018/07/27/tom-cruise-joins-instagram-2033-1532682112.jpg',
  isOnline: false,
);
final User thor = User(
  id: 7,
  name: 'Thor',
  imageUrl:
      'https://vcdn-giaitri.vnecdn.net/2018/07/27/tom-cruise-joins-instagram-2033-1532682112.jpg',
  isOnline: false,
);
final User captainMarvel = User(
  id: 8,
  name: 'Captain Marvel',
  imageUrl:
      'https://vcdn-giaitri.vnecdn.net/2018/07/27/tom-cruise-joins-instagram-2033-1532682112.jpg',
  isOnline: false,
);
