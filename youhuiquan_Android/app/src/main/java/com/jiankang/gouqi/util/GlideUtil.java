package com.jiankang.gouqi.util;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.drawable.Drawable;
import android.widget.ImageView;

import androidx.annotation.DrawableRes;

import com.bumptech.glide.Glide;
import com.bumptech.glide.load.Transformation;
import com.bumptech.glide.load.engine.DiskCacheStrategy;
import com.bumptech.glide.load.resource.bitmap.BitmapTransformation;
import com.bumptech.glide.module.AppGlideModule;
import com.bumptech.glide.request.RequestOptions;

import com.jiankang.gouqi.R;
import jp.wasabeef.glide.transformations.BlurTransformation;
import jp.wasabeef.glide.transformations.CropSquareTransformation;
import jp.wasabeef.glide.transformations.CropTransformation;
import jp.wasabeef.glide.transformations.GrayscaleTransformation;
import jp.wasabeef.glide.transformations.RoundedCornersTransformation;
import jp.wasabeef.glide.transformations.gpu.BrightnessFilterTransformation;
import jp.wasabeef.glide.transformations.gpu.PixelationFilterTransformation;
import jp.wasabeef.glide.transformations.gpu.SepiaFilterTransformation;
import jp.wasabeef.glide.transformations.gpu.SketchFilterTransformation;

/**
 * 图片加载
 * @author: ljx
 * @createDate: 2020/6/18 16:29
 */
public class GlideUtil extends AppGlideModule {

    /**
     * @param obj       这里obj 只加载 url bitmap  drawable
     * @param imageView 需要加载的图片
     * @describe 加载正常图片
     * @note 这里并没有加载错图，在有错图的时候设置 error()
     */
    public static void loadImage(Object obj, ImageView imageView) {
        if (obj instanceof String) {
            Glide.with(imageView.getContext()).load(obj).apply(initOptions())
                    .skipMemoryCache(isSkipMemoryCache()).error(getErrorImage())
                    .fallback(getErrorImage()).placeholder(getPlaceholder()).into(imageView);
        }
        if (obj instanceof Bitmap) {
            Glide.with(imageView.getContext()).load(obj).apply(initOptions())
                    .skipMemoryCache(isSkipMemoryCache()).error(getErrorImage())
                    .fallback(getErrorImage()).placeholder(getPlaceholder()).into(imageView);
        }
        if (obj instanceof Drawable) {
            Glide.with(imageView.getContext()).load(obj).apply(initOptions())
                    .skipMemoryCache(isSkipMemoryCache()).error(getErrorImage())
                    .fallback(getErrorImage()).placeholder(getPlaceholder()).into(imageView);
        }
    }

    /**
     * @param context   当前Activity的上下文对象
     * @param obj
     * @param imageView
     * @describe 与没有context的方法相比 不易导致 内存泄漏问题，原因 activity销毁的时候 imageView 的上下文对象自然不存在
     */
    public static void loadImage(Context context, Object obj, ImageView imageView) {
        if (obj instanceof String) {
            Glide.with(context).load(obj).apply(initOptions())
                    .error(getErrorImage())
                    .fallback(getErrorImage()).placeholder(getPlaceholder()).into(imageView);
        }
        if (obj instanceof Bitmap) {
            Glide.with(context).load(obj).apply(initOptions())
                    .error(getErrorImage())
                    .fallback(getErrorImage()).placeholder(getPlaceholder()).into(imageView);
        }
        if (obj instanceof Drawable) {
            Glide.with(context).load(obj).apply(initOptions())
                    .error(getErrorImage())
                    .fallback(getErrorImage()).placeholder(getPlaceholder()).into(imageView);
        }
    }

    /**
     * @param context   当前Activity的上下文对象
     * @param obj
     * @param imageView
     * @describe 与没有context的方法相比 不易导致 内存泄漏问题，原因 activity销毁的时候 imageView 的上下文对象自然不存在
     */
    public static void loadImageNoPlaceHolder(Context context, Object obj, ImageView imageView) {
        if (obj instanceof String) {
            Glide.with(context).load(obj).apply(initOptions())
                    .into(imageView);
        }
        if (obj instanceof Bitmap) {
            Glide.with(context).load(obj).apply(initOptions()).into(imageView);
        }
        if (obj instanceof Drawable) {
            Glide.with(context).load(obj).apply(initOptions()).into(imageView);
        }
    }

    /**
     * @param context   当前Activity的上下文对象
     * @param obj
     * @param imageView
     * @describe 与没有context的方法相比 不易导致 内存泄漏问题，原因 activity销毁的时候 imageView 的上下文对象自然不存在
     */
    public static void loadImage(Context context, Object obj, ImageView imageView, int placeholder) {
        if (obj instanceof String) {
            Glide.with(context).load(obj).apply(initOptions())
                    .error(getErrorImage())
                    .fallback(getErrorImage()).placeholder(placeholder).into(imageView);
        }
        if (obj instanceof Bitmap) {
            Glide.with(context).load(obj).apply(initOptions())
                    .error(getErrorImage())
                    .fallback(getErrorImage()).placeholder(placeholder).into(imageView);
        }
        if (obj instanceof Drawable) {
            Glide.with(context).load(obj).apply(initOptions())
                    .error(getErrorImage())
                    .fallback(getErrorImage()).placeholder(placeholder).into(imageView);
        }
    }


    public static void loadImageAd(Context context, Object obj, ImageView imageView) {
        if (obj instanceof String) {
            Glide.with(context).load(obj).apply(initOptionsAd()).error(getErrorImage())
                    .fallback(getErrorImage()).into(imageView);
        }
        if (obj instanceof Bitmap) {
            Glide.with(context).load(obj).apply(initOptionsAd()).error(getErrorImage())
                    .fallback(getErrorImage()).into(imageView);
        }
        if (obj instanceof Drawable) {
            Glide.with(context).load(obj).apply(initOptionsAd()).error(getErrorImage())
                    .fallback(getErrorImage()).into(imageView);
        }
    }

    /**
     * @describe 加载圆形图
     * @param context   当前Activity的上下文对象
     * @param imageView
     */
    public static void loadCircleImage(Context context, String url, ImageView imageView) {
        Glide.with(context).load(url).apply(initOptions())
               .error(getErrorImage()).placeholder(getPlaceholder())
                .fallback(getErrorImage()).circleCrop().into(imageView);



    }
    /**
     * @describe 加载正方形图片
     * @param context   当前Activity的上下文对象
     * @param imageView
     */
    public static void loadSquareImage(Context context, String url, ImageView imageView) {
        Glide.with(context).load(url).apply(initOptions(new CropSquareTransformation()))
                .error(getErrorImage()).placeholder(getPlaceholder())
                .fallback(getErrorImage()).circleCrop().into(imageView);
    }


    /**
     * @describe 加载黑白图片
     * @param context   当前Activity的上下文对象
     * @param imageView
     */
    public static void loadGrayscaleImage(Context context, String url, ImageView imageView) {
        Glide.with(context).load(url).apply(initOptions(new GrayscaleTransformation()))
                .error(getErrorImage()).placeholder(getPlaceholder())
                .fallback(getErrorImage()).circleCrop().into(imageView);
    }

    /**
     * @describe 加载圆角图片  默认所有圆角 带占位图
     * @param context   当前Activity的上下文对象
     * @param imageView
     * @param radius 圆角
     */
    public static void loadScaleImage(Context context, String url, ImageView imageView, int radius, int placeholder) {
        Glide.with(context).load(url).apply(initOptions(new RoundedCornersTransformation(radius,0, RoundedCornersTransformation.CornerType.ALL)))
                .error(placeholder).placeholder(placeholder)
                .fallback(placeholder).into(imageView);
    }

    /**
     * @describe 加载圆角图片  默认所有圆角
     * @param context   当前Activity的上下文对象
     * @param imageView
     * @param radius 圆角
     */
    public static void loadGrayscaleImage(Context context, String url, ImageView imageView, int radius) {
        Glide.with(context).load(url).apply(initOptions(new RoundedCornersTransformation(radius,0, RoundedCornersTransformation.CornerType.ALL)))
                .error(getErrorImage()).placeholder(getPlaceholder())
                .fallback(getErrorImage()).into(imageView);
    }

    /**
     * @describe 加载圆角图片  默认所有圆角
     * @param context   当前Activity的上下文对象
     * @param imageView
     * @param radius 圆角
     * @param margin 间距
     */
    public static void loadGrayscaleImage(Context context, String url, ImageView imageView, int radius, int margin) {
        Glide.with(context).load(url).apply(initOptions(new RoundedCornersTransformation(radius,margin, RoundedCornersTransformation.CornerType.ALL)))
                .error(getErrorImage()).placeholder(getPlaceholder())
                .fallback(getErrorImage()).into(imageView);
    }

    /**
     * @describe 加载圆角图片
     * @param context   当前Activity的上下文对象
     * @param imageView
     * @param radius 圆角
     * @param cornerType 圆角类型
     */
    public static void loadGrayscaleImage(Context context, String url, ImageView imageView, int radius, RoundedCornersTransformation.CornerType cornerType) {
        Glide.with(context).load(url).apply(initOptions(new RoundedCornersTransformation(radius,0,cornerType)))
                .error(getErrorImage()).placeholder(getPlaceholder())
                .fallback(getErrorImage()).circleCrop().into(imageView);
    }

    /**
     * @describe 加载圆角图片  默认所有圆角， 但默认没有背景
     * @param context   当前Activity的上下文对象
     * @param imageView
     * @param radius 圆角
     */
    public static void loadGrayscaleImage(Context context, String url, ImageView imageView, int radius, boolean isPlaceHolder) {
        if (isPlaceHolder) {
            Glide.with(context).load(url).apply(initOptions(new RoundedCornersTransformation(radius, 0, RoundedCornersTransformation.CornerType.ALL)))
                    .error(getErrorImageGray())
                    .fallback(getErrorImage()).into(imageView);
        } else {
            Glide.with(context).load(url).apply(initOptions(new RoundedCornersTransformation(radius, 5, RoundedCornersTransformation.CornerType.ALL)))
                    .error(getErrorImageGray())
                    .into(imageView);
        }
    }

    /**
     * @describe 自定义裁剪
     * @param context   当前Activity的上下文对象
     * @param imageView
     * @param width,height 圆角宽高
     * @param cropType 裁剪位置
     */
    public static void loadCropTransformationImage(Context context, String url, ImageView imageView, int width, int height, CropTransformation.CropType cropType) {
        Glide.with(context).load(url).apply(initOptions(new CropTransformation(width,height,cropType)))
                .error(getErrorImage()).placeholder(getPlaceholder())
                .fallback(getErrorImage()).circleCrop().into(imageView);
    }
    /**
     * @describe 自定义裁剪 默认居中裁剪
     * @param context   当前Activity的上下文对象
     * @param imageView
     * @param width,height 圆角宽高
     */
    public static void loadCropTransformationImage(Context context, String url, ImageView imageView, int width, int height) {
        Glide.with(context).load(url).apply(initOptions(new CropTransformation(width,height, CropTransformation.CropType.CENTER)))
                .error(getErrorImage()).placeholder(getPlaceholder())
                .fallback(getErrorImage()).circleCrop().into(imageView);
    }

    /**
     * @describe 加载动图gif
     * @param context
     * @param url
     * @param imageView
     */
    public static void loadGifImage(Context context, String url, ImageView imageView){
        Glide.with(context).asGif().apply(initOptions())
                .load(url).error(getErrorImage()).placeholder(getPlaceholder())
                .fallback(getErrorImage()).circleCrop().into(imageView);
    }
    /**
     * @describe 加载动图gif
     * @param url
     * @param imageView
     */
    public static void loadGifImage(String url, ImageView imageView){
        Glide.with(imageView.getContext()).asGif().apply(initOptions())
                .load(url).error(getErrorImage())
                .placeholder(getPlaceholder()).fallback(getErrorImage()).circleCrop().into(imageView);
    }

    /**
     * @describe 加载高斯模糊大图
     * @param ambiguity 模糊度  eg ：80
     */
    public static void loadTransformImage(String url, ImageView imageView, int ambiguity){
        Glide.with(imageView.getContext()).load(url).skipMemoryCache(isSkipMemoryCache())
                .fallback(getErrorImage()).placeholder(getPlaceholder()).error(getErrorImage())
                .apply(initOptions(new BlurTransformation(ambiguity)))
                .into(imageView);
    }
    /**
     * @describe 加载缩略图
     * @param sizeMultiplier 如设置0.2f缩略
     */
    public static void loadThumbnailImage(String url, ImageView imageView, float sizeMultiplier){
        Glide.with(imageView.getContext()).load(url)
                .skipMemoryCache(isSkipMemoryCache())
                .thumbnail(sizeMultiplier)//缩略的参数
                .apply(initOptions())
                .into(imageView);
    }

    /**
     * @describe 设置滤镜 （陈旧）
     * @param context   当前Activity的上下文对象
     * @param imageView
     */
    public static void loadSepiaFilterTransformationImage(Context context, String url, ImageView imageView) {
        Glide.with(context).load(url).apply(initOptions(new SepiaFilterTransformation(1.0f)))
                .error(getErrorImage()).placeholder(getPlaceholder())
                .fallback(getErrorImage()).circleCrop().into(imageView);
    }
    /**
     * @describe 设置滤镜 （亮度）
     * @param context   当前Activity的上下文对象
     * @param imageView
     */
    public static void loadBrightnessFilterTransformationImage(Context context, String url, ImageView imageView) {
        Glide.with(context).load(url).apply(initOptions(new BrightnessFilterTransformation(0.5f)))
                .error(getErrorImage()).placeholder(getPlaceholder())
                .fallback(getErrorImage()).circleCrop().into(imageView);
    }
    /**
     * @describe 设置滤镜 （马赛克）
     * @param context   当前Activity的上下文对象
     * @param imageView
     */
    public static void loadPixelationFilterTransformationImage(Context context, String url, ImageView imageView) {
        Glide.with(context).load(url).apply(initOptions(new PixelationFilterTransformation(20f)))
                .error(getErrorImage()).placeholder(getPlaceholder())
                .fallback(getErrorImage()).circleCrop().into(imageView);
    }

    /**
     * @describe 设置滤镜 （素描画）
     * @param context   当前Activity的上下文对象
     * @param imageView
     */
    public static void loadSketchFilterTransformationImage(Context context, String url, ImageView imageView) {
        Glide.with(context).load(url).apply(initOptions(new SketchFilterTransformation()))
                .error(getErrorImage()).placeholder(getPlaceholder())
                .fallback(getErrorImage()).circleCrop().into(imageView);
    }
    /**
     * @return  设置全局的错误图片 防止更改时多地方修改
     * @describe 当图片加载失败的时候显示
     */
    private static @DrawableRes int getErrorImage(){
        return R.drawable.image_default;
    }

    /**
     * @return  设置全局的错误图片 防止更改时多地方修改
     * @describe 当图片加载失败的时候显示
     */
    private static @DrawableRes int getErrorImageGray(){
        return R.drawable.image_default;
    }

    /**
     * @return 设置全局的占位图 防止更改时多地方修改
     * @describe 当图片没有加载出来的时候显示
     */
    private static @DrawableRes
    int getPlaceholder(){
        return R.drawable.image_default;
    }



    /**
     * @return 返回当前石头 跳过内存缓存
     * true 不缓存 false 缓存
     */
    private static boolean isSkipMemoryCache(){
        return false;
    }


    /**
     * @describe 设置缓存
     *      Glide有两种缓存机制，一个是内存缓存，一个是硬盘缓存。
     *      内存缓存的主要作用是防止应用重复将图片数据读取到内存当中，
     *      而硬盘缓存的主要作用是防止应用重复从网络或其他地方重复下载和读取数据
     * @diskCacheStrategy参数
     *         DiskCacheStrategy.NONE： 表示不缓存任何内容
     *         DiskCacheStrategy.DATA： 表示只缓存原始图片
     *         DiskCacheStrategy.RESOURCE： 表示只缓存转换过后的图片
     *         DiskCacheStrategy.ALL ： 表示既缓存原始图片，也缓存转换过后的图片
     *         DiskCacheStrategy.AUTOMATIC： 表示让Glide根据图片资源智能地选择使用哪一种缓存策略（默认选项）
     * @return 这里默认设置全部为禁止缓存
     */
    private static RequestOptions initOptions(Transformation<Bitmap> transformation){
        return new RequestOptions()
                .transform(transformation)
                //是否允许内存缓存
                .skipMemoryCache(isSkipMemoryCache())
                //是否只从缓存加载图片
                .onlyRetrieveFromCache(false)
                //禁止磁盘缓存
                .diskCacheStrategy(DiskCacheStrategy.NONE);
    }
    private static RequestOptions initOptions(){
        return new RequestOptions()
                //是否允许内存缓存
                .skipMemoryCache(isSkipMemoryCache())
                //是否只从缓存加载图片
                .onlyRetrieveFromCache(false)
                //禁止磁盘缓存
                .diskCacheStrategy(DiskCacheStrategy.NONE);
    }
    private static RequestOptions initOptionsAd(){
        return new RequestOptions()
                //是否允许内存缓存
                .skipMemoryCache(isSkipMemoryCache())
                //是否只从缓存加载图片
                .onlyRetrieveFromCache(false)
                //表示只缓存转换过后的图片
                .diskCacheStrategy(DiskCacheStrategy.RESOURCE);
    }
    /**
     * @describe 清楚内容缓存
     */
    public static void clearMemory(Context context){
        Glide.get(context).clearMemory();
    }
    /**
     * @describe 清除磁盘缓存
     */
    public static void clearDiskCache(Context context){
        Glide.get(context).clearDiskCache();
    }

    /**
     * @describe 设置加载的效果
     * @param transformation
     * @return
     */
    private static RequestOptions bitmapTransform(BitmapTransformation transformation){
        return new RequestOptions();
    }

}
