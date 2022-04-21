import 'package:SDZ/generated/json/base/json_convert_content.dart';

class RewardEntity with JsonConvert<RewardEntity> {
	RewardTask? task;
	int? jifen;
}

class RewardTask with JsonConvert<RewardTask> {
	int? id;
	String? title;
	int? max;
	int? min;
	int? prize;
	int? times;
}
