package com.jiankang.gouqi.entity;

import java.io.Serializable;

/**
 * @author: ljx
 * @createDate: 2020/9/23  9:18
 */
public class AdvertisementsBeanListEntity extends BaseEntity implements Serializable {
    private static final long serialVersionUID = 3590541363527348815L;
    /**
     * adImage : https://wodan-idc.oss-cn-hangzhou.aliyuncs.com/test/Upload/shijianke-mgr/artical/upload/2020-09-22/ae3a90c5fc9b4fdc91d2880c069db38d.jpg
     * adName : 启动页广告
     * adTypeValue : http://www.baidu.com 广告类型所对应的值，广告链接、岗位专题，岗位广告、雇主广告
     * jobSourceValue :
     * modulePosition : 0
     * adContent :
     * channel : 0
     * jobSource : 1
     * updateName :
     * adType : 1
     * createTime : 1600704000000
     * rank : 1
     * id : 2
     * cityIds :
     * fontColor :
     * bottomColor :
     * status : 0
     * "adPositionId": xxx, // 广告位ID
     * "beginTime":xxx,// 开始时间
     * "updateBy":xxx,// 修改人ID
     * "createBy":xxx,// 创建人ID
     * "clinkNum":xxx,// '点击数',
     */
    public String adImage;
    public String adName;
    public String adPositionName;
    public String positionName;
    public String adTypeValue;
    public String jobSourceValue;
    public int modulePosition;
    public String adContent;
    public int channel;
    public int jobSource;
    public String updateName;
    public int adType;
    public long createTime;
    public int rank;
    public int id;
    public String cityIds;
    public String fontColor;
    public String bottomColor;
    public int status;
    public int popupLimit;
    public int needLogin;
    public int adPositionId;
    public int clinkNum;
    public long beginTime;
    public long endTime;
    public String item_view;
    public String createBy;
    public String updateBy;
    //云蜻sdk tab广告相关字段
    public String tabIconNoClick;
    public String tabIconClick;
    public String tabName;
    // 0直接展示， 1新开页面展示(跳转到webview)
    public int pageAdShowType;
    public int isDisplayJobClassify;//【1显示；0不显示】

}

