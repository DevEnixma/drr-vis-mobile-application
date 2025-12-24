import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wts_bloc/data/models/news/news_model_req.dart';
import 'package:wts_bloc/data/models/news/news_model_res.dart';
import 'package:wts_bloc/data/repo/repo.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(const NewsState()) {
    on<GetNewses>(_onGetNewses);
  }

  Future<void> _onGetNewses(
    GetNewses event,
    Emitter<NewsState> emit,
  ) async {
    if (event.payload.page == 1) {
      emit(state.copyWith(newsesStatus: NewsStatus.loading));
    } else {
      emit(state.copyWith(newsesLoadMore: true));
    }

    try {
      final response = await newsRepo.getNews(event.payload.toJson());

      if (response.statusCode >= 200 && response.statusCode < 400) {
        final List items = response.data['data'];
        final result = items.map((e) => NewsModelRes.fromJson(e)).toList();

        final updatedList =
            event.payload.page == 1 ? result : [...?state.newses, ...result];

        final total = response.data['meta']['total'] as int?;

        emit(state.copyWith(
          newsesStatus: NewsStatus.success,
          newses: updatedList,
          newsTotal: total,
          newsesLoadMore: false,
        ));
      } else {
        emit(state.copyWith(
          newsesStatus: NewsStatus.error,
          newsesError: response.error ?? 'Unknown error',
          newsesLoadMore: false,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        newsesStatus: NewsStatus.error,
        newsesError: e.toString(),
        newsesLoadMore: false,
      ));
    }
  }
}
