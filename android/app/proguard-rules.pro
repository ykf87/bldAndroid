
# 代码混淆压缩比，在0~7之间，默认为5，一般不做修改

# 代码混淆压缩比，在0~7之间，默认为5，一般不做修改

-optimizationpasses 5

# 混合时不使用大小写混合，混合后的类名为小写

-dontusemixedcaseclassnames

# 指定不去忽略非公共库的类

-dontskipnonpubliclibraryclasses

# 指定不去忽略非公共库的类成员

-dontskipnonpubliclibraryclassmembers

# 这句话能够使我们的项目混淆后产生映射文件

# 包含有类名->混淆后类名的映射关系

-verbose

# 不做预校验，preverify是proguard的四个步骤之一，Android不需要preverify，去掉这一步能够加快混淆速度。

-dontpreverify

# 保留Annotation不混淆 这在JSON实体映射时非常重要，比如fastJson

-keepattributes *Annotation*,InnerClasses

# 避免混淆泛型

-keepattributes Signature#范型

# 抛出异常时保留代码行号

-keepattributes SourceFile,LineNumberTable

# 设置是否允许改变作用域

-allowaccessmodification

# 把混淆类中的方法名也混淆了

-useuniqueclassmembernames

# apk 包内所有 class 的内部结构

-dump class_files.txt

# 未混淆的类和成员

-printseeds seeds_txt

# 列出从apk中删除的代码

-printusage unused.txt

# 混淆前后的映射

-printmapping mapping.txt

# 指定混淆是采用的算法，后面的参数是一个过滤器

# 这个过滤器是谷歌推荐的算法，一般不做更改

-optimizations !code/simplification/cast,!field/*,!class/merging/*

# 忽略警告

-ignorewarnings

-keepattributes *Annotation*

-keepclassmembers enum * {

public static **[] values();

public static ** valueOf(java.lang.String);

}




-keep public class * extends android.app.Activity

-keep public class * extends android.app.Application

-keep public class * extends android.app.Service

-keep public class * extends android.content.BroadcastReceiver

-keep public class * extends android.content.ContentProvider

-keep public class * extends android.app.backup.BackupAgent

-keep public class * extends android.preference.Preference

-keep public class * extends android.support.v4.app.Fragment

-keep public class * extends android.app.Fragment

-keep public class * extends android.view.View

-keep public class com.android.vending.licensing.ILicensingService

-keep public class android.arch.lifecycle.**{*;}

-keep public class android.arch.lifecycle.**{*;}

-keep public class android.arch.lifecycle.**{*;}

-keep public class android.arch.lifecycle.**{*;}

-keep public class android.arch.core.internal.**{*;}

-keep class android.support.**{*;}

-keep interface android.support.**{*;}

-keep public class android.support.**{*;}

-keep public interface android.support.**{*;}

#v4包不混淆
-keep class android.support.v4.app.** { *; }

-keep interface android.support.v4.app.** { *; }


#闪验
-dontwarn com.cmic.sso.sdk.**
-dontwarn com.unicom.xiaowo.account.shield.**
-dontwarn com.sdk.**
-keep class com.cmic.sso.sdk.**{*;}
-keep class com.sdk.** { *;}
-keep class com.unicom.xiaowo.account.shield.** {*;}
-keep class cn.com.chinatelecom.account.api.**{*;}

#XPopup
-dontwarn com.lxj.xpopup.widget.**
-keep class com.lxj.xpopup.widget.**{*;}

#友盟统计
-keep class com.umeng.** {*;}

-keepclassmembers class * {
   public <init> (org.json.JSONObject);
}

-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

-keep public class com.zhairenwu.R$*{
public static final int *;
}

#极光推送
-dontoptimize
-dontpreverify

-dontwarn cn.jpush.**
-keep class cn.jpush.** { *; }
-keep class * extends cn.jpush.android.helpers.JPushMessageReceiver { *; }

-dontwarn cn.jiguang.**
-keep class cn.jiguang.** { *; }

#极光推送-vivo
-dontwarn com.vivo.push.**
-keep class com.vivo.push.**{*; }
-keep class com.vivo.vms.**{*; }

# 友盟分享
-dontshrink
-dontoptimize
-dontwarn com.google.android.maps.**
-dontwarn com.squareup.okhttp.**
-dontwarn android.webkit.WebView
-dontwarn com.umeng.**
-dontwarn com.tencent.weibo.sdk.**
-dontwarn com.facebook.**
-keep public class javax.**
-keep public class android.webkit.**
-dontwarn android.support.v4.**
-keep enum com.facebook.**
-keepattributes Exceptions,InnerClasses,Signature
-keepattributes *Annotation*
-keepattributes SourceFile,LineNumberTable
-keepattributes EnclosingMethod
-keep public interface com.facebook.**
-keep public interface com.tencent.**
-keep public interface com.umeng.socialize.**
-keep public interface com.umeng.socialize.sensor.**
-keep public interface com.umeng.scrshot.**

-keep public class com.umeng.socialize.* {*;}

-keep class com.umeng.commonsdk.statistics.common.MLog {*;}
-keep class com.umeng.commonsdk.UMConfigure {*;}
-keep class com.umeng.**
-keep class com.facebook.**
-keep class com.facebook.** { *; }
-keep class com.umeng.scrshot.**
-keep public class com.tencent.** {*;}
-keep class com.umeng.socialize.sensor.**
-keep class com.umeng.socialize.handler.**
-keep class com.umeng.socialize.handler.*
-keep class com.umeng.weixin.handler.**
-keep class com.umeng.weixin.handler.*
-keep class com.umeng.qq.handler.**
-keep class com.umeng.qq.handler.*
-keep class UMMoreHandler{*;}
-keep class com.tencent.mm.sdk.modelmsg.WXMediaMessage {*;}
-keep class com.tencent.mm.sdk.modelmsg.** implements com.tencent.mm.sdk.modelmsg.WXMediaMessage$IMediaObject {*;}
-keep class im.yixin.sdk.api.YXMessage {*;}
-keep class im.yixin.sdk.api.** implements im.yixin.sdk.api.YXMessage$YXMessageData{*;}
-keep class com.tencent.mm.sdk.** {
   *;
}
-keep class com.tencent.mm.opensdk.** {
   *;
}
-keep class com.tencent.wxop.** {
   *;
}
-keep class com.tencent.mm.sdk.** {
   *;
}
-dontwarn twitter4j.**
-keep class twitter4j.** { *; }

-keep class com.tencent.** {*;}
-dontwarn com.tencent.**
-keep class com.kakao.** {*;}
-dontwarn com.kakao.**
-keep public class com.umeng.com.umeng.soexample.R$*{
    public static final int *;
}
-keep public class com.linkedin.android.mobilesdk.R$*{
    public static final int *;
}

-keep class com.tencent.open.TDialog$*
-keep class com.tencent.open.TDialog$* {*;}
-keep class com.tencent.open.PKDialog
-keep class com.tencent.open.PKDialog {*;}
-keep class com.tencent.open.PKDialog$*
-keep class com.tencent.open.PKDialog$* {*;}
-keep class com.umeng.socialize.impl.ImageImpl {*;}
-keep class com.sina.** {*;}
-dontwarn com.sina.**
-keep class  com.alipay.share.sdk.** {
   *;
}

-keepnames class * implements android.os.Parcelable {
    public static final ** CREATOR;
}

-keep class com.linkedin.** { *; }
-keep class com.android.dingtalk.share.ddsharemodule.** { *; }
-keepattributes Signature