package com.blandal.app.ui.my.entity;

import java.util.List;

/**
 * @author: ljx
 * @createDate: 2020/11/19  17:41
 */
public class GiveUpCommonMsg {
    //放弃原因
    public List<AbandonCommonMsg> abandon_common_msg;
    //雇主拒绝原因
    public List<AbandonCommonMsg> reject_common_msg;

    public static class AbandonCommonMsg {
        public String content;
        public int id;
        public boolean isCheck;
    }
}
