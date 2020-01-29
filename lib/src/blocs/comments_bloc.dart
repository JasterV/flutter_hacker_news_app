import 'package:news/src/models/item_model.dart';
import 'package:news/src/resources/repository.dart';
import 'package:rxdart/subjects.dart';
import 'package:rxdart/transformers.dart';

class CommentsBloc {
  final _repository = Repository();
  final _commentsFetcher = PublishSubject<int>();
  final _commentsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();

  //Streams
  Stream<Map<int, Future<ItemModel>>> get itemWithComments =>
      _commentsOutput.stream;

  //Sinks
  Function(int) get fetchItemWithComments => _commentsFetcher.add;

  CommentsBloc() {
    _commentsFetcher.stream
        .transform(_commentsTransformer())
        .pipe(_commentsOutput);
  }

  _commentsTransformer() {
    return ScanStreamTransformer<int, Map<int, Future<ItemModel>>>(
        (cache, int id, _) {
      cache[id] = _repository.fetchItem(id);
      cache[id].then((ItemModel item) {
        if (!item.deleted)
          item.kids.forEach((kidId) => fetchItemWithComments(kidId));
      });
      return cache;
    }, <int, Future<ItemModel>>{});
  }

  dispose() {
    _commentsFetcher.close();
    _commentsOutput.close();
  }
}
