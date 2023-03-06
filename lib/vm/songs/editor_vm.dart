import 'package:flutter/material.dart';
import 'package:icapps_architecture/icapps_architecture.dart';
import 'package:injectable/injectable.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../di/injectable.dart';
import '../../model/base/draft.dart';
import '../../model/base/songext.dart';
import '../../navigator/mixin/back_navigator.dart';
import '../../repository/db_repository.dart';
import '../../repository/shared_prefs/local_storage.dart';
import '../../util/constants/pref_constants.dart';
import '../home/home_vm.dart';

@injectable
class EditorVm with ChangeNotifierEx {
  late final EditorNavigator navigator;
  final LocalStorage localStorage;
  final DbRepository dbRepo;

  EditorVm(this.dbRepo, this.localStorage);

  HomeVm? homeVm;
  SongExt? song;
  Draft? draft;

  bool isLoading = false, isNewContent = false, notDraft = false;
  String? title, content, alias, key;
  TextEditingController? titleController = TextEditingController(),
      contentController = TextEditingController();
  TextEditingController? aliasController = TextEditingController(),
      keyController = TextEditingController();

  Future<void> init(EditorNavigator screenNavigator) async {
    navigator = screenNavigator;

    draft = localStorage.draft;
    song = localStorage.song;

    notDraft = localStorage.getPrefBool(PrefConstants.notDraftKey);
    homeVm = HomeVm(dbRepo, localStorage);
    homeVm = getIt.get<HomeVm>();
    await loadEditor();
  }

  Future<void> loadEditor() async {
    isLoading = true;
    notifyListeners();

    if (notDraft) {
      titleController!.text = song!.title!;
      aliasController!.text = song!.alias!;
      keyController!.text = song!.key!;
      contentController!.text = song!.content!;
    } else {
      titleController!.text = draft!.title!;
      aliasController!.text = draft!.alias!;
      keyController!.text = draft!.key!;
      contentController!.text = draft!.content!;
    } 

    isLoading = false;
    notifyListeners();
  }

  // function to validate creds
  bool validateInput() {
    bool validated = false;
    if (titleController!.text.isNotEmpty) {
      title = titleController!.text;
      content = contentController!.text.replaceAll(RegExp(r'[\n]'), '#');
      alias = aliasController!.text;
      key = keyController!.text;

      validated = true;
    } else {
      validated = false;
    }
    return validated;
  }

  /// Save changes for a song be it a new one or simply updating an old one
  Future<void> saveChanges() async {
    if (validateInput()) {
      isLoading = true;
      notifyListeners();

      try {
        if (song != null) {
          song!.title = title;
          song!.content = content;
          song!.alias = alias;
          song!.key = key;
          await dbRepo.editSong(song!);
        } else if (draft != null) {
          draft!.title = title;
          draft!.content = content;
          draft!.alias = alias;
          draft!.key = key;
          await dbRepo.editDraft(draft!);
        } else {
          draft = Draft(
            title: title,
            content: content,
            alias: alias,
            key: key,
          );
          await dbRepo.saveDraft(draft!);
        }
      } catch (exception, stackTrace) {
        await Sentry.captureException(
          exception,
          stackTrace: stackTrace,
        );
      }

      await onBackPressed();
      isLoading = false;
      notifyListeners();
    }
  }

  /// Remove a song from the records
  Future<bool?> deleteSong() async {
    bool? success;

    if (validateInput()) {
      isLoading = true;
      notifyListeners();

      //await dbRepo.d(draft!);

      isLoading = true;
      notifyListeners();
    }
    return success;
  }

  Future<void> confirmCancel(BuildContext context) async {
    if (validateInput()) {
      return showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text(
            'Just a Minute',
            style: TextStyle(fontSize: 18),
          ),
          content: Text(
            'Are you sure you want to close without saving your changes of the song: ${titleController!.text}?',
            style: const TextStyle(fontSize: 14),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                saveChanges();
                homeVm!.fetchDraftsData();
              },
              child: const Text("SAVE"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                onBackPressed();
              },
              child: const Text("DON'T SAVE"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("CANCEL"),
            ),
          ],
        ),
      );
    } else {
      await onBackPressed();
    }
  }

  Future<void> confirmDelete(BuildContext context) async {
    if (validateInput()) {
      return showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text(
            'Just a Minute',
            style: TextStyle(fontSize: 18),
          ),
          content: Text(
            'Are you sure you want to delete the song: ${titleController!.text}?',
            style: const TextStyle(fontSize: 14),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                deleteSong();
                homeVm!.fetchDraftsData();
              },
              child: const Text("DELETE"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("CANCEL"),
            ),
          ],
        ),
      );
    } else {
      await onBackPressed();
    }
  }

  Future<void> onBackPressed() async {
    navigator.goBack<void>();
  }
}

abstract class EditorNavigator implements BackNavigator {}
