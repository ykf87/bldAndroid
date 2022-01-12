// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
import 'package:SDZ/entity/mime/my_focus_talent_entity.dart';
import 'package:SDZ/generated/json/my_focus_talent_entity_helper.dart';
import 'package:SDZ/entity/mime/pr_card_info_entity.dart';
import 'package:SDZ/generated/json/pr_card_info_entity_helper.dart';
import 'package:SDZ/entity/base/empty_entity.dart';
import 'package:SDZ/generated/json/empty_entity_helper.dart';
import 'package:SDZ/entity/search/talent_entity.dart';
import 'package:SDZ/generated/json/talent_entity_helper.dart';
import 'package:SDZ/entity/mime/base_info_entity.dart';
import 'package:SDZ/generated/json/base_info_entity_helper.dart';
import 'package:SDZ/entity/global_entity.dart';
import 'package:SDZ/generated/json/global_entity_helper.dart';
import 'package:SDZ/entity/talent/q_r_code_entity.dart';
import 'package:SDZ/generated/json/q_r_code_entity_helper.dart';
import 'package:SDZ/entity/waimai/activity_link_result_entity.dart';
import 'package:SDZ/generated/json/activity_link_result_entity_helper.dart';
import 'package:SDZ/entity/search/card_entity.dart';
import 'package:SDZ/generated/json/card_entity_helper.dart';
import 'package:SDZ/entity/waimai/waimai_entity.dart';
import 'package:SDZ/generated/json/waimai_entity_helper.dart';
import 'package:SDZ/entity/mime/my_collect_entity.dart';
import 'package:SDZ/generated/json/my_collect_entity_helper.dart';
import 'package:SDZ/entity/mime/my_browse_record_entity.dart';
import 'package:SDZ/generated/json/my_browse_record_entity_helper.dart';
import 'package:SDZ/entity/mime/ali_oss_entity.dart';
import 'package:SDZ/generated/json/ali_oss_entity_helper.dart';
import 'package:SDZ/entity/skill_entity.dart';
import 'package:SDZ/generated/json/skill_entity_helper.dart';
import 'package:SDZ/entity/jutuike/goods_entity.dart';
import 'package:SDZ/generated/json/goods_entity_helper.dart';
import 'package:SDZ/entity/mime/user_center_entity.dart';
import 'package:SDZ/generated/json/user_center_entity_helper.dart';
import 'package:SDZ/entity/mime/bank_entity.dart';
import 'package:SDZ/generated/json/bank_entity_helper.dart';
import 'package:SDZ/entity/notice/notice_newest_msg_entity.dart';
import 'package:SDZ/generated/json/notice_newest_msg_entity_helper.dart';
import 'package:SDZ/entity/new_message_entity.dart';
import 'package:SDZ/generated/json/new_message_entity_helper.dart';
import 'package:SDZ/entity/mime/pr_list_skill_entity.dart';
import 'package:SDZ/generated/json/pr_list_skill_entity_helper.dart';
import 'package:SDZ/entity/notice_read_status_entity.dart';
import 'package:SDZ/generated/json/notice_read_status_entity_helper.dart';
import 'package:SDZ/entity/adIntegral/ad_task_entity.dart';
import 'package:SDZ/generated/json/ad_task_entity_helper.dart';
import 'package:SDZ/entity/login/login_entity.dart';
import 'package:SDZ/generated/json/login_entity_helper.dart';
import 'package:SDZ/entity/home/telephone_bill_entity.dart';
import 'package:SDZ/generated/json/telephone_bill_entity_helper.dart';
import 'package:SDZ/entity/waimai/goods_link_entity.dart';
import 'package:SDZ/generated/json/goods_link_entity_helper.dart';
import 'package:SDZ/entity/notice/notice_entity.dart';
import 'package:SDZ/generated/json/notice_entity_helper.dart';
import 'package:SDZ/entity/waimai/goods_detail_entity.dart';
import 'package:SDZ/generated/json/goods_detail_entity_helper.dart';

class JsonConvert<T> {
	T fromJson(Map<String, dynamic> json) {
		return _getFromJson<T>(runtimeType, this, json);
	}

  Map<String, dynamic> toJson() {
		return _getToJson<T>(runtimeType, this);
  }

  static _getFromJson<T>(Type type, data, json) {
		switch (type) {
			case MyFocusTalentEntity:
				return myFocusTalentEntityFromJson(data as MyFocusTalentEntity, json) as T;
			case MyFocusTalentSkillTagList:
				return myFocusTalentSkillTagListFromJson(data as MyFocusTalentSkillTagList, json) as T;
			case MyFocusTalentCardList:
				return myFocusTalentCardListFromJson(data as MyFocusTalentCardList, json) as T;
			case PrCardInfoEntity:
				return prCardInfoEntityFromJson(data as PrCardInfoEntity, json) as T;
			case PrCardInfoSkills:
				return prCardInfoSkillsFromJson(data as PrCardInfoSkills, json) as T;
			case EmptyEntity:
				return emptyEntityFromJson(data as EmptyEntity, json) as T;
			case TalentEntity:
				return talentEntityFromJson(data as TalentEntity, json) as T;
			case TalentCard:
				return talentCardFromJson(data as TalentCard, json) as T;
			case TalentSkill:
				return talentSkillFromJson(data as TalentSkill, json) as T;
			case BaseInfoEntity:
				return baseInfoEntityFromJson(data as BaseInfoEntity, json) as T;
			case GlobalEntity:
				return globalEntityFromJson(data as GlobalEntity, json) as T;
			case QRCodeEntity:
				return qRCodeEntityFromJson(data as QRCodeEntity, json) as T;
			case ActivityLinkResultEntity:
				return activityLinkResultEntityFromJson(data as ActivityLinkResultEntity, json) as T;
			case CardEntity:
				return cardEntityFromJson(data as CardEntity, json) as T;
			case CardItemEntity:
				return cardItemEntityFromJson(data as CardItemEntity, json) as T;
			case SkillTagItemEntity:
				return skillTagItemEntityFromJson(data as SkillTagItemEntity, json) as T;
			case WaimaiEntity:
				return waimaiEntityFromJson(data as WaimaiEntity, json) as T;
			case MyCollectEntity:
				return myCollectEntityFromJson(data as MyCollectEntity, json) as T;
			case MyCollectSkillTagList:
				return myCollectSkillTagListFromJson(data as MyCollectSkillTagList, json) as T;
			case CardWoksList:
				return cardWoksListFromJson(data as CardWoksList, json) as T;
			case MyBrowseRecordEntity:
				return myBrowseRecordEntityFromJson(data as MyBrowseRecordEntity, json) as T;
			case MyBrowseRecordSkillTagList:
				return myBrowseRecordSkillTagListFromJson(data as MyBrowseRecordSkillTagList, json) as T;
			case AliOssEntity:
				return aliOssEntityFromJson(data as AliOssEntity, json) as T;
			case SkillEntity:
				return skillEntityFromJson(data as SkillEntity, json) as T;
			case GoodsEntity:
				return goodsEntityFromJson(data as GoodsEntity, json) as T;
			case UserCenterEntity:
				return userCenterEntityFromJson(data as UserCenterEntity, json) as T;
			case UserCenterCardInfoList:
				return userCenterCardInfoListFromJson(data as UserCenterCardInfoList, json) as T;
			case BankEntity:
				return bankEntityFromJson(data as BankEntity, json) as T;
			case NoticeNewestMsgEntity:
				return noticeNewestMsgEntityFromJson(data as NoticeNewestMsgEntity, json) as T;
			case NewMessageEntity:
				return newMessageEntityFromJson(data as NewMessageEntity, json) as T;
			case PrListSkillEntity:
				return prListSkillEntityFromJson(data as PrListSkillEntity, json) as T;
			case NoticeReadStatusEntity:
				return noticeReadStatusEntityFromJson(data as NoticeReadStatusEntity, json) as T;
			case AdTaskEntity:
				return adTaskEntityFromJson(data as AdTaskEntity, json) as T;
			case LoginEntity:
				return loginEntityFromJson(data as LoginEntity, json) as T;
			case TelephoneBillEntity:
				return telephoneBillEntityFromJson(data as TelephoneBillEntity, json) as T;
			case GoodsLinkEntity:
				return goodsLinkEntityFromJson(data as GoodsLinkEntity, json) as T;
			case GoodsLinkCouponInfo:
				return goodsLinkCouponInfoFromJson(data as GoodsLinkCouponInfo, json) as T;
			case GoodsLinkWeAppInfo:
				return goodsLinkWeAppInfoFromJson(data as GoodsLinkWeAppInfo, json) as T;
			case NoticeEntity:
				return noticeEntityFromJson(data as NoticeEntity, json) as T;
			case NoticeItemEntity:
				return noticeItemEntityFromJson(data as NoticeItemEntity, json) as T;
			case GoodsDetailEntity:
				return goodsDetailEntityFromJson(data as GoodsDetailEntity, json) as T;    }
		return data as T;
	}

  static _getToJson<T>(Type type, data) {
		switch (type) {
			case MyFocusTalentEntity:
				return myFocusTalentEntityToJson(data as MyFocusTalentEntity);
			case MyFocusTalentSkillTagList:
				return myFocusTalentSkillTagListToJson(data as MyFocusTalentSkillTagList);
			case MyFocusTalentCardList:
				return myFocusTalentCardListToJson(data as MyFocusTalentCardList);
			case PrCardInfoEntity:
				return prCardInfoEntityToJson(data as PrCardInfoEntity);
			case PrCardInfoSkills:
				return prCardInfoSkillsToJson(data as PrCardInfoSkills);
			case EmptyEntity:
				return emptyEntityToJson(data as EmptyEntity);
			case TalentEntity:
				return talentEntityToJson(data as TalentEntity);
			case TalentCard:
				return talentCardToJson(data as TalentCard);
			case TalentSkill:
				return talentSkillToJson(data as TalentSkill);
			case BaseInfoEntity:
				return baseInfoEntityToJson(data as BaseInfoEntity);
			case GlobalEntity:
				return globalEntityToJson(data as GlobalEntity);
			case QRCodeEntity:
				return qRCodeEntityToJson(data as QRCodeEntity);
			case ActivityLinkResultEntity:
				return activityLinkResultEntityToJson(data as ActivityLinkResultEntity);
			case CardEntity:
				return cardEntityToJson(data as CardEntity);
			case CardItemEntity:
				return cardItemEntityToJson(data as CardItemEntity);
			case SkillTagItemEntity:
				return skillTagItemEntityToJson(data as SkillTagItemEntity);
			case WaimaiEntity:
				return waimaiEntityToJson(data as WaimaiEntity);
			case MyCollectEntity:
				return myCollectEntityToJson(data as MyCollectEntity);
			case MyCollectSkillTagList:
				return myCollectSkillTagListToJson(data as MyCollectSkillTagList);
			case CardWoksList:
				return cardWoksListToJson(data as CardWoksList);
			case MyBrowseRecordEntity:
				return myBrowseRecordEntityToJson(data as MyBrowseRecordEntity);
			case MyBrowseRecordSkillTagList:
				return myBrowseRecordSkillTagListToJson(data as MyBrowseRecordSkillTagList);
			case AliOssEntity:
				return aliOssEntityToJson(data as AliOssEntity);
			case SkillEntity:
				return skillEntityToJson(data as SkillEntity);
			case GoodsEntity:
				return goodsEntityToJson(data as GoodsEntity);
			case UserCenterEntity:
				return userCenterEntityToJson(data as UserCenterEntity);
			case UserCenterCardInfoList:
				return userCenterCardInfoListToJson(data as UserCenterCardInfoList);
			case BankEntity:
				return bankEntityToJson(data as BankEntity);
			case NoticeNewestMsgEntity:
				return noticeNewestMsgEntityToJson(data as NoticeNewestMsgEntity);
			case NewMessageEntity:
				return newMessageEntityToJson(data as NewMessageEntity);
			case PrListSkillEntity:
				return prListSkillEntityToJson(data as PrListSkillEntity);
			case NoticeReadStatusEntity:
				return noticeReadStatusEntityToJson(data as NoticeReadStatusEntity);
			case AdTaskEntity:
				return adTaskEntityToJson(data as AdTaskEntity);
			case LoginEntity:
				return loginEntityToJson(data as LoginEntity);
			case TelephoneBillEntity:
				return telephoneBillEntityToJson(data as TelephoneBillEntity);
			case GoodsLinkEntity:
				return goodsLinkEntityToJson(data as GoodsLinkEntity);
			case GoodsLinkCouponInfo:
				return goodsLinkCouponInfoToJson(data as GoodsLinkCouponInfo);
			case GoodsLinkWeAppInfo:
				return goodsLinkWeAppInfoToJson(data as GoodsLinkWeAppInfo);
			case NoticeEntity:
				return noticeEntityToJson(data as NoticeEntity);
			case NoticeItemEntity:
				return noticeItemEntityToJson(data as NoticeItemEntity);
			case GoodsDetailEntity:
				return goodsDetailEntityToJson(data as GoodsDetailEntity);
			}
			return data as T;
		}
  //Go back to a single instance by type
	static _fromJsonSingle<M>( json) {
		String type = M.toString();
		if(type == (MyFocusTalentEntity).toString()){
			return MyFocusTalentEntity().fromJson(json);
		}
		if(type == (MyFocusTalentSkillTagList).toString()){
			return MyFocusTalentSkillTagList().fromJson(json);
		}
		if(type == (MyFocusTalentCardList).toString()){
			return MyFocusTalentCardList().fromJson(json);
		}
		if(type == (PrCardInfoEntity).toString()){
			return PrCardInfoEntity().fromJson(json);
		}
		if(type == (PrCardInfoSkills).toString()){
			return PrCardInfoSkills().fromJson(json);
		}
		if(type == (EmptyEntity).toString()){
			return EmptyEntity().fromJson(json);
		}
		if(type == (TalentEntity).toString()){
			return TalentEntity().fromJson(json);
		}
		if(type == (TalentCard).toString()){
			return TalentCard().fromJson(json);
		}
		if(type == (TalentSkill).toString()){
			return TalentSkill().fromJson(json);
		}
		if(type == (BaseInfoEntity).toString()){
			return BaseInfoEntity().fromJson(json);
		}
		if(type == (GlobalEntity).toString()){
			return GlobalEntity().fromJson(json);
		}
		if(type == (QRCodeEntity).toString()){
			return QRCodeEntity().fromJson(json);
		}
		if(type == (ActivityLinkResultEntity).toString()){
			return ActivityLinkResultEntity().fromJson(json);
		}
		if(type == (CardEntity).toString()){
			return CardEntity().fromJson(json);
		}
		if(type == (CardItemEntity).toString()){
			return CardItemEntity().fromJson(json);
		}
		if(type == (SkillTagItemEntity).toString()){
			return SkillTagItemEntity().fromJson(json);
		}
		if(type == (WaimaiEntity).toString()){
			return WaimaiEntity().fromJson(json);
		}
		if(type == (MyCollectEntity).toString()){
			return MyCollectEntity().fromJson(json);
		}
		if(type == (MyCollectSkillTagList).toString()){
			return MyCollectSkillTagList().fromJson(json);
		}
		if(type == (CardWoksList).toString()){
			return CardWoksList().fromJson(json);
		}
		if(type == (MyBrowseRecordEntity).toString()){
			return MyBrowseRecordEntity().fromJson(json);
		}
		if(type == (MyBrowseRecordSkillTagList).toString()){
			return MyBrowseRecordSkillTagList().fromJson(json);
		}
		if(type == (AliOssEntity).toString()){
			return AliOssEntity().fromJson(json);
		}
		if(type == (SkillEntity).toString()){
			return SkillEntity().fromJson(json);
		}
		if(type == (GoodsEntity).toString()){
			return GoodsEntity().fromJson(json);
		}
		if(type == (UserCenterEntity).toString()){
			return UserCenterEntity().fromJson(json);
		}
		if(type == (UserCenterCardInfoList).toString()){
			return UserCenterCardInfoList().fromJson(json);
		}
		if(type == (BankEntity).toString()){
			return BankEntity().fromJson(json);
		}
		if(type == (NoticeNewestMsgEntity).toString()){
			return NoticeNewestMsgEntity().fromJson(json);
		}
		if(type == (NewMessageEntity).toString()){
			return NewMessageEntity().fromJson(json);
		}
		if(type == (PrListSkillEntity).toString()){
			return PrListSkillEntity().fromJson(json);
		}
		if(type == (NoticeReadStatusEntity).toString()){
			return NoticeReadStatusEntity().fromJson(json);
		}
		if(type == (AdTaskEntity).toString()){
			return AdTaskEntity().fromJson(json);
		}
		if(type == (LoginEntity).toString()){
			return LoginEntity().fromJson(json);
		}
		if(type == (TelephoneBillEntity).toString()){
			return TelephoneBillEntity().fromJson(json);
		}
		if(type == (GoodsLinkEntity).toString()){
			return GoodsLinkEntity().fromJson(json);
		}
		if(type == (GoodsLinkCouponInfo).toString()){
			return GoodsLinkCouponInfo().fromJson(json);
		}
		if(type == (GoodsLinkWeAppInfo).toString()){
			return GoodsLinkWeAppInfo().fromJson(json);
		}
		if(type == (NoticeEntity).toString()){
			return NoticeEntity().fromJson(json);
		}
		if(type == (NoticeItemEntity).toString()){
			return NoticeItemEntity().fromJson(json);
		}
		if(type == (GoodsDetailEntity).toString()){
			return GoodsDetailEntity().fromJson(json);
		}

		return null;
	}

  //list is returned by type
	static M _getListChildType<M>(List data) {
		if(<MyFocusTalentEntity>[] is M){
			return data.map<MyFocusTalentEntity>((e) => MyFocusTalentEntity().fromJson(e)).toList() as M;
		}
		if(<MyFocusTalentSkillTagList>[] is M){
			return data.map<MyFocusTalentSkillTagList>((e) => MyFocusTalentSkillTagList().fromJson(e)).toList() as M;
		}
		if(<MyFocusTalentCardList>[] is M){
			return data.map<MyFocusTalentCardList>((e) => MyFocusTalentCardList().fromJson(e)).toList() as M;
		}
		if(<PrCardInfoEntity>[] is M){
			return data.map<PrCardInfoEntity>((e) => PrCardInfoEntity().fromJson(e)).toList() as M;
		}
		if(<PrCardInfoSkills>[] is M){
			return data.map<PrCardInfoSkills>((e) => PrCardInfoSkills().fromJson(e)).toList() as M;
		}
		if(<EmptyEntity>[] is M){
			return data.map<EmptyEntity>((e) => EmptyEntity().fromJson(e)).toList() as M;
		}
		if(<TalentEntity>[] is M){
			return data.map<TalentEntity>((e) => TalentEntity().fromJson(e)).toList() as M;
		}
		if(<TalentCard>[] is M){
			return data.map<TalentCard>((e) => TalentCard().fromJson(e)).toList() as M;
		}
		if(<TalentSkill>[] is M){
			return data.map<TalentSkill>((e) => TalentSkill().fromJson(e)).toList() as M;
		}
		if(<BaseInfoEntity>[] is M){
			return data.map<BaseInfoEntity>((e) => BaseInfoEntity().fromJson(e)).toList() as M;
		}
		if(<GlobalEntity>[] is M){
			return data.map<GlobalEntity>((e) => GlobalEntity().fromJson(e)).toList() as M;
		}
		if(<QRCodeEntity>[] is M){
			return data.map<QRCodeEntity>((e) => QRCodeEntity().fromJson(e)).toList() as M;
		}
		if(<ActivityLinkResultEntity>[] is M){
			return data.map<ActivityLinkResultEntity>((e) => ActivityLinkResultEntity().fromJson(e)).toList() as M;
		}
		if(<CardEntity>[] is M){
			return data.map<CardEntity>((e) => CardEntity().fromJson(e)).toList() as M;
		}
		if(<CardItemEntity>[] is M){
			return data.map<CardItemEntity>((e) => CardItemEntity().fromJson(e)).toList() as M;
		}
		if(<SkillTagItemEntity>[] is M){
			return data.map<SkillTagItemEntity>((e) => SkillTagItemEntity().fromJson(e)).toList() as M;
		}
		if(<WaimaiEntity>[] is M){
			return data.map<WaimaiEntity>((e) => WaimaiEntity().fromJson(e)).toList() as M;
		}
		if(<MyCollectEntity>[] is M){
			return data.map<MyCollectEntity>((e) => MyCollectEntity().fromJson(e)).toList() as M;
		}
		if(<MyCollectSkillTagList>[] is M){
			return data.map<MyCollectSkillTagList>((e) => MyCollectSkillTagList().fromJson(e)).toList() as M;
		}
		if(<CardWoksList>[] is M){
			return data.map<CardWoksList>((e) => CardWoksList().fromJson(e)).toList() as M;
		}
		if(<MyBrowseRecordEntity>[] is M){
			return data.map<MyBrowseRecordEntity>((e) => MyBrowseRecordEntity().fromJson(e)).toList() as M;
		}
		if(<MyBrowseRecordSkillTagList>[] is M){
			return data.map<MyBrowseRecordSkillTagList>((e) => MyBrowseRecordSkillTagList().fromJson(e)).toList() as M;
		}
		if(<AliOssEntity>[] is M){
			return data.map<AliOssEntity>((e) => AliOssEntity().fromJson(e)).toList() as M;
		}
		if(<SkillEntity>[] is M){
			return data.map<SkillEntity>((e) => SkillEntity().fromJson(e)).toList() as M;
		}
		if(<GoodsEntity>[] is M){
			return data.map<GoodsEntity>((e) => GoodsEntity().fromJson(e)).toList() as M;
		}
		if(<UserCenterEntity>[] is M){
			return data.map<UserCenterEntity>((e) => UserCenterEntity().fromJson(e)).toList() as M;
		}
		if(<UserCenterCardInfoList>[] is M){
			return data.map<UserCenterCardInfoList>((e) => UserCenterCardInfoList().fromJson(e)).toList() as M;
		}
		if(<BankEntity>[] is M){
			return data.map<BankEntity>((e) => BankEntity().fromJson(e)).toList() as M;
		}
		if(<NoticeNewestMsgEntity>[] is M){
			return data.map<NoticeNewestMsgEntity>((e) => NoticeNewestMsgEntity().fromJson(e)).toList() as M;
		}
		if(<NewMessageEntity>[] is M){
			return data.map<NewMessageEntity>((e) => NewMessageEntity().fromJson(e)).toList() as M;
		}
		if(<PrListSkillEntity>[] is M){
			return data.map<PrListSkillEntity>((e) => PrListSkillEntity().fromJson(e)).toList() as M;
		}
		if(<NoticeReadStatusEntity>[] is M){
			return data.map<NoticeReadStatusEntity>((e) => NoticeReadStatusEntity().fromJson(e)).toList() as M;
		}
		if(<AdTaskEntity>[] is M){
			return data.map<AdTaskEntity>((e) => AdTaskEntity().fromJson(e)).toList() as M;
		}
		if(<LoginEntity>[] is M){
			return data.map<LoginEntity>((e) => LoginEntity().fromJson(e)).toList() as M;
		}
		if(<TelephoneBillEntity>[] is M){
			return data.map<TelephoneBillEntity>((e) => TelephoneBillEntity().fromJson(e)).toList() as M;
		}
		if(<GoodsLinkEntity>[] is M){
			return data.map<GoodsLinkEntity>((e) => GoodsLinkEntity().fromJson(e)).toList() as M;
		}
		if(<GoodsLinkCouponInfo>[] is M){
			return data.map<GoodsLinkCouponInfo>((e) => GoodsLinkCouponInfo().fromJson(e)).toList() as M;
		}
		if(<GoodsLinkWeAppInfo>[] is M){
			return data.map<GoodsLinkWeAppInfo>((e) => GoodsLinkWeAppInfo().fromJson(e)).toList() as M;
		}
		if(<NoticeEntity>[] is M){
			return data.map<NoticeEntity>((e) => NoticeEntity().fromJson(e)).toList() as M;
		}
		if(<NoticeItemEntity>[] is M){
			return data.map<NoticeItemEntity>((e) => NoticeItemEntity().fromJson(e)).toList() as M;
		}
		if(<GoodsDetailEntity>[] is M){
			return data.map<GoodsDetailEntity>((e) => GoodsDetailEntity().fromJson(e)).toList() as M;
		}

		throw Exception("not found");
	}

  static M fromJsonAsT<M>(json) {
		if (json is List) {
			return _getListChildType<M>(json);
		} else {
			return _fromJsonSingle<M>(json) as M;
		}
	}
}