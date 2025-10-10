import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wts_bloc/data/models/news/news_model_req.dart';
import 'package:wts_bloc/data/models/news/news_model_res.dart';
import 'package:wts_bloc/data/repo/repo.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(const NewsState()) {
    on<GetNewses>((event, emit) async {
      try {
        if (event.payload.page == 1) {
          emit(state.copyWith(newsesStatus: NewsStatus.loading));
        } else {
          emit(state.copyWith(newsesLoadMore: true));
        }

        final response = await newsRepo.getNews(event.payload.toJson());
        if (response.statusCode >= 200 && response.statusCode < 400) {
          // var pagination = PaginationModel.fromJson(response.data['meta']);
          emit(state.copyWith(newsTotal: response.data['meta']['total']));
          final List items = response.data['data'];
          var result = items.map((e) => NewsModelRes.fromJson(e)).toList();

          if (event.payload.page != 1) {
            state.newses!.addAll(result);
            emit(state.copyWith(newses: state.newses));
            emit(state.copyWith(newsesLoadMore: false));
          } else {
            emit(state.copyWith(newses: result));
          }
          emit(state.copyWith(newsesStatus: NewsStatus.success));
          return;
        }

        emit(state.copyWith(newsesStatus: NewsStatus.error, newsesError: response.error));
        return;
      } catch (e) {
        emit(state.copyWith(newsesStatus: NewsStatus.error, newsesError: e.toString()));
        return;
      }
    });
  }
}
