import 'package:news/src/models/item_model.dart';
import 'package:news/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class StoriesBloc {
  final _repository = Repository();
  final _topIds = BehaviorSubject<List<int>>();
  final _itemsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();
  final _itemsFetch = BehaviorSubject<int>();

  StoriesBloc(){
  _itemsFetch.stream.transform(_itemsTransformer()).pipe(_itemsOutput);
  }

  Stream<List<int>> get topIds$ => _topIds.stream;
  Stream<Map<int, Future<ItemModel>>> get items$ => _itemsOutput.stream;

  Function(int) get addItem => _itemsFetch.sink.add;

  fetchTopIds() async {
    _topIds.add(await _repository.fetchtopIds());
  }

 _itemsTransformer() {
    return ScanStreamTransformer(
      (Map<int, Future<ItemModel>> cache, int id, int index) {
        cache[id] = _repository.fetchItem(id);
        return cache;
      },
      <int, Future<ItemModel>>{},
    );
  }

  dispose() {
    _topIds.close();
    _itemsOutput.close();
    _itemsFetch.close();
  }
}
