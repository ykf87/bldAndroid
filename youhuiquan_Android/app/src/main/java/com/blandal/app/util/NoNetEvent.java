package com.blandal.app.util;

/**
 * @author: ljx
 * @createDate: 2020/10/19  14:43
 */
public class NoNetEvent {
    private boolean hasNet;


    public NoNetEvent(boolean hasNet) {
        this.hasNet = hasNet;
    }

    public boolean isHasNet() {
        return hasNet;
    }

    public void setHasNet(boolean hasNet) {
        this.hasNet = hasNet;
    }


}
