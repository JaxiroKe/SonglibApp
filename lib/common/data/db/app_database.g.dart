// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  BooksDao? _booksDaoInstance;

  DraftsDao? _draftsDaoInstance;

  EditsDao? _editsDaoInstance;

  HistoriesDao? _historiesDaoInstance;

  ListedsDao? _listedsDaoInstance;

  SearchesDao? _searchesDaoInstance;

  SongsDao? _songsDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 2,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `books` (`rid` INTEGER PRIMARY KEY AUTOINCREMENT, `bookId` INTEGER, `title` TEXT, `subTitle` TEXT, `songs` INTEGER, `position` INTEGER, `bookNo` INTEGER, `enabled` INTEGER, `created` TEXT, `updated` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `drafts` (`rid` INTEGER PRIMARY KEY AUTOINCREMENT, `songId` INTEGER, `songNo` INTEGER, `title` TEXT, `alias` TEXT, `content` TEXT, `views` INTEGER, `likes` INTEGER, `liked` INTEGER, `created` TEXT, `updated` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `edits` (`rid` INTEGER PRIMARY KEY AUTOINCREMENT, `song` TEXT, `book` INTEGER, `songNo` INTEGER, `title` TEXT, `alias` TEXT, `content` TEXT, `key` TEXT, `created` TEXT, `updated` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `histories` (`rid` INTEGER PRIMARY KEY AUTOINCREMENT, `song` INTEGER, `created` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `listeds` (`rid` INTEGER PRIMARY KEY AUTOINCREMENT, `parentid` INTEGER, `song` INTEGER, `title` TEXT, `description` TEXT, `position` INTEGER, `created` TEXT, `updated` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `searches` (`rid` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT, `created` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `songs` (`rid` INTEGER PRIMARY KEY AUTOINCREMENT, `book` INTEGER, `songId` INTEGER, `songNo` INTEGER, `title` TEXT, `alias` TEXT, `content` TEXT, `views` INTEGER, `likes` INTEGER, `liked` INTEGER, `created` TEXT, `updated` TEXT)');

        await database.execute(
            'CREATE VIEW IF NOT EXISTS `viewhistories` AS SELECT s.rid, s.book, s.songId, s.songNo, s.title, s.alias, s.content, s.views, s.likes, s.liked, b.title AS songbook FROM songs AS s LEFT JOIN books AS b ON s.book=b.bookNo ORDER BY songNo ASC;');
        await database.execute(
            'CREATE VIEW IF NOT EXISTS `viewlisteds` AS SELECT l.parentid, l.id, l.position, l.id, l.created, l.updated, l.song, s.book, s.songNo, s.title, s.alias, s.content, s.views, s.likes, s.liked, s.id AS songId, b.title AS songbook FROM listeds AS l LEFT JOIN songs AS s ON l.song=s.id LEFT JOIN books AS b ON s.book=b.bookNo ORDER BY l.updated DESC;');
        await database.execute(
            'CREATE VIEW IF NOT EXISTS `viewsongs` AS SELECT s.rid, s.book, s.songId, s.songNo, s.title, s.alias, s.content, s.views, s.likes, s.liked, b.title AS songbook FROM songs AS s LEFT JOIN books AS b ON s.book=b.bookNo ORDER BY songNo ASC;');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  BooksDao get booksDao {
    return _booksDaoInstance ??= _$BooksDao(database, changeListener);
  }

  @override
  DraftsDao get draftsDao {
    return _draftsDaoInstance ??= _$DraftsDao(database, changeListener);
  }

  @override
  EditsDao get editsDao {
    return _editsDaoInstance ??= _$EditsDao(database, changeListener);
  }

  @override
  HistoriesDao get historiesDao {
    return _historiesDaoInstance ??= _$HistoriesDao(database, changeListener);
  }

  @override
  ListedsDao get listedsDao {
    return _listedsDaoInstance ??= _$ListedsDao(database, changeListener);
  }

  @override
  SearchesDao get searchesDao {
    return _searchesDaoInstance ??= _$SearchesDao(database, changeListener);
  }

  @override
  SongsDao get songsDao {
    return _songsDaoInstance ??= _$SongsDao(database, changeListener);
  }
}

class _$BooksDao extends BooksDao {
  _$BooksDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _bookInsertionAdapter = InsertionAdapter(
            database,
            'books',
            (Book item) => <String, Object?>{
                  'rid': item.rid,
                  'bookId': item.bookId,
                  'title': item.title,
                  'subTitle': item.subTitle,
                  'songs': item.songs,
                  'position': item.position,
                  'bookNo': item.bookNo,
                  'enabled':
                      item.enabled == null ? null : (item.enabled! ? 1 : 0),
                  'created': item.created,
                  'updated': item.updated
                },
            changeListener),
        _bookUpdateAdapter = UpdateAdapter(
            database,
            'books',
            ['rid'],
            (Book item) => <String, Object?>{
                  'rid': item.rid,
                  'bookId': item.bookId,
                  'title': item.title,
                  'subTitle': item.subTitle,
                  'songs': item.songs,
                  'position': item.position,
                  'bookNo': item.bookNo,
                  'enabled':
                      item.enabled == null ? null : (item.enabled! ? 1 : 0),
                  'created': item.created,
                  'updated': item.updated
                },
            changeListener),
        _bookDeletionAdapter = DeletionAdapter(
            database,
            'books',
            ['rid'],
            (Book item) => <String, Object?>{
                  'rid': item.rid,
                  'bookId': item.bookId,
                  'title': item.title,
                  'subTitle': item.subTitle,
                  'songs': item.songs,
                  'position': item.position,
                  'bookNo': item.bookNo,
                  'enabled':
                      item.enabled == null ? null : (item.enabled! ? 1 : 0),
                  'created': item.created,
                  'updated': item.updated
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Book> _bookInsertionAdapter;

  final UpdateAdapter<Book> _bookUpdateAdapter;

  final DeletionAdapter<Book> _bookDeletionAdapter;

  @override
  Future<Book?> findBookById(int rid) async {
    return _queryAdapter.query('SELECT * FROM books WHERE rid = ?1',
        mapper: (Map<String, Object?> row) => Book(
            bookId: row['bookId'] as int?,
            title: row['title'] as String?,
            subTitle: row['subTitle'] as String?,
            songs: row['songs'] as int?,
            position: row['position'] as int?,
            bookNo: row['bookNo'] as int?,
            enabled:
                row['enabled'] == null ? null : (row['enabled'] as int) != 0,
            created: row['created'] as String?,
            updated: row['updated'] as String?),
        arguments: [rid]);
  }

  @override
  Future<List<Book>> fetchBooks() async {
    return _queryAdapter.queryList('SELECT * FROM books',
        mapper: (Map<String, Object?> row) => Book(
            bookId: row['bookId'] as int?,
            title: row['title'] as String?,
            subTitle: row['subTitle'] as String?,
            songs: row['songs'] as int?,
            position: row['position'] as int?,
            bookNo: row['bookNo'] as int?,
            enabled:
                row['enabled'] == null ? null : (row['enabled'] as int) != 0,
            created: row['created'] as String?,
            updated: row['updated'] as String?));
  }

  @override
  Future<void> deleteAllBooks() async {
    await _queryAdapter.queryNoReturn('DELETE FROM books');
  }

  @override
  Future<void> insertBook(Book book) async {
    await _bookInsertionAdapter.insert(book, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateBook(Book book) async {
    await _bookUpdateAdapter.update(book, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteBook(Book book) async {
    await _bookDeletionAdapter.delete(book);
  }
}

class _$DraftsDao extends DraftsDao {
  _$DraftsDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _draftInsertionAdapter = InsertionAdapter(
            database,
            'drafts',
            (Draft item) => <String, Object?>{
                  'rid': item.rid,
                  'songId': item.songId,
                  'songNo': item.songNo,
                  'title': item.title,
                  'alias': item.alias,
                  'content': item.content,
                  'views': item.views,
                  'likes': item.likes,
                  'liked': item.liked == null ? null : (item.liked! ? 1 : 0),
                  'created': item.created,
                  'updated': item.updated
                },
            changeListener),
        _draftUpdateAdapter = UpdateAdapter(
            database,
            'drafts',
            ['rid'],
            (Draft item) => <String, Object?>{
                  'rid': item.rid,
                  'songId': item.songId,
                  'songNo': item.songNo,
                  'title': item.title,
                  'alias': item.alias,
                  'content': item.content,
                  'views': item.views,
                  'likes': item.likes,
                  'liked': item.liked == null ? null : (item.liked! ? 1 : 0),
                  'created': item.created,
                  'updated': item.updated
                },
            changeListener),
        _draftDeletionAdapter = DeletionAdapter(
            database,
            'drafts',
            ['rid'],
            (Draft item) => <String, Object?>{
                  'rid': item.rid,
                  'songId': item.songId,
                  'songNo': item.songNo,
                  'title': item.title,
                  'alias': item.alias,
                  'content': item.content,
                  'views': item.views,
                  'likes': item.likes,
                  'liked': item.liked == null ? null : (item.liked! ? 1 : 0),
                  'created': item.created,
                  'updated': item.updated
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Draft> _draftInsertionAdapter;

  final UpdateAdapter<Draft> _draftUpdateAdapter;

  final DeletionAdapter<Draft> _draftDeletionAdapter;

  @override
  Future<Draft?> findDraftById(int rid) async {
    return _queryAdapter.query('SELECT * FROM drafts WHERE rid = ?1',
        mapper: (Map<String, Object?> row) => Draft(
            rid: row['rid'] as int?,
            songId: row['songId'] as int?,
            songNo: row['songNo'] as int?,
            title: row['title'] as String?,
            alias: row['alias'] as String?,
            content: row['content'] as String?,
            views: row['views'] as int?,
            likes: row['likes'] as int?,
            liked: row['liked'] == null ? null : (row['liked'] as int) != 0,
            created: row['created'] as String?,
            updated: row['updated'] as String?),
        arguments: [rid]);
  }

  @override
  Future<List<Draft>> fetchDrafts() async {
    return _queryAdapter.queryList('SELECT * FROM drafts',
        mapper: (Map<String, Object?> row) => Draft(
            rid: row['rid'] as int?,
            songId: row['songId'] as int?,
            songNo: row['songNo'] as int?,
            title: row['title'] as String?,
            alias: row['alias'] as String?,
            content: row['content'] as String?,
            views: row['views'] as int?,
            likes: row['likes'] as int?,
            liked: row['liked'] == null ? null : (row['liked'] as int) != 0,
            created: row['created'] as String?,
            updated: row['updated'] as String?));
  }

  @override
  Future<void> deleteAllDrafts() async {
    await _queryAdapter.queryNoReturn('DELETE FROM drafts');
  }

  @override
  Future<void> insertDraft(Draft draft) async {
    await _draftInsertionAdapter.insert(draft, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateDraft(Draft draft) async {
    await _draftUpdateAdapter.update(draft, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteDraft(Draft draft) async {
    await _draftDeletionAdapter.delete(draft);
  }
}

class _$EditsDao extends EditsDao {
  _$EditsDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _editInsertionAdapter = InsertionAdapter(
            database,
            'edits',
            (Edit item) => <String, Object?>{
                  'rid': item.rid,
                  'song': item.song,
                  'book': item.book,
                  'songNo': item.songNo,
                  'title': item.title,
                  'alias': item.alias,
                  'content': item.content,
                  'key': item.key,
                  'created': item.created,
                  'updated': item.updated
                },
            changeListener),
        _editUpdateAdapter = UpdateAdapter(
            database,
            'edits',
            ['rid'],
            (Edit item) => <String, Object?>{
                  'rid': item.rid,
                  'song': item.song,
                  'book': item.book,
                  'songNo': item.songNo,
                  'title': item.title,
                  'alias': item.alias,
                  'content': item.content,
                  'key': item.key,
                  'created': item.created,
                  'updated': item.updated
                },
            changeListener),
        _editDeletionAdapter = DeletionAdapter(
            database,
            'edits',
            ['rid'],
            (Edit item) => <String, Object?>{
                  'rid': item.rid,
                  'song': item.song,
                  'book': item.book,
                  'songNo': item.songNo,
                  'title': item.title,
                  'alias': item.alias,
                  'content': item.content,
                  'key': item.key,
                  'created': item.created,
                  'updated': item.updated
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Edit> _editInsertionAdapter;

  final UpdateAdapter<Edit> _editUpdateAdapter;

  final DeletionAdapter<Edit> _editDeletionAdapter;

  @override
  Future<Edit?> findEditById(int rid) async {
    return _queryAdapter.query('SELECT * FROM edits WHERE rid = ?1',
        mapper: (Map<String, Object?> row) => Edit(
            rid: row['rid'] as int?,
            song: row['song'] as String?,
            book: row['book'] as int?,
            songNo: row['songNo'] as int?,
            title: row['title'] as String?,
            alias: row['alias'] as String?,
            content: row['content'] as String?,
            key: row['key'] as String?,
            created: row['created'] as String?,
            updated: row['updated'] as String?),
        arguments: [rid]);
  }

  @override
  Future<List<Edit>> fetchEdits() async {
    return _queryAdapter.queryList('SELECT * FROM edits',
        mapper: (Map<String, Object?> row) => Edit(
            rid: row['rid'] as int?,
            song: row['song'] as String?,
            book: row['book'] as int?,
            songNo: row['songNo'] as int?,
            title: row['title'] as String?,
            alias: row['alias'] as String?,
            content: row['content'] as String?,
            key: row['key'] as String?,
            created: row['created'] as String?,
            updated: row['updated'] as String?));
  }

  @override
  Future<void> deleteAllEdits() async {
    await _queryAdapter.queryNoReturn('DELETE FROM edits');
  }

  @override
  Future<void> insertEdit(Edit edit) async {
    await _editInsertionAdapter.insert(edit, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateEdit(Edit edit) async {
    await _editUpdateAdapter.update(edit, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteEdit(Edit edit) async {
    await _editDeletionAdapter.delete(edit);
  }
}

class _$HistoriesDao extends HistoriesDao {
  _$HistoriesDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _historyInsertionAdapter = InsertionAdapter(
            database,
            'histories',
            (History item) => <String, Object?>{
                  'rid': item.rid,
                  'song': item.song,
                  'created': item.created
                },
            changeListener),
        _historyDeletionAdapter = DeletionAdapter(
            database,
            'histories',
            ['rid'],
            (History item) => <String, Object?>{
                  'rid': item.rid,
                  'song': item.song,
                  'created': item.created
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<History> _historyInsertionAdapter;

  final DeletionAdapter<History> _historyDeletionAdapter;

  @override
  Future<List<History>> fetchHistories() async {
    return _queryAdapter.queryList('SELECT * FROM histories',
        mapper: (Map<String, Object?> row) => History(
            rid: row['rid'] as int?,
            song: row['song'] as int?,
            created: row['created'] as String?));
  }

  @override
  Stream<List<HistoryExt>> fetchHistoryExts() {
    return _queryAdapter.queryListStream('SELECT * FROM viewhistories',
        mapper: (Map<String, Object?> row) => HistoryExt(
            row['rid'] as int,
            row['book'] as int,
            row['songId'] as int,
            row['songNo'] as int,
            row['title'] as String,
            row['alias'] as String,
            row['content'] as String,
            row['views'] as int,
            row['likes'] as int,
            (row['liked'] as int) != 0,
            row['songbook'] as String),
        queryableName: 'viewhistories',
        isView: true);
  }

  @override
  Future<void> deleteAllHistories() async {
    await _queryAdapter.queryNoReturn('DELETE FROM histories');
  }

  @override
  Future<void> insertHistory(History history) async {
    await _historyInsertionAdapter.insert(history, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteHistory(History history) async {
    await _historyDeletionAdapter.delete(history);
  }
}

class _$ListedsDao extends ListedsDao {
  _$ListedsDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _listedInsertionAdapter = InsertionAdapter(
            database,
            'listeds',
            (Listed item) => <String, Object?>{
                  'rid': item.rid,
                  'parentid': item.parentid,
                  'song': item.song,
                  'title': item.title,
                  'description': item.description,
                  'position': item.position,
                  'created': item.created,
                  'updated': item.updated
                },
            changeListener),
        _listedDeletionAdapter = DeletionAdapter(
            database,
            'listeds',
            ['rid'],
            (Listed item) => <String, Object?>{
                  'rid': item.rid,
                  'parentid': item.parentid,
                  'song': item.song,
                  'title': item.title,
                  'description': item.description,
                  'position': item.position,
                  'created': item.created,
                  'updated': item.updated
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Listed> _listedInsertionAdapter;

  final DeletionAdapter<Listed> _listedDeletionAdapter;

  @override
  Future<List<Listed>> fetchListeds() async {
    return _queryAdapter.queryList('SELECT * FROM listeds',
        mapper: (Map<String, Object?> row) => Listed(
            rid: row['rid'] as int?,
            parentid: row['parentid'] as int?,
            song: row['song'] as int?,
            title: row['title'] as String?,
            description: row['description'] as String?,
            position: row['position'] as int?,
            created: row['created'] as String?,
            updated: row['updated'] as String?));
  }

  @override
  Stream<List<ListedExt>> fetchListedExts() {
    return _queryAdapter.queryListStream('SELECT * FROM viewlisteds',
        mapper: (Map<String, Object?> row) => ListedExt(
            row['rid'] as int,
            row['parentid'] as int,
            row['position'] as int,
            row['created'] as String,
            row['updated'] as String,
            row['book'] as int,
            row['songId'] as int,
            row['songNo'] as int,
            row['title'] as String,
            row['alias'] as String,
            row['content'] as String,
            row['views'] as int,
            row['likes'] as int,
            (row['liked'] as int) != 0,
            row['songbook'] as String),
        queryableName: 'viewlisteds',
        isView: true);
  }

  @override
  Future<void> deleteAllListeds() async {
    await _queryAdapter.queryNoReturn('DELETE FROM listeds');
  }

  @override
  Future<void> insertListed(Listed listed) async {
    await _listedInsertionAdapter.insert(listed, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteListed(Listed listed) async {
    await _listedDeletionAdapter.delete(listed);
  }
}

class _$SearchesDao extends SearchesDao {
  _$SearchesDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _searchInsertionAdapter = InsertionAdapter(
            database,
            'searches',
            (Search item) => <String, Object?>{
                  'rid': item.rid,
                  'title': item.title,
                  'created': item.created
                },
            changeListener),
        _searchDeletionAdapter = DeletionAdapter(
            database,
            'searches',
            ['rid'],
            (Search item) => <String, Object?>{
                  'rid': item.rid,
                  'title': item.title,
                  'created': item.created
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Search> _searchInsertionAdapter;

  final DeletionAdapter<Search> _searchDeletionAdapter;

  @override
  Future<List<Search>> fetchSearches() async {
    return _queryAdapter.queryList('SELECT * FROM searches',
        mapper: (Map<String, Object?> row) => Search(
            rid: row['rid'] as int?,
            title: row['title'] as String?,
            created: row['created'] as String?));
  }

  @override
  Future<void> deleteAllSearches() async {
    await _queryAdapter.queryNoReturn('DELETE FROM searches');
  }

  @override
  Future<void> insertSearch(Search search) async {
    await _searchInsertionAdapter.insert(search, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteSearch(Search search) async {
    await _searchDeletionAdapter.delete(search);
  }
}

class _$SongsDao extends SongsDao {
  _$SongsDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _songInsertionAdapter = InsertionAdapter(
            database,
            'songs',
            (Song item) => <String, Object?>{
                  'rid': item.rid,
                  'book': item.book,
                  'songId': item.songId,
                  'songNo': item.songNo,
                  'title': item.title,
                  'alias': item.alias,
                  'content': item.content,
                  'views': item.views,
                  'likes': item.likes,
                  'liked': item.liked == null ? null : (item.liked! ? 1 : 0),
                  'created': item.created,
                  'updated': item.updated
                },
            changeListener),
        _songDeletionAdapter = DeletionAdapter(
            database,
            'songs',
            ['rid'],
            (Song item) => <String, Object?>{
                  'rid': item.rid,
                  'book': item.book,
                  'songId': item.songId,
                  'songNo': item.songNo,
                  'title': item.title,
                  'alias': item.alias,
                  'content': item.content,
                  'views': item.views,
                  'likes': item.likes,
                  'liked': item.liked == null ? null : (item.liked! ? 1 : 0),
                  'created': item.created,
                  'updated': item.updated
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Song> _songInsertionAdapter;

  final DeletionAdapter<Song> _songDeletionAdapter;

  @override
  Future<Song?> findSongById(int rid) async {
    return _queryAdapter.query('SELECT * FROM songs WHERE rid = ?1',
        mapper: (Map<String, Object?> row) => Song(
            book: row['book'] as int?,
            songId: row['songId'] as int?,
            songNo: row['songNo'] as int?,
            title: row['title'] as String?,
            alias: row['alias'] as String?,
            content: row['content'] as String?,
            views: row['views'] as int?,
            likes: row['likes'] as int?,
            liked: row['liked'] == null ? null : (row['liked'] as int) != 0,
            created: row['created'] as String?,
            updated: row['updated'] as String?),
        arguments: [rid]);
  }

  @override
  Stream<List<SongExt>> fetchAllSongs() {
    return _queryAdapter.queryListStream('SELECT * FROM viewsongs',
        mapper: (Map<String, Object?> row) => SongExt(
            row['rid'] as int,
            row['book'] as int,
            row['songId'] as int,
            row['songNo'] as int,
            row['title'] as String,
            row['alias'] as String,
            row['content'] as String,
            row['views'] as int,
            row['likes'] as int,
            (row['liked'] as int) != 0,
            row['songbook'] as String),
        queryableName: 'viewsongs',
        isView: true);
  }

  @override
  Stream<List<SongExt>> fetchSongs(int bid) {
    return _queryAdapter.queryListStream(
        'SELECT * FROM viewsongs WHERE book = ?1',
        mapper: (Map<String, Object?> row) => SongExt(
            row['rid'] as int,
            row['book'] as int,
            row['songId'] as int,
            row['songNo'] as int,
            row['title'] as String,
            row['alias'] as String,
            row['content'] as String,
            row['views'] as int,
            row['likes'] as int,
            (row['liked'] as int) != 0,
            row['songbook'] as String),
        arguments: [bid],
        queryableName: 'viewsongs',
        isView: true);
  }

  @override
  Stream<List<SongExt>> fetchLikes() {
    return _queryAdapter.queryListStream(
        'SELECT * FROM viewsongs WHERE liked = 1',
        mapper: (Map<String, Object?> row) => SongExt(
            row['rid'] as int,
            row['book'] as int,
            row['songId'] as int,
            row['songNo'] as int,
            row['title'] as String,
            row['alias'] as String,
            row['content'] as String,
            row['views'] as int,
            row['likes'] as int,
            (row['liked'] as int) != 0,
            row['songbook'] as String),
        queryableName: 'viewsongs',
        isView: true);
  }

  @override
  Future<void> updateSong(
    int rid,
    String title,
    String content,
    bool liked,
    String updated,
  ) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE songs SET title = ?2, content = ?3, liked = ?4, updated = ?5 WHERE rid = ?1',
        arguments: [rid, title, content, liked ? 1 : 0, updated]);
  }

  @override
  Future<void> deleteAllSongs() async {
    await _queryAdapter.queryNoReturn('DELETE FROM songs');
  }

  @override
  Future<void> insertSong(Song song) async {
    await _songInsertionAdapter.insert(song, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteSong(Song song) async {
    await _songDeletionAdapter.delete(song);
  }
}
