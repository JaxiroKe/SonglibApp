import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/data/models/models.dart';
import '../../../common/widgets/list_items/search_book_item.dart';
import '../../../common/widgets/list_items/search_song_item.dart';
import '../../../common/widgets/progress/skeleton.dart';
import '../../../core/theme/theme_colors.dart';
import '../../../core/theme/theme_styles.dart';
import '../../home/bloc/home_bloc.dart';
import '../../home/ui/home_screen.dart';
import '../../presentor/ui/presentor_screen.dart';
import 'likes_search.dart';

part 'widgets/books_list.dart';
part 'widgets/fab_widget.dart';
part 'widgets/songs_list.dart';

class LikesScreen extends StatefulWidget {
  final HomeScreenBodyState parent;
  const LikesScreen({super.key, required this.parent});

  @override
  State<LikesScreen> createState() => LikesScreenState();
}

class LikesScreenState extends State<LikesScreen> {
  late HomeScreenBodyState parent;
  late HomeBloc bloc;

  int setBook = 0, setSong = 0;
  int pageSize = 20, currentPage = 0;
  bool hasMoreData = true;
  List<SongExt> filtered = [];

  final ScrollController _scrollController = ScrollController();
  bool _showBackToTopButton = false;

  @override
  void initState() {
    super.initState();
    bloc = context.read<HomeBloc>();
    _scrollController.addListener(() {
      if (_scrollController.offset > 200) {
        if (!_showBackToTopButton) {
          setState(() => _showBackToTopButton = true);
        }
      } else {
        if (_showBackToTopButton) {
          setState(() => _showBackToTopButton = false);
        }
      }
    });
  }

  /// filter songs based on the selected book
  void filterSongsByBook() {
    if (!hasMoreData) return;
    
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        final nextPageItems = bloc.state.songs
            .where((song) => song.book == bloc.state.books[setBook].bookId)
            .skip(currentPage * pageSize)
            .take(pageSize)
            .toList();
        if (nextPageItems.isEmpty) {
          hasMoreData = false;
        } else {
          filtered.addAll(nextPageItems);
          currentPage++;
        }
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    parent = widget.parent;
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: bloc,
      listener: (context, state) {
        if (state.status == Status.loaded) {
          setState(() {
            setBook = 0;
            filterSongsByBook();
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: <Widget>[
                BooksList(parent: this),
                SongsList(parent: this),
              ],
            ),
          ),
          floatingActionButton: FabWidget(parent: this),
        );
      },
    );
  }
}
