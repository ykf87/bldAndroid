package com.blandal.app.util;

import android.Manifest;
import android.content.Context;
import android.content.Intent;
import android.database.Cursor;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.Matrix;
import android.net.Uri;
import android.os.Environment;
import android.provider.MediaStore;
import android.view.View;


import androidx.lifecycle.Lifecycle;
import androidx.lifecycle.LifecycleOwner;

import com.yanzhenjie.permission.Action;
import com.yanzhenjie.permission.AndPermission;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.List;

import autodispose2.AutoDispose;
import autodispose2.AutoDisposeConverter;
import autodispose2.androidx.lifecycle.AndroidLifecycleScopeProvider;
import com.blandal.app.common.MyHandler;
import com.blandal.app.dialog.ProgressDialogShow;
import com.blandal.app.entity.FileUploadEntity;
import com.blandal.app.service.ApiResponse;
import com.blandal.app.service.OnNetRequestListener;
import com.blandal.app.service.RetrofitService;


public class ImageUtils {

    BitmapListener listener;


    //保存图片到相册
    public static void saveImageToGallery(Context context, Bitmap bmp) {
        try {
            String fileName = "zhaitask" + System.currentTimeMillis() + ".jpg";
            File file = new File(fileName);
            //把文件插入到系统图库
            String insertImage = MediaStore.Images.Media.insertImage(context.getContentResolver(), bmp, fileName, null);
            //保存图片后发送广播通知更新数据库
            Uri uri = Uri.fromFile(new File(getRealPathFromURI(Uri.parse(insertImage), context)));
            context.sendBroadcast(new Intent(Intent.ACTION_MEDIA_SCANNER_SCAN_FILE, uri));
            ToastShow.showMsg(context, "保存成功");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //保存图片到相册 获取图片地址
    public static String getImgPath(Context context, Bitmap bmp) {
        try {
            String fileName = "zhaiPoster" + ".jpg";
            File file = new File(fileName);
            //把文件插入到系统图库
            String insertImage = MediaStore.Images.Media.insertImage(context.getContentResolver(), bmp, fileName, null);
            //保存图片后发送广播通知更新数据库
            Uri uri = Uri.fromFile(new File(getRealPathFromURI(Uri.parse(insertImage), context)));
            context.sendBroadcast(new Intent(Intent.ACTION_MEDIA_SCANNER_SCAN_FILE, uri));
            return new File(getRealPathFromURI(Uri.parse(insertImage), context)).getPath();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static File saveBitmap(Bitmap bm) {
        File file;
        isHaveSDCard();
        if (isHaveSDCard()) {
            file = Environment.getExternalStorageDirectory();
        } else {
            file = Environment.getDataDirectory();
        }
        file = new File(file.getPath() + "/MotieReader/data/");
        if (!file.isDirectory()) {
            file.delete();
            file.mkdirs();
        }
        if (!file.exists()) {
            file.mkdirs();
        }
        return writeBitmap(file.getPath(), "poster.png", bm);

    }

    public static File writeBitmap(String path, String name, Bitmap bitmap) {
        File file = new File(path);
        if (!file.exists()) {
            file.mkdirs();
        }

        File _file = new File(path + "/" + name);
        if (_file.exists()) {
            _file.delete();
        }
        FileOutputStream fos = null;
        try {
            fos = new FileOutputStream(_file);
            if (name != null && !"".equals(name)) {
                int index = name.lastIndexOf(".");
                if (index != -1 && (index + 1) < name.length()) {
                    String extension = name.substring(index + 1).toLowerCase();
                    if ("png".equals(extension)) {
                        bitmap.compress(Bitmap.CompressFormat.PNG, 100, fos);
                    } else if ("jpg".equals(extension)
                            || "jpeg".equals(extension)) {
                        bitmap.compress(Bitmap.CompressFormat.JPEG, 75, fos);
                    }
                }
            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } finally {
            if (fos != null) {
                try {
                    fos.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return _file;
    }

    public static boolean isHaveSDCard() {
        String SDState = android.os.Environment.getExternalStorageState();
        if (SDState.equals(android.os.Environment.MEDIA_MOUNTED)) {
            return true;
        }
        return false;
    }

    //得到绝对地址
    private static String getRealPathFromURI(Uri contentUri, Context context) {
        String[] proj = {MediaStore.Images.Media.DATA};
        Cursor cursor = context.getContentResolver().query(contentUri, proj, null, null, null);
        int column_index = cursor.getColumnIndexOrThrow(MediaStore.Images.Media.DATA);
        cursor.moveToFirst();
        String fileStr = cursor.getString(column_index);
        cursor.close();
        return fileStr;
    }

    /**
     * 将URL转化成bitmap形式
     */
    private static Bitmap bitmap;

    public static void getBitmap(final String headUrl, BitmapListener bitmapListener) {
        new Thread(new Runnable() {
            @Override
            public void run() {
                URL imageurl = null;
                try {
                    imageurl = new URL(headUrl);
                } catch (MalformedURLException e) {
                    e.printStackTrace();
                }
                try {
                    if (imageurl != null) {
                        HttpURLConnection conn = (HttpURLConnection) imageurl.openConnection();
                        conn.setDoInput(true);
                        conn.connect();
                        InputStream is = conn.getInputStream();
                        bitmap = BitmapFactory.decodeStream(is);
                        bitmap = Bitmap.createBitmap(bitmap, 0, 0, bitmap.getWidth(), bitmap.getHeight());
                        bitmap = big(bitmap, 500, 500);
                        bitmapListener.getBitmap(bitmap);
                        is.close();
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }).start();
    }

    //把传进来的bitmap对象转换为宽度为x,长度为y的bitmap对象
    public static Bitmap big(Bitmap b, float x, float y) {
        int w = b.getWidth();
        int h = b.getHeight();
        float sx = (float) x / w;
        float sy = (float) y / h;
        Matrix matrix = new Matrix();
        //也可以按两者之间最大的比例来设置放大比例，这样不会是图片压缩
//        float bigerS = Math.max(sx,sy);
//        matrix.postScale(bigerS,bigerS);
        matrix.postScale(sx, sy); // 长和宽放大缩小的比例
        Bitmap resizeBmp = Bitmap.createBitmap(b, 0, 0, w,
                h, matrix, true);
        return resizeBmp;
    }

    public void setBitmap(BitmapListener listener) {
        this.listener = listener;
    }

    public interface BitmapListener {
        void getBitmap(Bitmap bitmap);
    }

    /**
     * 获取View截屏
     *
     * @return
     */
    public static Bitmap getPosterBitmap(View view) {
        Bitmap bitmap = Bitmap.createBitmap(view.getWidth(), view.getHeight(), Bitmap.Config.ARGB_8888);
        Canvas canvas = new Canvas();
        canvas.setBitmap(bitmap);
        view.draw(canvas);
        return bitmap;
    }

    /**
     * 获取View截屏 并保存
     *
     * @param v
     */
    public static void saveScreenImage(Context context, View v) {
        try {
            Bitmap bitmap = Bitmap.createBitmap(v.getWidth(), v.getHeight(), Bitmap.Config.ARGB_8888);
            Canvas canvas = new Canvas();
            canvas.setBitmap(bitmap);
            v.draw(canvas);
            AndPermission.with(context)
                    .runtime()
                    .permission(new String[]{Manifest.permission.WRITE_EXTERNAL_STORAGE})
                    .onGranted(new Action<List<String>>() {
                        @Override
                        public void onAction(List<String> strings) {
                            ImageUtils.saveImageToGallery(context, bitmap);
                        }
                    })
                    .onDenied(new Action<List<String>>() {
                        @Override
                        public void onAction(List<String> strings) {
                            ToastShow.showMsg("请设置存储权限");
                        }
                    }).start();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void upLoadImage(Context context, String images, ImageCallbcack callbcack) {
        ProgressDialogShow.showLoadDialog(context, "请求中...", new MyHandler());
        RetrofitService.getInstance().uploadImg(images, new OnNetRequestListener<ApiResponse<FileUploadEntity>>() {
            @Override
            public void onSuccess(ApiResponse<FileUploadEntity> response) {
                ProgressDialogShow.dismissDialog(new MyHandler());
                if (response.isSuccess()) {
                    callbcack.getImgUrl(response.getData().fileUrl);
                } else {
                    ToastShow.showMsg(response.getMsg());
                }
            }

            @Override
            public void onFailure(Throwable t) {
                ProgressDialogShow.dismissDialog(new MyHandler());
            }
        }, bindAutoDispose(context));
    }

    public static <T> AutoDisposeConverter<T> bindAutoDispose(Context context) {
        return AutoDispose.autoDisposable(AndroidLifecycleScopeProvider
                .from((LifecycleOwner) context, Lifecycle.Event.ON_DESTROY));
    }

    public interface ImageCallbcack {
        void getImgUrl(String url);
    }
}
