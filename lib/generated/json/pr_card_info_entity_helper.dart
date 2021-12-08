import 'package:SDZ/entity/mime/pr_card_info_entity.dart';

prCardInfoEntityFromJson(PrCardInfoEntity data, Map<String, dynamic> json) {
	if (json['identityType'] != null) {
		data.identityType = json['identityType'] is String
				? int.tryParse(json['identityType'])
				: json['identityType'].toInt();
	}
	if (json['companyName'] != null) {
		data.companyName = json['companyName'].toString();
	}
	if (json['professionalTitle'] != null) {
		data.professionalTitle = json['professionalTitle'].toString();
	}
	if (json['cardAvatar'] != null) {
		data.cardAvatar = json['cardAvatar'].toString();
	}
	if (json['skills'] != null) {
		data.skills = (json['skills'] as List).map((v) => PrCardInfoSkills().fromJson(v)).toList();
	}
	if (json['status'] != null) {
		data.status = json['status'] is String
				? int.tryParse(json['status'])
				: json['status'].toInt();
	}
	if (json['remark'] != null) {
		data.remark = json['remark'].toString();
	}
	return data;
}

Map<String, dynamic> prCardInfoEntityToJson(PrCardInfoEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['identityType'] = entity.identityType;
	data['companyName'] = entity.companyName;
	data['professionalTitle'] = entity.professionalTitle;
	data['cardAvatar'] = entity.cardAvatar;
	data['skills'] =  entity.skills.map((v) => v.toJson()).toList();
	data['status'] = entity.status;
	data['remark'] = entity.remark;
	return data;
}

prCardInfoSkillsFromJson(PrCardInfoSkills data, Map<String, dynamic> json) {
	if (json['skillId'] != null) {
		data.skillId = json['skillId'] is String
				? int.tryParse(json['skillId'])
				: json['skillId'].toInt();
	}
	if (json['skillLabel'] != null) {
		data.skillLabel = json['skillLabel'].toString();
	}
	return data;
}

Map<String, dynamic> prCardInfoSkillsToJson(PrCardInfoSkills entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['skillId'] = entity.skillId;
	data['skillLabel'] = entity.skillLabel;
	return data;
}