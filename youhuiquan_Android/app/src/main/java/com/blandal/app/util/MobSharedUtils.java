package com.blandal.app.util;


/**
 * @author: ljx
 * @createDate: 2020/12/7  16:07
 */
public class MobSharedUtils {

    public static void shareQQZone(String title, String content, String iconUrl, String url, int sharedType, String imgUrl) {
//        Platform qqPlatform = ShareSDK.getPlatform(QQ.NAME);
//        if (!qqPlatform.isClientValid()) {
//            ToastShow.showMsg(MyApplication.getContext(), "该手机未安装QQ", new MyHandler());
//            return;
//        }
//        Platform.ShareParams sp = new Platform.ShareParams();
//        if (sharedType == SHARE_WEBPAGE) {
//            sp.setTitle(title);
//            sp.setText(content);
//            sp.setTitleUrl(url);
//            sp.setImageUrl(iconUrl);
//        } else if (sharedType == SHARE_IMAGE) {
//            sp.setImageUrl(imgUrl);
//        }
//        sp.setShareType(sharedType);
//        Log.d("ShareSDK", sp.toMap().toString());
//        Platform qZone = ShareSDK.getPlatform(QZone.NAME);
//        // 设置分享事件回调（注：回调放在不能保证在主线程调用，不可以在里面直接处理UI操作）
//        qZone.setPlatformActionListener(new PlatformActionListener() {
//            @Override
//            public void onComplete(Platform platform, int i, HashMap<String, Object> hashMap) {
//                Log.d("ShareSDK", "onComplete ---->  分享成功");
//                ToastShow.showMsg(MyApplication.getContext(), "分享成功", new MyHandler());
//            }
//
//            @Override
//            public void onError(Platform platform, int i, Throwable throwable) {
//                Log.d("ShareSDK", "onError ---->  分享失败" + throwable.getStackTrace().toString());
//                Log.d("ShareSDK", "onError ---->  分享失败" + throwable.getMessage());
//            }
//
//            @Override
//            public void onCancel(Platform platform, int i) {
//                Log.d("ShareSDK", "onCancel ---->  分享取消");
//            }
//        });
//        // 执行图文分享
//        qZone.share(sp);
    }

    public static void sharedQQ(String title, String content, String iconUrl, String url, int sharedType, String imgUrl) {
//        Platform qqPlatform = ShareSDK.getPlatform(QQ.NAME);
//        if (!qqPlatform.isClientValid()) {
//            ToastShow.showMsg(MyApplication.getContext(), "该手机未安装QQ", new MyHandler());
//            return;
//        }
//        QQ.ShareParams sp = new QQ.ShareParams();
//        if (sharedType == SHARE_WEBPAGE) {
//            sp.setTitle(title);
//            sp.setText(content);
//            sp.setTitleUrl(url);
//            sp.setImageUrl(iconUrl);
//        } else if (sharedType == SHARE_IMAGE) {
//            sp.setImageUrl(imgUrl);
//        }
//        sp.setShareType(sharedType);
//        Log.d("ShareSDK", sp.toMap().toString());
//        Platform qq = ShareSDK.getPlatform(QQ.NAME);
//        // 设置分享事件回调（注：回调放在不能保证在主线程调用，不可以在里面直接处理UI操作）
//        qq.setPlatformActionListener(new PlatformActionListener() {
//            @Override
//            public void onComplete(Platform platform, int i, HashMap<String, Object> hashMap) {
//                Log.d("ShareSDK", "onComplete ---->  分享成功");
//                ToastShow.showMsg(MyApplication.getContext(), "分享成功", new MyHandler());
//            }
//
//            @Override
//            public void onError(Platform platform, int i, Throwable throwable) {
//                Log.d("ShareSDK", "onError ---->  分享失败" + throwable.getStackTrace().toString());
//                Log.d("ShareSDK", "onError ---->  分享失败" + throwable.getMessage());
//            }
//
//            @Override
//            public void onCancel(Platform platform, int i) {
//                Log.d("ShareSDK", "onCancel ---->  分享取消");
//            }
//        });
//        // 执行图文分享
//        qq.share(sp);
    }

    //朋友圈
    public static void sharedWechatMoments(String title, String content, String iconUrl, String url, int sharedType, String imgUrl) {
//        Platform weixin = ShareSDK.getPlatform(Wechat.NAME);
//        if (!weixin.isClientValid()) {
//            ToastShow.showMsg(MyApplication.getContext(), "该手机未安装微信", new MyHandler());
//            return;
//        }
//        Platform.ShareParams sp = new Platform.ShareParams();
//        if (sharedType == SHARE_WEBPAGE) {
//            sp.setTitle(title);
//            sp.setText(content);
//            sp.setTitleUrl(url);
//            sp.setImageUrl(iconUrl);
//            sp.setUrl(url);
//        } else if (sharedType == SHARE_IMAGE) {
//            sp.setImageUrl(imgUrl);
//        }
//        sp.setShareType(sharedType);
//        Log.d("ShareSDK", sp.toMap().toString());
//        Platform wechat = ShareSDK.getPlatform(WechatMoments.NAME);
//        // 设置分享事件回调（注：回调放在不能保证在主线程调用，不可以在里面直接处理UI操作）
//        wechat.setPlatformActionListener(new PlatformActionListener() {
//            @Override
//            public void onComplete(Platform platform, int i, HashMap<String, Object> hashMap) {
//                Log.d("ShareSDK", "onComplete ---->  分享成功");
//                ToastShow.showMsg(MyApplication.getContext(), "分享成功", new MyHandler());
//            }
//
//            @Override
//            public void onError(Platform platform, int i, Throwable throwable) {
//                Log.d("ShareSDK", "onError ---->  分享失败" + throwable.getStackTrace().toString());
//                Log.d("ShareSDK", "onError ---->  分享失败" + throwable.getMessage());
//            }
//
//            @Override
//            public void onCancel(Platform platform, int i) {
//                Log.d("ShareSDK", "onCancel ---->  分享取消");
//            }
//        });
//        // 执行图文分享
//        wechat.share(sp);
    }

    public static void sharedWX(String title, String content, String iconUrl, String url, int sharedType, String imgUrl) {
//        Platform weixin = ShareSDK.getPlatform(Wechat.NAME);
//        if (!weixin.isClientValid()) {
//            ToastShow.showMsg(MyApplication.getContext(), "该手机未安装微信", new MyHandler());
//            return;
//        }
//
//        Wechat.ShareParams sp = new Wechat.ShareParams();
//        if (sharedType == SHARE_WEBPAGE) {
//            sp.setTitle(title);
//            sp.setText(content);
//            sp.setTitleUrl(url);
//            sp.setImageUrl(iconUrl);
//            sp.setUrl(url);
//        } else if (sharedType == SHARE_IMAGE) {
//            sp.setImageUrl(imgUrl);
//        }
//        sp.setShareType(sharedType);
//        Log.d("ShareSDK", sp.toMap().toString());
//        Platform wechat = ShareSDK.getPlatform(Wechat.NAME);
//        // 设置分享事件回调（注：回调放在不能保证在主线程调用，不可以在里面直接处理UI操作）
//        wechat.setPlatformActionListener(new PlatformActionListener() {
//            @Override
//            public void onComplete(Platform platform, int i, HashMap<String, Object> hashMap) {
//                Log.d("ShareSDK", "onComplete ---->  分享成功");
//                ToastShow.showMsg(MyApplication.getContext(), "分享成功", new MyHandler());
//            }
//
//            @Override
//            public void onError(Platform platform, int i, Throwable throwable) {
//                Log.d("ShareSDK", "onError ---->  分享失败" + throwable.getStackTrace().toString());
//                Log.d("ShareSDK", "onError ---->  分享失败" + throwable.getMessage());
//            }
//
//            @Override
//            public void onCancel(Platform platform, int i) {
//                Log.d("ShareSDK", "onCancel ---->  分享取消");
//            }
//        });
//        // 执行图文分享
//        wechat.share(sp);
    }
}
