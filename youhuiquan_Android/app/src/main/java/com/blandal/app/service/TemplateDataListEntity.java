package com.blandal.app.service;

import java.util.List;

/**
 * 模板数据
 *
 * @author: ljx
 * @createDate: 2020/7/29 14:02
 */
public class TemplateDataListEntity {
    private String uuid;
    private String areaId;
    private String productPackage;
    private int clientType;
    private String accessCode;
    private String childrenAccessCode;
    private List<TemplateDataEntity> ossList;

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public String getAreaId() {
        return areaId;
    }

    public void setAreaId(String areaId) {
        this.areaId = areaId;
    }

    public String getProductPackage() {
        return productPackage;
    }

    public void setProductPackage(String productPackage) {
        this.productPackage = productPackage;
    }

    public int getClientType() {
        return clientType;
    }

    public void setClientType(int clientType) {
        this.clientType = clientType;
    }

    public String getAccessCode() {
        return accessCode;
    }

    public void setAccessCode(String accessCode) {
        this.accessCode = accessCode;
    }

    public String getChildrenAccessCode() {
        return childrenAccessCode;
    }

    public void setChildrenAccessCode(String childrenAccessCode) {
        this.childrenAccessCode = childrenAccessCode;
    }

    public List<TemplateDataEntity> getOssList() {
        return ossList;
    }

    public void setOssList(List<TemplateDataEntity> ossList) {
        this.ossList = ossList;
    }
}
