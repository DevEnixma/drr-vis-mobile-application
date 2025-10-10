part of 'news_bloc.dart';

sealed class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object> get props => [];
}

class GetNewses extends NewsEvent {
  final NewsModelReq payload;

  const GetNewses(this.payload);
}
