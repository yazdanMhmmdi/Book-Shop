import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_shop/data/model/title_model.dart';
import 'package:book_shop/data/repository/title_repository.dart';
import 'package:equatable/equatable.dart';

part 'title_event.dart';
part 'title_state.dart';

class TitleBloc extends Bloc<TitleEvent, TitleState> {
  TitleBloc() : super(TitleInitial());
  TitleRepository _titleRepository = new TitleRepository();
  int siencePage = 1;
  int medicinePage = 1;
  int historyPage = 1;
  int foodPage = 1;
  int lawPage = 1;
  int sportPage = 1;
  int page = 1;
  TitleModel _model;

  bool sience = true;
  bool medicine = true;
  bool history = true;
  bool law = true;
  bool food = true;
  bool sport = true;
  //totalPages
  int sienceTotalPage = 0;
  int medicineTotalPage = 0;
  int historyTotalPage = 0;
  int lawTotalPage = 0;
  int foodTotalPage = 0;
  int sportTotalPage = 0;
  @override
  Stream<TitleState> mapEventToState(
    TitleEvent event,
  ) async* {
    if (event is FetchBooks) {
      yield TitleLoading();
      print('TitleLOading');

      // try {
      //   _model = await _titleRepository.getTitle(
      //       page.toString(), event.title.toString());
      //   page++;

      try {
        if (page == 1) {
          _model = await _titleRepository.getTitle(
              page.toString(), event.title.toString());
          page++;
        }

        if (event.title == 1) {
          if (sience) {
            sience = false;
            TitleModel _modelSience = await _titleRepository.getTitle(
                siencePage.toString(), event.title.toString());
            sienceTotalPage = _modelSience.data.totalPages;
            _modelSience.books.forEach((e) {
              _model.sience.add(e);
            });
            siencePage++;
          }
          if (_model.sience.length == 0) {
            yield TitleNothingFound();
          } else {
            yield TitleSuccess(_model.sience);
          }
          print('TitleSuccess sience');
        } else if (event.title == 2) {
          if (medicine) {
            medicine = false;
            TitleModel _medicineModel = await _titleRepository.getTitle(
                medicinePage.toString(), event.title.toString());
            medicineTotalPage = _medicineModel.data.totalPages;

            _medicineModel.books.forEach((e) {
              _model.medicine.add(e);
            });
            medicinePage++;
          }

          if (_model.medicine.length == 0) {
            yield TitleNothingFound();
          } else {
            yield TitleSuccess(_model.medicine);
          }
          print('TitleSuccess medicine');
        } else if (event.title == 3) {
          if (history) {
            history = false;
            TitleModel _historyModel = await _titleRepository.getTitle(
                historyPage.toString(), event.title.toString());
            historyTotalPage = _historyModel.data.totalPages;

            _historyModel.books.forEach((e) {
              _model.history.add(e);
            });
            historyPage++;
          }
          if (_model.history.length == 0) {
            yield TitleNothingFound();
          } else {
            yield TitleSuccess(_model.history);
          }

          print('TitleSuccess medicine');
        } else if (event.title == 4) {
          if (law) {
            law = false;
            TitleModel _lawModel = await _titleRepository.getTitle(
                lawPage.toString(), event.title.toString());
            lawTotalPage = _lawModel.data.totalPages;

            _lawModel.books.forEach((e) {
              _model.law.add(e);
            });
            lawPage++;
          }
          if (_model.law.length == 0) {
            yield TitleNothingFound();
          } else {
            yield TitleSuccess(_model.law);
          }
          print('TitleSuccess medicine');
        } else if (event.title == 5) {
          if (food) {
            food = false;
            TitleModel _foodModel = await _titleRepository.getTitle(
                foodPage.toString(), event.title.toString());
            foodTotalPage = _foodModel.data.totalPages;
            _foodModel.books.forEach((e) {
              _model.food.add(e);
            });
            foodPage++;
          }
          if (_model.food.length == 0) {
            yield TitleNothingFound();
          } else {
            yield TitleSuccess(_model.food);
          }
          print('TitleSuccess medicine');
        } else if (event.title == 6) {
          if (sport) {
            sport = false;
            TitleModel _sportModel = await _titleRepository.getTitle(
                sportPage.toString(), event.title.toString());
            sportTotalPage = _sportModel.data.totalPages;

            _sportModel.books.forEach((e) {
              _model.sport.add(e);
            });
            sportPage++;
          }
          if (_model.sport.length == 0) {
            yield TitleNothingFound();
          } else {
            yield TitleSuccess(_model.sport);
          }
          print('TitleSuccess medicine');
        } else {
          yield TitleNothingFound();
        }
      } catch (_) {
        print('why : ${_.toString()}');
        yield TitleFailure();
        print('TitleFailure');
      }
    } else if (event is PaginationBooks) {
      if (event.title == 1 && siencePage <= sienceTotalPage) {
        yield TitlePagination(_model.sience, 1);
        TitleModel _modelSience = await _titleRepository.getTitle(
            siencePage.toString(), event.title.toString());

        _modelSience.books.forEach((e) {
          _model.sience.add(e);
        });
        siencePage++;
        yield TitleSuccess(_model.sience);
        print('TitleSuccess sience');
      } else if (event.title == 2 && medicinePage <= medicineTotalPage) {
        yield TitlePagination(_model.medicine, 2);
        TitleModel _modelMedicine = await _titleRepository.getTitle(
            medicinePage.toString(), event.title.toString());

        _modelMedicine.books.forEach((e) {
          _model.medicine.add(e);
        });
        medicinePage++;
        yield TitleSuccess(_model.medicine);
        print('TitleSuccess sience');
      } else if (event.title == 3 && historyPage <= historyTotalPage) {
        yield TitlePagination(_model.history, 3);
        TitleModel _modelHistory = await _titleRepository.getTitle(
            historyPage.toString(), event.title.toString());

        _modelHistory.books.forEach((e) {
          _model.history.add(e);
        });
        historyPage++;
        yield TitleSuccess(_model.history);
        print('TitleSuccess sience');
      } else if (event.title == 4 && lawPage <= lawTotalPage) {
        yield TitlePagination(_model.law, 4);
        TitleModel _modelLaw = await _titleRepository.getTitle(
            lawPage.toString(), event.title.toString());

        _modelLaw.books.forEach((e) {
          _model.law.add(e);
        });
        lawPage++;
        yield TitleSuccess(_model.law);
        print('TitleSuccess sience');
      } else if (event.title == 5 && foodPage <= foodTotalPage) {
        yield TitlePagination(_model.food, 5);
        TitleModel _modelFood = await _titleRepository.getTitle(
            foodPage.toString(), event.title.toString());

        _modelFood.books.forEach((e) {
          _model.food.add(e);
        });
        foodPage++;
        yield TitleSuccess(_model.food);
        print('TitleSuccess sience');
      } else if (event.title == 6 && sportPage <= sportTotalPage) {
        yield TitlePagination(_model.sport, 6);
        TitleModel _modelSport = await _titleRepository.getTitle(
            sportPage.toString(), event.title.toString());

        _modelSport.books.forEach((e) {
          _model.sport.add(e);
        });
        sportPage++;
        yield TitleSuccess(_model.sport);
        print('TitleSuccess sience');
      }
    }
  }
}
