import 'package:SDZ/generated/json/base/json_convert_content.dart';
import 'package:SDZ/entity/mime/pr_card_info_entity.dart';

PrCardInfoEntity $PrCardInfoEntityFromJson(Map<String, dynamic> json) {
	final PrCardInfoEntity prCardInfoEntity = PrCardInfoEntity();
	final int? identityType = jsonConvert.convert<int>(json['identityType']);
	if (identityType != null) {
		prCardInfoEntity.identityType = identityType;
	}
	final String? companyName = jsonConvert.convert<String>(json['companyName']);
	if (companyName != null) {
		prCardInfoEntity.companyName = companyName;
	}
	final String? professionalTitle = jsonConvert.convert<String>(json['professionalTitle']);
	if (professionalTitle != null) {
		prCardInfoEntity.professionalTitle = professionalTitle;
	}
	final String? cardAvatar = jsonConvert.convert<String>(json['cardAvatar']);
	if (cardAvatar != null) {
		prCardInfoEntity.cardAvatar = cardAvatar;
	}
	final List<PrCardInfoSkills>? skills = jsonConvert.convertListNotNull<PrCardInfoSkills>(json['skills']);
	if (skills != null) {
		prCardInfoEntity.skills = skills;
	}
	final int? status = jsonConvert.convert<int>(json['status']);
	if (status != null) {
		prCardInfoEntity.status = status;
	}
	final String? remark = jsonConvert.convert<String>(json['remark']);
	if (remark != null) {
		prCardInfoEntity.remark = remark;
	}
	return prCardInfoEntity;
}

Map<String, dynamic> $PrCardInfoEntityToJson(PrCardInfoEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['identityType'] = entity.identityType;
	data['companyName'] = entity.companyName;
	data['professionalTitle'] = entity.professionalTitle;
	data['cardAvatar'] = entity.cardAvatar;
	data['skills'] =  entity.skills.map((v) => v.toJson()).toList();
	data['status'] = entity.status;
	data['remark'] = entity.remark;
	return data;
}

PrCardInfoSkills $PrCardInfoSkillsFromJson(Map<String, dynamic> json) {
	final PrCardInfoSkills prCardInfoSkills = PrCardInfoSkills();
	final int? skillId = jsonConvert.convert<int>(json['skillId']);
	if (skillId != null) {
		prCardInfoSkills.skillId = skillId;
	}
	final String? skillLabel = jsonConvert.convert<String>(json['skillLabel']);
	if (skillLabel != null) {
		prCardInfoSkills.skillLabel = skillLabel;
	}
	return prCardInfoSkills;
}

Map<String, dynamic> $PrCardInfoSkillsToJson(PrCardInfoSkills entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['skillId'] = entity.skillId;
	data['skillLabel'] = entity.skillLabel;
	return data;
}