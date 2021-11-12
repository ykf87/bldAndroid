package com.blandal.app.entity;

import java.io.Serializable;
import java.util.List;

/**
 * @author: ljx
 * @createDate: 2020/9/22  15:30
 */
public class AdvertisementListEntity extends BaseEntity implements Serializable {
    private static final long serialVersionUID = 8214433470710288153L;
    /**
     * adStyle : 1
     * releaseModuleSys :
     * channel : 1
     * advertisementsBeanList :
     * releaseModule : 2
     * item_view : SingleImageView
     * positionName : 启动页
     * createTime : 1600759571000
     * belongPage : 4
     * rank : 1
     * column_num : 0
     * id : 11
     * createName :
     * status : 1
     * "posStreamModule”:xxx,// 职位信息流模板宽*高
     * "listInterval”:xxx,// 职位信息流列表间隔
     *   "belongProduct”:xxx,// 所属产品
     *   "belongPlatform”:xxx,//  所属平台
     *   "type”:xxx,// 0|自定义广告位；1|系统广告位
     *     "createBy”:xxx,// 创建人ID
     *    "column_num”:xxx,// 前端需要列数
     *    item_view
     *    container_type:container-threeColumn  //cell样式类型
     */

    public int adStyle;
    public String releaseModuleSys;
    public int channel;
    public String appShowName;
    public List<AdvertisementsBeanListEntity> advertisementsBeanList;
    public int releaseModule;
    public String item_view;
    public String positionName;
    public long createTime;
    public int belongPage;
    public int rank;
    public int column_num;
    public int id;
    public String createName;
    public int status;
    public String posStreamModule;
    public String listInterval;
    public String belongProduct;
    public String belongPlatform;
    public String createBy;
    public int type;
    public String container_type;



}
