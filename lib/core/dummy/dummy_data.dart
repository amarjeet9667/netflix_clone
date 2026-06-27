// ============================================================
//  Netflix Clone — Dummy Data Layer
//  Used in Environment.test mode with dummyjson.com
//  Switch to real API responses in prod — shapes match exactly
// ============================================================

// ── 1. USERS / AUTH ─────────────────────────────────────────
// dummyjson.com/users  →  GET /users/:id
// dummyjson.com/auth   →  POST /auth/login
class DummyUsers {
  static const loginPayload = {
    'username': 'emilys',
    'password': 'emilyspass',
    'expiresInMins': 30,
  };

  static const Map<String, dynamic> loggedInUser = {
    'id': 1,
    'firstName': 'Emily',
    'lastName': 'Johnson',
    'email': 'emily.johnson@x.dummyjson.com',
    'phone': '+81 965-431-3024',
    'username': 'emilys',
    'gender': 'female',
    'image': 'https://dummyjson.com/icon/emilys/128',
    'token': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9',
  };

  // Multiple Netflix profiles under one account
  static const List<Map<String, dynamic>> profiles = [
    {
      'id': 'p1',
      'name': 'Emily',
      'avatar': 'https://dummyjson.com/icon/emilys/128',
      'isKids': false,
      'maturityRating': 'R',
      'language': 'en',
    },
    {
      'id': 'p2',
      'name': 'Kids',
      'avatar': 'https://dummyjson.com/icon/emilys/128',
      'isKids': true,
      'maturityRating': 'G',
      'language': 'en',
    },
    {
      'id': 'p3',
      'name': 'John',
      'avatar': 'https://dummyjson.com/icon/michaelw/128',
      'isKids': false,
      'maturityRating': 'PG-13',
      'language': 'en',
    },
  ];
}

// ── 2. MOVIES ────────────────────────────────────────────────
// dummyjson.com/products is used as a stand-in for movies
// Shape is normalised to match your MovieEntity
class DummyMovies {
  // GET dummyjson.com/products?limit=20&skip=0
  static const String moviesEndpoint = '/products';

  static const List<Map<String, dynamic>> movies = [
    {
      'id': 1,
      'title': 'Stranger Things: The Movie',
      'overview':
          'A group of kids in Hawkins uncover a secret government lab hiding supernatural horrors. When a boy vanishes, his friends and family fight to bring him home.',
      'posterUrl':
          'https://img.dummyjson.com/product-images/1/1.webp',
      'backdropUrl':
          'https://img.dummyjson.com/product-images/1/2.webp',
      'trailerUrl': 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      'rating': 8.7,
      'maturityRating': 'TV-14',
      'releaseYear': 2024,
      'duration': 148,
      'genres': ['Sci-Fi', 'Horror', 'Drama'],
      'cast': ['Millie Bobby Brown', 'Finn Wolfhard', 'Winona Ryder'],
      'director': 'The Duffer Brothers',
      'isNetflixOriginal': true,
      'isTrending': true,
      'isTopTen': true,
      'rank': 1,
    },
    {
      'id': 2,
      'title': 'The Crown: Final Chapter',
      'overview':
          'The gripping, decades-spanning inside story of Her Majesty Queen Elizabeth II and the Prime Ministers who shaped Britain\'s post-war destiny.',
      'posterUrl': 'https://img.dummyjson.com/product-images/2/1.webp',
      'backdropUrl': 'https://img.dummyjson.com/product-images/2/2.webp',
      'trailerUrl': 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      'rating': 8.9,
      'maturityRating': 'TV-MA',
      'releaseYear': 2023,
      'duration': 132,
      'genres': ['Drama', 'History', 'Biography'],
      'cast': ['Imelda Staunton', 'Jonathan Pryce', 'Elizabeth Debicki'],
      'director': 'Jessica Hobbs',
      'isNetflixOriginal': true,
      'isTrending': true,
      'isTopTen': true,
      'rank': 2,
    },
    {
      'id': 3,
      'title': 'Extraction 3',
      'overview':
          'Tyler Rake, a fearless black market mercenary, embarks on the most deadly extraction mission of his career when he\'s enlisted to rescue the kidnapped son of an imprisoned international crime lord.',
      'posterUrl': 'https://img.dummyjson.com/product-images/3/1.webp',
      'backdropUrl': 'https://img.dummyjson.com/product-images/3/2.webp',
      'trailerUrl': 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      'rating': 7.6,
      'maturityRating': 'R',
      'releaseYear': 2024,
      'duration': 123,
      'genres': ['Action', 'Thriller'],
      'cast': ['Chris Hemsworth', 'Golshifteh Farahani', 'Adam Bessa'],
      'director': 'Sam Hargrave',
      'isNetflixOriginal': true,
      'isTrending': true,
      'isTopTen': false,
      'rank': 5,
    },
    {
      'id': 4,
      'title': 'Squid Game: Season 3',
      'overview':
          'Hundreds of cash-strapped players accept a strange invitation to compete in children\'s games. Inside, a deadly survival game awaits with a 45.6 billion won prize at stake.',
      'posterUrl': 'https://img.dummyjson.com/product-images/4/1.webp',
      'backdropUrl': 'https://img.dummyjson.com/product-images/4/2.webp',
      'trailerUrl': 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      'rating': 9.1,
      'maturityRating': 'TV-MA',
      'releaseYear': 2024,
      'duration': 54,
      'genres': ['Thriller', 'Drama', 'Korean'],
      'cast': ['Lee Jung-jae', 'Park Hae-soo', 'Wi Ha-jun'],
      'director': 'Hwang Dong-hyuk',
      'isNetflixOriginal': true,
      'isTrending': true,
      'isTopTen': true,
      'rank': 3,
    },
    {
      'id': 5,
      'title': 'Wednesday: Season 2',
      'overview':
          'Follows Wednesday Addams\' years as a student at Nevermore Academy, where she attempts to master her emerging psychic ability, thwart a monstrous killing spree.',
      'posterUrl': 'https://img.dummyjson.com/product-images/5/1.webp',
      'backdropUrl': 'https://img.dummyjson.com/product-images/5/2.webp',
      'trailerUrl': 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      'rating': 8.1,
      'maturityRating': 'TV-14',
      'releaseYear': 2024,
      'duration': 45,
      'genres': ['Comedy', 'Fantasy', 'Mystery'],
      'cast': ['Jenna Ortega', 'Gwendoline Christie', 'Christina Ricci'],
      'director': 'Tim Burton',
      'isNetflixOriginal': true,
      'isTrending': false,
      'isTopTen': true,
      'rank': 4,
    },
    {
      'id': 6,
      'title': 'Money Heist: Berlin',
      'overview':
          'The Professor\'s brother Berlin and his eclectic crew pull off an elaborate jewel heist in Paris in this prequel to the global phenomenon.',
      'posterUrl': 'https://img.dummyjson.com/product-images/6/1.webp',
      'backdropUrl': 'https://img.dummyjson.com/product-images/6/2.webp',
      'trailerUrl': 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      'rating': 7.8,
      'maturityRating': 'TV-MA',
      'releaseYear': 2023,
      'duration': 50,
      'genres': ['Crime', 'Drama', 'Thriller'],
      'cast': ['Pedro Alonso', 'Michelle Jenner', 'Tristán Ulloa'],
      'director': 'Álex Pina',
      'isNetflixOriginal': true,
      'isTrending': false,
      'isTopTen': false,
      'rank': null,
    },
    {
      'id': 7,
      'title': 'The Night Agent: Season 2',
      'overview':
          'A low-level FBI agent works the night shift in the basement of the White House, monitoring a phone that never rings — until the night that it does.',
      'posterUrl': 'https://img.dummyjson.com/product-images/7/1.webp',
      'backdropUrl': 'https://img.dummyjson.com/product-images/7/2.webp',
      'trailerUrl': 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      'rating': 7.9,
      'maturityRating': 'TV-14',
      'releaseYear': 2024,
      'duration': 52,
      'genres': ['Action', 'Drama', 'Thriller'],
      'cast': ['Gabriel Basso', 'Luciane Buchanan', 'Hong Chau'],
      'director': 'Shawn Ryan',
      'isNetflixOriginal': true,
      'isTrending': true,
      'isTopTen': false,
      'rank': null,
    },
    {
      'id': 8,
      'title': 'Rebel Moon: Part Three',
      'overview':
          'A peaceful colony on the edge of the galaxy is threatened by the armies of a tyrannical regent. A mysterious stranger is tasked with finding warriors to help fight back.',
      'posterUrl': 'https://img.dummyjson.com/product-images/8/1.webp',
      'backdropUrl': 'https://img.dummyjson.com/product-images/8/2.webp',
      'trailerUrl': 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      'rating': 6.8,
      'maturityRating': 'PG-13',
      'releaseYear': 2024,
      'duration': 134,
      'genres': ['Sci-Fi', 'Action', 'Adventure'],
      'cast': ['Sofia Boutella', 'Charlie Hunnam', 'Djimon Hounsou'],
      'director': 'Zack Snyder',
      'isNetflixOriginal': true,
      'isTrending': false,
      'isTopTen': false,
      'rank': null,
    },
  ];

  // ── Top 10 shortlist ──
  static List<Map<String, dynamic>> get topTen =>
      movies.where((m) => m['isTopTen'] == true).toList()
        ..sort((a, b) => (a['rank'] as int).compareTo(b['rank'] as int));

  // ── Trending Now shortlist ──
  static List<Map<String, dynamic>> get trending =>
      movies.where((m) => m['isTrending'] == true).toList();
}

// ── 3. TV SHOWS / SERIES ─────────────────────────────────────
class DummyTVShows {
  static const List<Map<String, dynamic>> shows = [
    {
      'id': 101,
      'title': 'Stranger Things',
      'overview': 'When a boy vanishes, a small town uncovers a mystery involving secret experiments, terrifying supernatural forces and one strange little girl.',
      'posterUrl': 'https://img.dummyjson.com/product-images/9/1.webp',
      'backdropUrl': 'https://img.dummyjson.com/product-images/9/2.webp',
      'rating': 8.7,
      'maturityRating': 'TV-14',
      'releaseYear': 2016,
      'totalSeasons': 5,
      'totalEpisodes': 42,
      'genres': ['Sci-Fi', 'Horror', 'Drama'],
      'isNetflixOriginal': true,
      'status': 'Ended',
    },
    {
      'id': 102,
      'title': 'Ozark',
      'overview': 'A financial advisor drags his family from Chicago to the Missouri Ozarks, where he must launder money to appease a drug boss.',
      'posterUrl': 'https://img.dummyjson.com/product-images/10/1.webp',
      'backdropUrl': 'https://img.dummyjson.com/product-images/10/2.webp',
      'rating': 8.4,
      'maturityRating': 'TV-MA',
      'releaseYear': 2017,
      'totalSeasons': 4,
      'totalEpisodes': 44,
      'genres': ['Crime', 'Drama', 'Thriller'],
      'isNetflixOriginal': true,
      'status': 'Ended',
    },
    {
      'id': 103,
      'title': 'Dark',
      'overview': 'A missing child sets four families on a frantic hunt for answers in a German town, where the strange events reverberate through time across three generations.',
      'posterUrl': 'https://img.dummyjson.com/product-images/11/1.webp',
      'backdropUrl': 'https://img.dummyjson.com/product-images/11/2.webp',
      'rating': 8.8,
      'maturityRating': 'TV-MA',
      'releaseYear': 2017,
      'totalSeasons': 3,
      'totalEpisodes': 26,
      'genres': ['Sci-Fi', 'Thriller', 'Mystery'],
      'isNetflixOriginal': true,
      'status': 'Ended',
    },
  ];

  static const List<Map<String, dynamic>> seasons = [
    {
      'id': 's1',
      'showId': 101,
      'seasonNumber': 1,
      'title': 'Season 1',
      'episodeCount': 8,
      'releaseYear': 2016,
      'overview': 'A boy goes missing. His mother, a police chief and his friends search for answers.',
    },
    {
      'id': 's2',
      'showId': 101,
      'seasonNumber': 2,
      'title': 'Season 2',
      'episodeCount': 9,
      'releaseYear': 2017,
      'overview': 'Will struggles to adjust to normal life after returning from the Upside Down.',
    },
  ];

  static const List<Map<String, dynamic>> episodes = [
    {
      'id': 'e1',
      'seasonId': 's1',
      'showId': 101,
      'episodeNumber': 1,
      'title': 'Chapter One: The Vanishing of Will Byers',
      'overview': 'On his way home from a friend\'s house, young Will sees something terrifying.',
      'duration': 49,
      'stillUrl': 'https://img.dummyjson.com/product-images/12/1.webp',
      'hasBeenWatched': true,
      'watchProgress': 1.0,
    },
    {
      'id': 'e2',
      'seasonId': 's1',
      'showId': 101,
      'episodeNumber': 2,
      'title': 'Chapter Two: The Weirdo on Maple Street',
      'overview': 'Lucas, Mike and Dustin try to talk to the girl they found in the woods.',
      'duration': 55,
      'stillUrl': 'https://img.dummyjson.com/product-images/13/1.webp',
      'hasBeenWatched': true,
      'watchProgress': 0.6,
    },
    {
      'id': 'e3',
      'seasonId': 's1',
      'showId': 101,
      'episodeNumber': 3,
      'title': 'Chapter Three: Holly, Jolly',
      'overview': 'An increasingly concerned Joyce makes a chilling discovery.',
      'duration': 51,
      'stillUrl': 'https://img.dummyjson.com/product-images/14/1.webp',
      'hasBeenWatched': false,
      'watchProgress': 0.0,
    },
  ];
}

// ── 4. HERO BANNERS (Featured on Home screen) ─────────────────
class DummyBanners {
  static const List<Map<String, dynamic>> featuredBanners = [
    {
      'id': 'b1',
      'contentId': 4,
      'contentType': 'movie',
      'title': 'Squid Game: Season 3',
      'tagline': 'The final game begins.',
      'logoUrl': 'https://img.dummyjson.com/product-images/4/thumbnail.webp',
      'backdropUrl': 'https://img.dummyjson.com/product-images/4/2.webp',
      'videoPreviewUrl': 'https://www.w3schools.com/html/mov_bbb.mp4',
      'genres': ['Thriller', 'Drama'],
      'maturityRating': 'TV-MA',
      'isNetflixOriginal': true,
    },
    {
      'id': 'b2',
      'contentId': 1,
      'contentType': 'movie',
      'title': 'Stranger Things: The Movie',
      'tagline': 'Some doors should never be opened.',
      'logoUrl': 'https://img.dummyjson.com/product-images/1/thumbnail.webp',
      'backdropUrl': 'https://img.dummyjson.com/product-images/1/2.webp',
      'videoPreviewUrl': 'https://www.w3schools.com/html/mov_bbb.mp4',
      'genres': ['Sci-Fi', 'Horror'],
      'maturityRating': 'TV-14',
      'isNetflixOriginal': true,
    },
    {
      'id': 'b3',
      'contentId': 3,
      'contentType': 'movie',
      'title': 'Extraction 3',
      'tagline': 'No mission. No mercy. No way out.',
      'logoUrl': 'https://img.dummyjson.com/product-images/3/thumbnail.webp',
      'backdropUrl': 'https://img.dummyjson.com/product-images/3/2.webp',
      'videoPreviewUrl': 'https://www.w3schools.com/html/mov_bbb.mp4',
      'genres': ['Action', 'Thriller'],
      'maturityRating': 'R',
      'isNetflixOriginal': true,
    },
  ];
}

// ── 5. HOME SECTIONS (Content rows) ───────────────────────────
class DummyHomeSections {
  static List<Map<String, dynamic>> get sections => [
    {
      'id': 'sec_trending',
      'title': 'Trending Now',
      'type': 'trending',
      'displayStyle': 'numbered', // shows rank number on card
      'items': DummyMovies.trending,
    },
    {
      'id': 'sec_top10',
      'title': 'Top 10 in India Today',
      'type': 'top10',
      'displayStyle': 'numbered',
      'items': DummyMovies.topTen,
    },
    {
      'id': 'sec_originals',
      'title': 'Netflix Originals',
      'type': 'originals',
      'displayStyle': 'portrait_large',
      'items': DummyMovies.movies
          .where((m) => m['isNetflixOriginal'] == true)
          .toList(),
    },
    {
      'id': 'sec_continue',
      'title': 'Continue Watching for Emily',
      'type': 'continue_watching',
      'displayStyle': 'landscape_progress',
      'items': DummyContinueWatching.items,
    },
    {
      'id': 'sec_action',
      'title': 'Action & Adventure',
      'type': 'genre',
      'displayStyle': 'landscape',
      'items': DummyMovies.movies
          .where((m) => (m['genres'] as List).contains('Action'))
          .toList(),
    },
    {
      'id': 'sec_scifi',
      'title': 'Sci-Fi & Fantasy',
      'type': 'genre',
      'displayStyle': 'landscape',
      'items': DummyMovies.movies
          .where((m) => (m['genres'] as List).contains('Sci-Fi'))
          .toList(),
    },
    {
      'id': 'sec_korean',
      'title': 'K-Dramas',
      'type': 'genre',
      'displayStyle': 'portrait',
      'items': DummyMovies.movies
          .where((m) => (m['genres'] as List).contains('Korean'))
          .toList(),
    },
    {
      'id': 'sec_mylist',
      'title': 'My List',
      'type': 'my_list',
      'displayStyle': 'landscape',
      'items': DummyWatchlist.items.map((w) => w['content'] as Map<String, dynamic>).toList(),
    },
  ];
}

// ── 6. GENRES ─────────────────────────────────────────────────
class DummyGenres {
  static const List<Map<String, dynamic>> genres = [
    {'id': 'g1',  'name': 'Action',         'icon': '💥'},
    {'id': 'g2',  'name': 'Adventure',      'icon': '🗺️'},
    {'id': 'g3',  'name': 'Animation',      'icon': '🎨'},
    {'id': 'g4',  'name': 'Anime',          'icon': '⛩️'},
    {'id': 'g5',  'name': 'Biography',      'icon': '📖'},
    {'id': 'g6',  'name': 'Children',       'icon': '🧸'},
    {'id': 'g7',  'name': 'Comedy',         'icon': '😂'},
    {'id': 'g8',  'name': 'Crime',          'icon': '🔫'},
    {'id': 'g9',  'name': 'Documentary',    'icon': '🎥'},
    {'id': 'g10', 'name': 'Drama',          'icon': '🎭'},
    {'id': 'g11', 'name': 'Fantasy',        'icon': '🧙'},
    {'id': 'g12', 'name': 'History',        'icon': '🏛️'},
    {'id': 'g13', 'name': 'Horror',         'icon': '👻'},
    {'id': 'g14', 'name': 'Korean',         'icon': '🇰🇷'},
    {'id': 'g15', 'name': 'Mystery',        'icon': '🔍'},
    {'id': 'g16', 'name': 'Romance',        'icon': '❤️'},
    {'id': 'g17', 'name': 'Sci-Fi',         'icon': '🚀'},
    {'id': 'g18', 'name': 'Sports',         'icon': '⚽'},
    {'id': 'g19', 'name': 'Stand-up',       'icon': '🎤'},
    {'id': 'g20', 'name': 'Thriller',       'icon': '😱'},
  ];
}

// ── 7. CONTINUE WATCHING ──────────────────────────────────────
class DummyContinueWatching {
  static const List<Map<String, dynamic>> items = [
    {
      'id': 'cw1',
      'contentId': 1,
      'contentType': 'movie',
      'title': 'Stranger Things: The Movie',
      'thumbnailUrl': 'https://img.dummyjson.com/product-images/1/1.webp',
      'progressSeconds': 3540,   // 59 min watched
      'totalSeconds': 8880,      // 148 min total
      'progressPercent': 0.40,
      'remainingLabel': '1h 29m remaining',
    },
    {
      'id': 'cw2',
      'contentId': 101,
      'contentType': 'series',
      'title': 'Stranger Things',
      'episodeLabel': 'S1:E3 • Holly, Jolly',
      'thumbnailUrl': 'https://img.dummyjson.com/product-images/14/1.webp',
      'progressSeconds': 1224,   // ~20 min
      'totalSeconds': 3060,      // 51 min
      'progressPercent': 0.40,
      'remainingLabel': '31m remaining',
    },
    {
      'id': 'cw3',
      'contentId': 3,
      'contentType': 'movie',
      'title': 'Extraction 3',
      'thumbnailUrl': 'https://img.dummyjson.com/product-images/3/1.webp',
      'progressSeconds': 1260,
      'totalSeconds': 7380,
      'progressPercent': 0.17,
      'remainingLabel': '1h 42m remaining',
    },
  ];
}

// ── 8. WATCHLIST / MY LIST ────────────────────────────────────
class DummyWatchlist {
  static const List<Map<String, dynamic>> items = [
    {
      'id': 'wl1',
      'addedAt': '2024-11-01T10:00:00Z',
      'content': {
        'id': 4,
        'title': 'Squid Game: Season 3',
        'posterUrl': 'https://img.dummyjson.com/product-images/4/1.webp',
        'contentType': 'movie',
        'rating': 9.1,
      },
    },
    {
      'id': 'wl2',
      'addedAt': '2024-10-20T14:00:00Z',
      'content': {
        'id': 102,
        'title': 'Ozark',
        'posterUrl': 'https://img.dummyjson.com/product-images/10/1.webp',
        'contentType': 'series',
        'rating': 8.4,
      },
    },
    {
      'id': 'wl3',
      'addedAt': '2024-10-15T09:00:00Z',
      'content': {
        'id': 5,
        'title': 'Wednesday: Season 2',
        'posterUrl': 'https://img.dummyjson.com/product-images/5/1.webp',
        'contentType': 'movie',
        'rating': 8.1,
      },
    },
  ];
}

// ── 9. SEARCH RESULTS ─────────────────────────────────────────
// dummyjson.com/products/search?q=:query
class DummySearch {
  static const String searchEndpoint = '/products/search';

  static List<Map<String, dynamic>> search(String query) {
    final q = query.toLowerCase();
    return [
      ...DummyMovies.movies,
      ...DummyTVShows.shows,
    ]
        .where((item) =>
            (item['title'] as String).toLowerCase().contains(q) ||
            (item['genres'] as List)
                .any((g) => (g as String).toLowerCase().contains(q)))
        .toList();
  }
}

// ── 10. NOTIFICATIONS ─────────────────────────────────────────
class DummyNotifications {
  static const List<Map<String, dynamic>> notifications = [
    {
      'id': 'n1',
      'type': 'new_episode',
      'title': 'New episode available',
      'body': 'Squid Game S3 E4 is now available. Watch now!',
      'imageUrl': 'https://img.dummyjson.com/product-images/4/1.webp',
      'contentId': 4,
      'isRead': false,
      'createdAt': '2024-11-14T08:00:00Z',
    },
    {
      'id': 'n2',
      'type': 'new_release',
      'title': 'Just added',
      'body': 'Wednesday Season 2 is now streaming.',
      'imageUrl': 'https://img.dummyjson.com/product-images/5/1.webp',
      'contentId': 5,
      'isRead': false,
      'createdAt': '2024-11-12T10:00:00Z',
    },
    {
      'id': 'n3',
      'type': 'reminder',
      'title': 'Continue watching',
      'body': 'You\'re 40% through Extraction 3. Pick up where you left off.',
      'imageUrl': 'https://img.dummyjson.com/product-images/3/1.webp',
      'contentId': 3,
      'isRead': true,
      'createdAt': '2024-11-10T19:00:00Z',
    },
  ];
}

// ── 11. DOWNLOADS ─────────────────────────────────────────────
class DummyDownloads {
  static const List<Map<String, dynamic>> downloads = [
    {
      'id': 'd1',
      'contentId': 4,
      'contentType': 'movie',
      'title': 'Squid Game: Season 3',
      'thumbnailUrl': 'https://img.dummyjson.com/product-images/4/1.webp',
      'quality': 'HD',
      'fileSizeMB': 1240,
      'status': 'completed',
      'downloadedAt': '2024-11-10T08:00:00Z',
      'expiresAt': '2024-12-10T08:00:00Z',
    },
    {
      'id': 'd2',
      'contentId': 2,
      'contentType': 'movie',
      'title': 'The Crown: Final Chapter',
      'thumbnailUrl': 'https://img.dummyjson.com/product-images/2/1.webp',
      'quality': 'SD',
      'fileSizeMB': 680,
      'status': 'downloading',
      'progressPercent': 0.62,
      'downloadedAt': null,
      'expiresAt': null,
    },
  ];
}