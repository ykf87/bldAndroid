import 'package:SDZ/generated/json/base/json_convert_content.dart';
import 'package:SDZ/entity/sign_info_entity.dart';

SignInfoEntity $SignInfoEntityFromJson(Map<String, dynamic> json) {
	final SignInfoEntity signInfoEntity = SignInfoEntity();
	final SignInfoUser? user = jsonConvert.convert<SignInfoUser>(json['user']);
	if (user != null) {
		signInfoEntity.user = user;
	}
	final SignInfoSigned? signed = jsonConvert.convert<SignInfoSigned>(json['signed']);
	if (signed != null) {
		signInfoEntity.signed = signed;
	}
	final bool? issigin = jsonConvert.convert<bool>(json['issigin']);
	if (issigin != null) {
		signInfoEntity.issigin = issigin;
	}
	return signInfoEntity;
}

Map<String, dynamic> $SignInfoEntityToJson(SignInfoEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['user'] = entity.user?.toJson();
	data['signed'] = entity.signed?.toJson();
	data['issigin'] = entity.issigin;
	return data;
}

SignInfoUser $SignInfoUserFromJson(Map<String, dynamic> json) {
	final SignInfoUser signInfoUser = SignInfoUser();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		signInfoUser.id = id;
	}
	final String? nickname = jsonConvert.convert<String>(json['nickname']);
	if (nickname != null) {
		signInfoUser.nickname = nickname;
	}
	final String? avatar = jsonConvert.convert<String>(json['avatar']);
	if (avatar != null) {
		signInfoUser.avatar = avatar;
	}
	final int? level = jsonConvert.convert<int>(json['level']);
	if (level != null) {
		signInfoUser.level = level;
	}
	final String? invitation = jsonConvert.convert<String>(json['invitation']);
	if (invitation != null) {
		signInfoUser.invitation = invitation;
	}
	final int? child = jsonConvert.convert<int>(json['child']);
	if (child != null) {
		signInfoUser.child = child;
	}
	final int? team = jsonConvert.convert<int>(json['team']);
	if (team != null) {
		signInfoUser.team = team;
	}
	final SignInfoUserParent? parent = jsonConvert.convert<SignInfoUserParent>(json['parent']);
	if (parent != null) {
		signInfoUser.parent = parent;
	}
	return signInfoUser;
}

Map<String, dynamic> $SignInfoUserToJson(SignInfoUser entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['nickname'] = entity.nickname;
	data['avatar'] = entity.avatar;
	data['level'] = entity.level;
	data['invitation'] = entity.invitation;
	data['child'] = entity.child;
	data['team'] = entity.team;
	data['parent'] = entity.parent?.toJson();
	return data;
}

SignInfoUserParent $SignInfoUserParentFromJson(Map<String, dynamic> json) {
	final SignInfoUserParent signInfoUserParent = SignInfoUserParent();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		signInfoUserParent.id = id;
	}
	final String? nickname = jsonConvert.convert<String>(json['nickname']);
	if (nickname != null) {
		signInfoUserParent.nickname = nickname;
	}
	final String? avatar = jsonConvert.convert<String>(json['avatar']);
	if (avatar != null) {
		signInfoUserParent.avatar = avatar;
	}
	final int? level = jsonConvert.convert<int>(json['level']);
	if (level != null) {
		signInfoUserParent.level = level;
	}
	final int? team = jsonConvert.convert<int>(json['team']);
	if (team != null) {
		signInfoUserParent.team = team;
	}
	final String? invitation = jsonConvert.convert<String>(json['invitation']);
	if (invitation != null) {
		signInfoUserParent.invitation = invitation;
	}
	return signInfoUserParent;
}

Map<String, dynamic> $SignInfoUserParentToJson(SignInfoUserParent entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['nickname'] = entity.nickname;
	data['avatar'] = entity.avatar;
	data['level'] = entity.level;
	data['team'] = entity.team;
	data['invitation'] = entity.invitation;
	return data;
}

SignInfoSigned $SignInfoSignedFromJson(Map<String, dynamic> json) {
	final SignInfoSigned signInfoSigned = SignInfoSigned();
	final SignInfoSignedProduct? product = jsonConvert.convert<SignInfoSignedProduct>(json['product']);
	if (product != null) {
		signInfoSigned.product = product;
	}
	final int? startat = jsonConvert.convert<int>(json['startat']);
	if (startat != null) {
		signInfoSigned.startat = startat;
	}
	final int? days = jsonConvert.convert<int>(json['days']);
	if (days != null) {
		signInfoSigned.days = days;
	}
	final int? xBreak = jsonConvert.convert<int>(json['break']);
	if (xBreak != null) {
		signInfoSigned.xBreak = xBreak;
	}
	final int? mustdays = jsonConvert.convert<int>(json['mustdays']);
	if (mustdays != null) {
		signInfoSigned.mustdays = mustdays;
	}
	final int? advs = jsonConvert.convert<int>(json['advs']);
	if (advs != null) {
		signInfoSigned.advs = advs;
	}
	final bool? mustadv = jsonConvert.convert<bool>(json['mustadv']);
	if (mustadv != null) {
		signInfoSigned.mustadv = mustadv;
	}
	final int? need_day = jsonConvert.convert<int>(json['need_day']);
	if (need_day != null) {
		signInfoSigned.need_day = need_day;
	}
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		signInfoSigned.id = id;
	}
	return signInfoSigned;
}

Map<String, dynamic> $SignInfoSignedToJson(SignInfoSigned entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['product'] = entity.product?.toJson();
	data['startat'] = entity.startat;
	data['days'] = entity.days;
	data['break'] = entity.xBreak;
	data['mustdays'] = entity.mustdays;
	data['advs'] = entity.advs;
	data['mustadv'] = entity.mustadv;
	data['need_day'] = entity.need_day;
	data['id'] = entity.id;
	return data;
}

SignInfoSignedProduct $SignInfoSignedProductFromJson(Map<String, dynamic> json) {
	final SignInfoSignedProduct signInfoSignedProduct = SignInfoSignedProduct();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		signInfoSignedProduct.id = id;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		signInfoSignedProduct.name = name;
	}
	final String? cover = jsonConvert.convert<String>(json['cover']);
	if (cover != null) {
		signInfoSignedProduct.cover = cover;
	}
	final double? sale = jsonConvert.convert<double>(json['sale']);
	if (sale != null) {
		signInfoSignedProduct.sale = sale;
	}
	final int? sendout = jsonConvert.convert<int>(json['sendout']);
	if (sendout != null) {
		signInfoSignedProduct.sendout = sendout;
	}
	final int? own = jsonConvert.convert<int>(json['own']);
	if (own != null) {
		signInfoSignedProduct.own = own;
	}
	final int? maxown = jsonConvert.convert<int>(json['maxown']);
	if (maxown != null) {
		signInfoSignedProduct.maxown = maxown;
	}
	return signInfoSignedProduct;
}

Map<String, dynamic> $SignInfoSignedProductToJson(SignInfoSignedProduct entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['cover'] = entity.cover;
	data['sale'] = entity.sale;
	data['sendout'] = entity.sendout;
	data['own'] = entity.own;
	data['maxown'] = entity.maxown;
	return data;
}