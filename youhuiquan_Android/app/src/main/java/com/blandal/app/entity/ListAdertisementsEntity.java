package com.blandal.app.entity;

import java.io.Serializable;
import java.util.List;

/**
 * @author: ljx
 * @createDate: 2020/9/22  15:34
 */
public class ListAdertisementsEntity extends BaseEntity implements Serializable {
    private static final long serialVersionUID = -7801253730179157178L;
    public List<AdvertisementListEntity> adPositionList;
}
