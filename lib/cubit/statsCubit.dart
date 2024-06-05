import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_td/models/stats_model.dart';

class StatsCubit extends Cubit<StatsModel> {
  StatsCubit() : super(StatsModel());
}
