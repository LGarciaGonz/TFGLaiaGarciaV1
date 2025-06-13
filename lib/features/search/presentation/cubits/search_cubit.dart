import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:litlens_v1/features/search/domain/search_repository.dart';
import 'package:litlens_v1/features/search/presentation/cubits/search_states.dart';

class SearchCubit extends Cubit<SearchStates> {
  final SearchRepository searchRepository;

  SearchCubit({required this.searchRepository}) : super(SearchInitial());

  Future<void> searchUsers(String query) async {
    if (query.isEmpty) {
      emit(SearchInitial());
      return;
    }

    try {
      emit(SearchLoading());
      final users = await searchRepository.searchUsers(query);

      emit(SearchLoaded(users));
    } catch (e) {
      emit(SearchError("Error recogiendo los resultados de la búsqueda"));
    }
  }
}
