package com.blandal.app.service;


import android.annotation.SuppressLint;
import android.content.Context;
import android.os.Handler;
import android.os.Looper;
import android.text.TextUtils;

import com.alibaba.fastjson.TypeReference;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.internal.LinkedTreeMap;

import org.jetbrains.annotations.NotNull;

import java.io.File;
import java.io.IOException;
import java.io.RandomAccessFile;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import autodispose2.AutoDisposeConverter;
import com.blandal.app.app.MyApplication;
import com.blandal.app.common.MyHandler;
import com.blandal.app.ui.login.entity.SessionEntity;
import com.blandal.app.util.FastJsonUtils;
import com.blandal.app.util.JsonUtils;
import com.blandal.app.util.LogUtils;
import com.blandal.app.util.LoginUtils;
import com.blandal.app.util.SystemUtil;
import com.blandal.app.util.UserShared;
import io.reactivex.rxjava3.android.schedulers.AndroidSchedulers;
import io.reactivex.rxjava3.annotations.NonNull;
import io.reactivex.rxjava3.annotations.Nullable;
import io.reactivex.rxjava3.core.Observable;
import io.reactivex.rxjava3.core.Observer;
import io.reactivex.rxjava3.disposables.Disposable;
import io.reactivex.rxjava3.functions.Consumer;
import io.reactivex.rxjava3.functions.Function;
import io.reactivex.rxjava3.schedulers.Schedulers;
import me.jessyan.retrofiturlmanager.RetrofitUrlManager;
import okhttp3.Call;
import okhttp3.HttpUrl;
import okhttp3.Interceptor;
import okhttp3.MediaType;
import okhttp3.MultipartBody;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;
import okhttp3.ResponseBody;
import retrofit2.HttpException;
import retrofit2.Retrofit;
import retrofit2.adapter.rxjava3.RxJava3CallAdapterFactory;
import retrofit2.converter.gson.GsonConverterFactory;

/**
 * 网络请求引擎类
 *
 * @author: ljx
 * @createDate: 2020/6/12 18:31
 */
public class RetrofitService {
    //超时时间
    private static final int TIME = 8;
    //上传照片超时时间
    private static final int UP_IMG_TIME = 20;

    private volatile static OkHttpClient mOkHttpClient;

    private volatile static ApiService mAPI = null;

    private static boolean sIsCreateSession = false;

    private RetrofitService() {
    }

    private volatile static RetrofitService instance = null;


    public static RetrofitService getInstance() {
        if (instance == null) {
            synchronized (RetrofitService.class) {
                if (instance == null) {
                    instance = new RetrofitService();
                }
            }
        }
        return instance;
    }

    /**
     * 获取ApiService
     */
    public ApiService getApiService() {
        initOkHttpClient();
        if (mAPI == null) {
            mAPI = new Retrofit.Builder()
                    .client(mOkHttpClient)
                    .baseUrl(ApiService.BASE_URL)
                    .addCallAdapterFactory(RxJava3CallAdapterFactory.create())
                    .callFactory(new CallFactoryProxy(mOkHttpClient) {
                        @Nullable
                        @Override
                        protected HttpUrl getNewUrl(String baseUrlName, Request request) {
                            //处理多BaseUrl
                            String oldUrl = request.url().toString();
                            if (!baseUrlName.equals(oldUrl)) {
                                String newUrl = oldUrl.replace(oldUrl, baseUrlName);
                                return HttpUrl.get(newUrl);
                            }
                            return null;
                        }
                    })
                    .addConverterFactory(GsonConverterFactory.create())
                    .build().create(ApiService.class);
        }
        return mAPI;
    }

    /**
     * 配置OkHttpClient
     */
    private static void initOkHttpClient() {
        if (mOkHttpClient == null) {
            Interceptor headerInterceptor = new Interceptor() {
                @Override
                public Response intercept(Chain chain) throws IOException {
                    Request originalRequest = chain.request();
                    Request.Builder requestBuilder = originalRequest.newBuilder()
                            .addHeader("Authorization", UserShared.getToken(MyApplication.getContext()))
                            .method(originalRequest.method(), originalRequest.body());
                    Request request = requestBuilder.build();
                    LogUtils.data("token：" + UserShared.getToken(MyApplication.getContext()));
                    return chain.proceed(request);
                }
            };

            //okhttp 3
            OkHttpClient.Builder builder = new OkHttpClient.Builder()
                    .addInterceptor(headerInterceptor)
                    .connectTimeout(TIME, TimeUnit.SECONDS)
                    .readTimeout(TIME, TimeUnit.SECONDS)
                    .writeTimeout(TIME, TimeUnit.SECONDS)
                    .sslSocketFactory(RxUtils.createSSLSocketFactory())
                    .hostnameVerifier(new RxUtils.TrustAllHostnameVerifier())
                    .addInterceptor(new LogInterceptor());
            mOkHttpClient = RetrofitUrlManager.getInstance().with(builder).build();

        }
    }

    /**
     * 请求的URL地址根据参数baseUrlName动态切换
     */
    public abstract class CallFactoryProxy implements Call.Factory {
        private static final String NAME_BASE_URL = "baseUrlName";
        private final Call.Factory delegate;

        public CallFactoryProxy(Call.Factory delegate) {
            this.delegate = delegate;
        }

        @Override
        public Call newCall(Request request) {
            String baseUrlName = request.header(NAME_BASE_URL);
            if (baseUrlName != null) {
                HttpUrl newHttpUrl = getNewUrl(baseUrlName, request);
                if (newHttpUrl != null) {
                    Request newRequest = request.newBuilder().url(newHttpUrl).build();
                    return delegate.newCall(newRequest);
                } else {
                    LogUtils.e("xjs", "getNewUrl() return null when baseUrlName==" + baseUrlName);
                }
            }
            return delegate.newCall(request);
        }

        @Nullable
        protected abstract HttpUrl getNewUrl(String baseUrlName, Request request);
    }

    /**
     * 请求访问quest和response拦截器
     */
    private static class LogInterceptor implements Interceptor {
        @NotNull
        @Override
        public Response intercept(@NotNull Chain chain) throws IOException {
            Request request = chain.request();
            long startTime = System.currentTimeMillis();
            Response response = chain.proceed(request);
            long endTime = System.currentTimeMillis();
            long duration = endTime - startTime;
            okhttp3.MediaType mediaType = response.body().contentType();
            byte[] content = response.body().bytes();
            if (HttpUtility.isOutLog) {
                LogUtils.data("请求用时:" + duration + "毫秒----------");
            }
            return response.newBuilder()
                    .body(ResponseBody.create(mediaType, content))
                    .build();
        }
    }

    /**
     * 上传文件
     *
     * @param fileUrl         文件路径
     * @param requestListener 回调
     * @param bindAutoDispose 生命周期
     */
    public void uploadImg(String fileUrl, final OnNetRequestListener requestListener, AutoDisposeConverter<ApiResponse> bindAutoDispose) {

        File file = new File(fileUrl);
        RequestBody requestFile = RequestBody.create(MediaType.parse("image/jpg"), file);
        MultipartBody.Part body = MultipartBody.Part.createFormData("file", file.getName(), requestFile);
        Observable<ApiResponse> observable = getInstance().getApiService().uploadSingleImg("fileUpload/ossFileUpload", body);
        observable.subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .doOnSubscribe(new Consumer<Disposable>() {
                    @Override
                    public void accept(Disposable disposable) throws Exception {

                    }
                })
                .to(bindAutoDispose)
                .subscribe(new Observer<ApiResponse>() {
                    @Override
                    public void onSubscribe(@NonNull Disposable d) {

                    }

                    @Override
                    public void onNext(@NonNull ApiResponse apiResponse) {
                        if (HttpUtility.isOutLog) {
                            LogUtils.data("请求接口：fileUpload/ossFileUpload");
                            LogUtils.data("请求数据：" + fileUrl);
                            LogUtils.data("返回数据：" + JsonUtils.toJson(apiResponse));
                            LogUtils.data("数据大小：" + apiResponse.toString().length() + " 字节");
                        }

                        Class<?> clz = getInterfaceT(requestListener, 0);
                        LinkedTreeMap<String, String> linkmap_1 = (LinkedTreeMap<String, String>) apiResponse.getData();
                        Gson gson = new GsonBuilder().enableComplexMapKeySerialization().create();
                        String jsonString = gson.toJson(linkmap_1);
                        ApiResponse response = new ApiResponse();
                        response.setCode(apiResponse.getCode());
                        response.setMsg(apiResponse.getMsg());
                        response.setData(rData(clz, jsonString));
                        if (requestListener != null) {
                            requestListener.onSuccess(response);
                        }
                    }

                    @Override
                    public void onError(@NonNull Throwable e) {
                        if (HttpUtility.isOutLog) {
                            LogUtils.data("请求接口：fileUpload/ossFileUpload");
                            LogUtils.data("请求数据：" + fileUrl);
                            LogUtils.data("返回错误：" + e.getMessage());
                        }
                        if (requestListener != null) {
                            requestListener.onFailure(e);
                        }
                    }

                    @Override
                    public void onComplete() {

                    }
                });

    }

    /**
     * 下载文件
     *
     * @param url      地址
     * @param filePath 下载路径
     * @param callback 回调
     */
    public void downloadFile(final String url, final String filePath, final DownloadCallback callback) {
        if (TextUtils.isEmpty(url) || TextUtils.isEmpty(filePath)) {
            if (null != callback) {
                callback.onError("url or path empty");
            }
            return;
        }


        downloadFile(url, DownloadUtils.getTempFile(url, filePath).length(), new Observer<ResponseBody>() {
            @Override
            public void onSubscribe(Disposable d) {
                if (null != callback) {
                    callback.onStart(d);
                }
            }

            @Override
            public void onNext(final ResponseBody responseBody) {
                //将Response写入到从磁盘中
                //注意，这个方法是运行在子线程中的
                saveFile(responseBody, url, filePath, callback);
            }

            @Override
            public void onError(Throwable e) {
                e.printStackTrace();
                LogUtils.i("onError " + e.getMessage());
                if (null != callback) {
                    callback.onError(e.getMessage());
                }
            }

            @Override
            public void onComplete() {
                LogUtils.i("download onComplete ");
            }
        });

    }

    private void saveFile(final ResponseBody responseBody, String url, final String filePath, final DownloadCallback callback) {
        boolean downloadSuccss = true;
        final File tempFile = DownloadUtils.getTempFile(url, filePath);
        try {
            writeFileToDisk(responseBody, tempFile.getAbsolutePath(), callback);
        } catch (Exception e) {
            e.printStackTrace();
            downloadSuccss = false;
        }

        if (downloadSuccss) {
            final boolean renameSuccess = tempFile.renameTo(new File(filePath));
            new Handler(Looper.getMainLooper()).post(new Runnable() {
                @Override
                public void run() {
                    if (null != callback && renameSuccess) {
                        callback.onFinish(new File(filePath));
                    }
                }
            });
        }
    }

    @SuppressLint("DefaultLocale")
    private static void writeFileToDisk(ResponseBody responseBody, String filePath, final DownloadCallback callback) throws IOException {
        long totalByte = responseBody.contentLength();
        long downloadByte = 0;
        File file = new File(filePath);
        if (!file.getParentFile().exists()) {
            file.getParentFile().mkdirs();
        }

        byte[] buffer = new byte[1024 * 4];
        RandomAccessFile randomAccessFile = new RandomAccessFile(file, "rwd");
        long tempFileLen = file.length();
        randomAccessFile.seek(tempFileLen);
        while (true) {
            int len = responseBody.byteStream().read(buffer);
            if (len == -1) {
                break;
            }
            randomAccessFile.write(buffer, 0, len);
            downloadByte += len;
            callbackProgress(tempFileLen + totalByte, tempFileLen + downloadByte, callback);
        }
        randomAccessFile.close();
    }

    private static void callbackProgress(final long totalByte, final long downloadByte, final DownloadCallback callback) {
        new Handler(Looper.getMainLooper()).post(new Runnable() {
            @SuppressLint("DefaultLocale")
            @Override
            public void run() {
                if (null != callback) {
                    callback.onProgress(totalByte, downloadByte, (int) ((downloadByte * 100) / totalByte));
                }
            }
        });
    }

    /**
     * 下载文件请求
     */
    public static void downloadFile(String url, long startPos, Observer<ResponseBody> observer) {
        getInstance().getApiService().downloadFile("bytes=" + startPos + "-", url)
                .subscribeOn(Schedulers.io())
                .unsubscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe(observer);
    }

    /**
     * 提交接口数据
     *
     * @param context         上下文
     * @param service         方法名
     * @param map             参数列表
     * @param requestListener 回调<实体类>
     * @param bindAutoDispose 生命周期
     */
    public static void postData(Context context, String service, Map<String, String> map, final OnNetRequestListener requestListener, AutoDisposeConverter<ApiResponse> bindAutoDispose) {
        if (map == null) {
            map = new HashMap<>();
        }
        addCommonParam(context, map);
        Observable<ApiResponse> observable = getInstance().getApiService().postData(service, map);

        Map<String, String> finalMap = map;
        observable.subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .doOnSubscribe(new Consumer<Disposable>() {
                    @Override
                    public void accept(Disposable disposable) throws Exception {

                    }
                })
                .to(bindAutoDispose)
                .subscribe(new Observer<ApiResponse>() {
                    @Override
                    public void onSubscribe(@NonNull Disposable d) {

                    }

                    @Override
                    public void onNext(@NonNull ApiResponse apiResponse) {
                        if (HttpUtility.isOutLog) {
                            LogUtils.data("请求接口：" + service);
                            LogUtils.data("请求数据：" + finalMap.toString());
                            LogUtils.data("返回数据：" + JsonUtils.toJson(apiResponse));
                            LogUtils.data("数据大小：" + apiResponse.toString().length() + " 字节");
                        }

                        if (requestListener != null) {
                            Class<?> clz = getInterfaceT(requestListener, 0);

                            ApiResponse response = new ApiResponse();
                            response.setCode(apiResponse.getCode());
                            response.setMsg(apiResponse.getMsg());
                            if (apiResponse.getData() == null) {
                                requestListener.onSuccess(response);
                                return;
                            }

                            String json = JsonUtils.toJson(apiResponse);
                            ApiResponse<String> baseResponse = FastJsonUtils.toBean(json, new TypeReference<ApiResponse<String>>() {
                            });
                            if (baseResponse.getData().startsWith("[") && baseResponse.getData().endsWith("]")) {
                                Type type = new ParameterizedType() {
                                    @Override
                                    public Type[] getActualTypeArguments() {
                                        return new Type[]{clz};
                                    }

                                    @Override
                                    public Type getOwnerType() {
                                        return ArrayList.class;
                                    }

                                    @Override
                                    public Type getRawType() {
                                        return ArrayList.class;
                                    }
                                };
                                response.setData(FastJsonUtils.toBean(baseResponse.getData(), type));
                            } else if (baseResponse.getData().startsWith("{") && baseResponse.getData().endsWith("}")) {
                                LinkedTreeMap<String, String> linkmap_1 = (LinkedTreeMap<String, String>) apiResponse.getData();
                                Gson gson = new GsonBuilder().enableComplexMapKeySerialization().create();
                                String jsonString = gson.toJson(linkmap_1);
                                response.setData(rData(clz, jsonString));
                            } else {
                                requestListener.onSuccess(response);
                                return;
                            }
                            requestListener.onSuccess(response);
                        }
                    }

                    @Override
                    public void onError(@NonNull Throwable e) {
                        if (HttpUtility.isOutLog) {
                            LogUtils.data("请求接口：" + service);
                            LogUtils.data("请求数据：" + finalMap.toString());
                            LogUtils.data("返回错误：" + e.getMessage());
                        }
                        Throwable throwable = e;
                        while (throwable.getCause() != null) {
                            e = throwable;
                            throwable = throwable.getCause();
                        }
                        ApiException ex;
                        if (e instanceof HttpException) { //HTTP错误
                            HttpException httpException = (HttpException) e;
                            ex = new ApiException(e, httpException.code());
                            if (httpException.code() == 401) {
                                LoginUtils.toLoginActivity(new MyHandler(), MyApplication.getContext());
                            }
                        }

                        if (requestListener != null) {
                            requestListener.onFailure(e);
                        }
                    }

                    @Override
                    public void onComplete() {

                    }
                });
    }


    /**
     * 获取接口数据
     *
     * @param context         上下文
     * @param service         方法名
     * @param param           参数列表
     * @param requestListener 回调<实体类>
     * @param bindAutoDispose 生命周期
     */
    public static void getData(Context context, String service, Map<String, String> param, final OnNetRequestListener requestListener, AutoDisposeConverter<ApiResponse> bindAutoDispose) {
        if (param == null) {
            param = new HashMap<>();
        }
        addCommonParam(context, param);
        Observable<ApiResponse> observable = getInstance().getApiService().getData(service, param);

        Map<String, String> finalMap = param;
        observable.subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .doOnSubscribe(new Consumer<Disposable>() {
                    @Override
                    public void accept(Disposable disposable) throws Exception {

                    }
                })
                .to(bindAutoDispose)
                .subscribe(new Observer<ApiResponse>() {
                    @Override
                    public void onSubscribe(@NonNull Disposable d) {

                    }

                    @Override
                    public void onNext(@NonNull ApiResponse apiResponse) {
                        if (HttpUtility.isOutLog) {
                            LogUtils.data("请求接口：" + service);
                            LogUtils.data("请求数据：" + finalMap.toString());
                            LogUtils.data("返回数据：" + JsonUtils.toJson(apiResponse));
                            LogUtils.data("数据大小：" + apiResponse.toString().length() + " 字节");
                        }
                        // toke失效未登录
                        if (apiResponse.getCode() == ApiResponse.ERR_CODE_TOKEN) {
//                            if (!sIsCreateSession) {
//                                sIsCreateSession = true;
//                                createSession(context, service, finalMap, requestListener, bindAutoDispose);
//                            } else {
//                                getDataAgain(context, service, finalMap, requestListener, bindAutoDispose);
//                            }
                            LoginUtils.toLoginActivity(new MyHandler(), MyApplication.getContext());
                        } else {
                            if (requestListener != null) {
                                Class<?> clz = getInterfaceT(requestListener, 0);

                                ApiResponse response = new ApiResponse();
                                response.setCode(apiResponse.getCode());
                                response.setMsg(apiResponse.getMsg());
                                if (apiResponse.getData() == null) {
                                    requestListener.onSuccess(response);
                                    return;
                                }
                                String json = JsonUtils.toJson(apiResponse);
                                ApiResponse<String> baseResponse = FastJsonUtils.toBean(json, new TypeReference<ApiResponse<String>>() {
                                });
                                if (baseResponse.getData().startsWith("[") && baseResponse.getData().endsWith("]")) {
                                    Type type = new ParameterizedType() {
                                        @Override
                                        public Type[] getActualTypeArguments() {
                                            return new Type[]{clz};
                                        }

                                        @Override
                                        public Type getOwnerType() {
                                            return ArrayList.class;
                                        }

                                        @Override
                                        public Type getRawType() {
                                            return ArrayList.class;
                                        }
                                    };
                                    response.setData(FastJsonUtils.toBean(baseResponse.getData(), type));
                                } else {
                                    LinkedTreeMap<String, String> linkmap_1 = (LinkedTreeMap<String, String>) apiResponse.getData();
                                    Gson gson = new GsonBuilder().enableComplexMapKeySerialization().create();
                                    String jsonString = gson.toJson(linkmap_1);
                                    response.setData(rData(clz, jsonString));
                                }

                                requestListener.onSuccess(response);
                            }
                        }
                    }

                    @Override
                    public void onError(@NonNull Throwable e) {
                        Throwable throwable = e;
                        while (throwable.getCause() != null) {
                            e = throwable;
                            throwable = throwable.getCause();
                        }
                        ApiException ex;
                        if (e instanceof HttpException) {             //HTTP错误
                            HttpException httpException = (HttpException) e;
                            ex = new ApiException(e, httpException.code());
                            if (httpException.code() == 401) {
                                LoginUtils.toLoginActivity(new MyHandler(), MyApplication.getContext());
                            }
                        }

                        if (HttpUtility.isOutLog) {
                            LogUtils.data("请求接口：" + service);
                            LogUtils.data("请求数据：" + finalMap.toString());
                            LogUtils.data("返回错误：" + e.getMessage());
                        }
                        if (requestListener != null) {
                            requestListener.onFailure(e);
                        }
                    }

                    @Override
                    public void onComplete() {

                    }
                });
    }

    /**
     * 获取接口上的泛型T
     *
     * @param o     接口
     * @param index 泛型索引
     */
    private static Class<?> getInterfaceT(Object o, int index) {
        Type[] types = o.getClass().getGenericInterfaces();
        ParameterizedType parameterizedType = (ParameterizedType) types[index];
        Type type = parameterizedType.getActualTypeArguments()[index];
        return checkType(type, index);

    }

    private static Class<?> checkType(Type type, int index) {
        if (type instanceof Class<?>) {
            return (Class<?>) type;
        } else if (type instanceof ParameterizedType) {
            ParameterizedType pt = (ParameterizedType) type;
            Type t = pt.getActualTypeArguments()[index];
            return checkType(t, index);
        } else {
            String className = type == null ? "null" : type.getClass().getName();
            throw new IllegalArgumentException("Expected a Class, ParameterizedType"
                    + ", but <" + type + "> is of type " + className);
        }
    }

    /**
     * 返回数据
     */
    @SuppressWarnings({"unchecked", "rawtypes"})
    private static <T> T rData(Class entityClass, String json) {
        try {
            T message = (T) new GsonHelper<Object>().fromJsonToEntity(json,
                    entityClass);
            // 如果父类是BaseEntity的情况，表示加载成功
            if (message.getClass().getSuperclass().getName()
                    .lastIndexOf("BaseEntity") >= 0) {
                //((BaseEntity) message).init(pRHttpEntity.getErrCode(), pRHttpEntity.getErr(), pRHttpEntity.getData());
            }
            return message;
        } catch (Exception e) {
            return null;
        }
    }

    /**
     * 返回数据
     */
    @SuppressWarnings({"unchecked", "rawtypes"})
    public static <T> T objectToEntity(Class entityClass, Object object) {
        try {
            LinkedTreeMap<String, String> linkmap_1 = (LinkedTreeMap<String, String>) object;
            Gson gson = new GsonBuilder().enableComplexMapKeySerialization().create();
            String jsonString = gson.toJson(linkmap_1);

            T message = (T) new GsonHelper<Object>().fromJsonToEntity(jsonString,
                    entityClass);
            // 如果父类是BaseEntity的情况，表示加载成功
            if (message.getClass().getSuperclass().getName()
                    .lastIndexOf("BaseEntity") >= 0) {
                //((BaseEntity) message).init(pRHttpEntity.getErrCode(), pRHttpEntity.getErr(), pRHttpEntity.getData());
            }
            return message;
        } catch (Exception e) {
            return null;
        }
    }

    public static void addCommonParam(Context context, Map<String, String> map) {
        int version = SystemUtil.getVersion(context);
        String package_name = context.getPackageName();
        String imei = SystemUtil.getIMEI(context, 0);
        String androidId = SystemUtil.getAndroidId(context);
        String oaid = UserShared.getOAID(context);
        String brand = SystemUtil.getDeviceBrand();
        try {

            if (!map.containsKey("package_name")) {
                map.put("package_name", package_name);
            }

            if (!map.containsKey("app_version_code")) {
                map.put("app_version_code", String.valueOf(version));
            }
            if (!map.containsKey("imei") && !TextUtils.isEmpty(imei)) {
                map.put("imei", imei);
            }
            if (!map.containsKey("android_id") && !TextUtils.isEmpty(androidId)) {
                map.put("android_id", androidId);
            }
            if (!map.containsKey("oaid") && !TextUtils.isEmpty(oaid)) {
                map.put("oaid", oaid);
            }
            if (!map.containsKey("device_brand")) {
                map.put("device_brand", brand);
            }
//            if (!map.containsKey("device_type")) {
//                map.put("device_type", model);
//                map.put("equipment", model);
//            }
            map.put("platform", "Android");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static void createSession(Context context, String service, Map<String, String> param, final OnNetRequestListener requestListener, AutoDisposeConverter<ApiResponse> bindAutoDispose) {
        //创建session
        Map<String, String> paramSession = new HashMap<>();
        paramSession.put("sessionId_sjk", "");
        RetrofitService.addCommonParam(context, paramSession);
        final String sessionService = ServiceListFinal.createSession;
        Observable<ApiResponse> observable = RetrofitService.getInstance().getApiService().postData(sessionService, paramSession);
        observable.subscribeOn(Schedulers.io())
                .observeOn(Schedulers.io())
                .flatMap(new Function<ApiResponse, Observable<ApiResponse>>() {
                    @Override
                    public Observable<ApiResponse> apply(ApiResponse apiResponse) throws Throwable {
                        if (HttpUtility.isOutLog) {
                            LogUtils.data("请求接口：" + sessionService);
                            LogUtils.data("请求数据：" + paramSession.toString());
                            LogUtils.data("返回数据：" + JsonUtils.toJson(apiResponse));
                            LogUtils.data("数据大小：" + apiResponse.toString().length() + " 字节");
                        }
                        if (apiResponse.isSuccess()) {
                            SessionEntity sessionEntity = RetrofitService.objectToEntity(SessionEntity.class, apiResponse.getData());
                            // 设置用户session信息
                            UserShared.setSessionId(context, sessionEntity.getSessionId());
                            UserShared.setChallenge(context, sessionEntity.getChallenge());
                            UserShared.setPubkeyExp(context, sessionEntity.getPub_key_exp());
                            UserShared.setPubkeyModulus(context, sessionEntity.getPub_key_modulus());
                            UserShared.setToken(context, sessionEntity.getUserToken());
                            if (param != null) {
                                param.put("sessionId_sjk", sessionEntity.getSessionId());
                            }
                        }
                        return RetrofitService.getInstance().getApiService().getData(service, param);
                    }
                })
                .observeOn(AndroidSchedulers.mainThread())
                .doOnSubscribe(new Consumer<Disposable>() {
                    @Override
                    public void accept(Disposable disposable) throws Exception {

                    }
                })
                .subscribe(new Observer<ApiResponse>() {

                    @Override
                    public void onSubscribe(@NonNull Disposable d) {

                    }

                    @Override
                    public void onNext(ApiResponse apiResponse) {
                        if (HttpUtility.isOutLog) {
                            LogUtils.data("请求接口：" + service);
                            LogUtils.data("请求数据：" + param.toString());
                            LogUtils.data("返回数据：" + JsonUtils.toJson(apiResponse));
                            LogUtils.data("数据大小：" + apiResponse.toString().length() + " 字节");
                        }
                        Class<?> clz = getInterfaceT(requestListener, 0);
                        LinkedTreeMap<String, String> linkmap_1 = (LinkedTreeMap<String, String>) apiResponse.getData();
                        Gson gson = new GsonBuilder().enableComplexMapKeySerialization().create();
                        String jsonString = gson.toJson(linkmap_1);
                        ApiResponse response = new ApiResponse();
                        response.setCode(apiResponse.getCode());
                        response.setMsg(apiResponse.getMsg());
                        response.setData(rData(clz, jsonString));
                        if (requestListener != null) {
                            requestListener.onSuccess(response);
                        }
                    }

                    @Override
                    public void onError(Throwable e) {
                        if (HttpUtility.isOutLog) {
                            LogUtils.data("请求接口：" + service);
                            LogUtils.data("请求数据：" + param.toString());
                            LogUtils.data("返回数据：" + e.getMessage());
                        }
                        if (requestListener != null) {
                            requestListener.onFailure(e);
                        }
                    }

                    @Override
                    public void onComplete() {
                        sIsCreateSession = false;
                    }
                });
    }

    private static void getDataAgain(Context context, String service, Map<String, String> param, final OnNetRequestListener requestListener, AutoDisposeConverter<ApiResponse> bindAutoDispose) {
        Observable<ApiResponse> observable = getInstance().getApiService().getData(service, param);
        Map<String, String> finalMap = param;
        if (finalMap != null) {
            finalMap.put("sessionId_sjk", UserShared.getSessionId(context));
        }
        observable.subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .doOnSubscribe(new Consumer<Disposable>() {
                    @Override
                    public void accept(Disposable disposable) throws Exception {

                    }
                })
                .to(bindAutoDispose)
                .subscribe(new Observer<ApiResponse>() {
                    @Override
                    public void onSubscribe(@NonNull Disposable d) {

                    }

                    @Override
                    public void onNext(@NonNull ApiResponse apiResponse) {
                        if (HttpUtility.isOutLog) {
                            LogUtils.data("请求接口：" + service);
                            LogUtils.data("请求数据：" + finalMap.toString());
                            LogUtils.data("返回数据：" + JsonUtils.toJson(apiResponse));
                            LogUtils.data("数据大小：" + apiResponse.toString().length() + " 字节");
                        }
                        Class<?> clz = getInterfaceT(requestListener, 0);
                        LinkedTreeMap<String, String> linkmap_1 = (LinkedTreeMap<String, String>) apiResponse.getData();
                        Gson gson = new GsonBuilder().enableComplexMapKeySerialization().create();
                        String jsonString = gson.toJson(linkmap_1);
                        ApiResponse response = new ApiResponse();
                        response.setCode(apiResponse.getCode());
                        response.setMsg(apiResponse.getMsg());
                        response.setData(rData(clz, jsonString));
                        if (requestListener != null) {
                            requestListener.onSuccess(response);
                        }
                    }

                    @Override
                    public void onError(@NonNull Throwable e) {
                        if (HttpUtility.isOutLog) {
                            LogUtils.data("请求接口：" + service);
                            LogUtils.data("请求数据：" + finalMap.toString());
                            LogUtils.data("返回错误：" + e.getMessage());
                        }
                        if (requestListener != null) {
                            requestListener.onFailure(e);
                        }
                    }

                    @Override
                    public void onComplete() {

                    }
                });
    }

    public static class ApiException extends Exception {

        private final int code;
        private String displayMessage;

        public static final int UNKNOWN = 1000;
        public static final int PARSE_ERROR = 1001;

        public ApiException(Throwable throwable, int code) {
            super(throwable);
            this.code = code;
        }

        public int getCode() {
            return code;
        }

        public String getDisplayMessage() {
            return displayMessage;
        }

        public void setDisplayMessage(String msg) {
            this.displayMessage = msg + "(code:" + code + ")";
        }
    }

}
