package com.jiankang.gouqi.service;

import java.util.Map;

import io.reactivex.rxjava3.core.Observable;
import okhttp3.MultipartBody;
import okhttp3.ResponseBody;
import retrofit2.http.GET;
import retrofit2.http.Header;
import retrofit2.http.Multipart;
import retrofit2.http.POST;
import retrofit2.http.Part;
import retrofit2.http.Path;
import retrofit2.http.QueryMap;
import retrofit2.http.Streaming;
import retrofit2.http.Url;

/**
 * 网络请求的service
 */

public interface ApiService {
    /**
     * 接口正式环境
     */
    String URL = "http://45.77.216.241/api/";

    String BASE_SERVICE_URL = URL+ "{service}";
    String BASE_URL = URL;


    /**
     * 调用接口post:提交类
     *
     * @param service 方法名
     * @return param 参数列表
     */
    @POST(BASE_SERVICE_URL)
    Observable<ApiResponse> postData(@Path("service") String service, @QueryMap Map<String, String> param);

    /**
     * 调用接口get:获取类
     * @param service 方法名
     * @return param 参数列表
     */
    @GET(BASE_SERVICE_URL)
    Observable<ApiResponse> getData(@Path("service") String service, @QueryMap Map<String, String> param);

    /**
     * 下载文件
     */
    @Streaming
    @GET
    Observable<ResponseBody> downloadFile(@Header("Range") String range, @Url String url);

    /**
     * 下载文件
     */
    @Streaming
    @GET
    Observable<ResponseBody> downloadFile(@Url String url);

    @Multipart
    @POST(BASE_SERVICE_URL)
    Observable<ApiResponse> uploadSingleImg(@Path("service") String service, @Part MultipartBody.Part file);


}