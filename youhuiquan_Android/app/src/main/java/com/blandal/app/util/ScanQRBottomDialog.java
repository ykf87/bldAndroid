package com.blandal.app.util;

import android.content.Context;
import android.graphics.Bitmap;
import android.text.TextUtils;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.lifecycle.Lifecycle;
import androidx.lifecycle.LifecycleOwner;

import com.google.android.material.bottomsheet.BottomSheetDialog;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.BinaryBitmap;
import com.google.zxing.ChecksumException;
import com.google.zxing.FormatException;
import com.google.zxing.NotFoundException;
import com.google.zxing.RGBLuminanceSource;
import com.google.zxing.Result;
import com.google.zxing.ResultPoint;
import com.google.zxing.common.HybridBinarizer;
import com.google.zxing.qrcode.QRCodeReader;

import java.util.ArrayList;
import java.util.List;

import autodispose2.AutoDispose;
import autodispose2.AutoDisposeConverter;
import autodispose2.androidx.lifecycle.AndroidLifecycleScopeProvider;
import com.blandal.app.R;
import com.blandal.app.util.lifephotosbrowse.LifePhotoEntity;
import com.blandal.app.util.lifephotosbrowse.LifePhotosBrowseActivity;
import io.reactivex.rxjava3.android.schedulers.AndroidSchedulers;
import io.reactivex.rxjava3.core.Observable;
import io.reactivex.rxjava3.core.ObservableSource;
import io.reactivex.rxjava3.functions.Consumer;
import io.reactivex.rxjava3.functions.Function;
import io.reactivex.rxjava3.schedulers.Schedulers;

/**
 * Description:扫描二维码 底部弹窗
 * author:ljx
 * time  :2020/12/16 09 55
 */
public class ScanQRBottomDialog extends BottomSheetDialog {


    private TextView tvScanQr;
    private TextView tvBrowsePhoto;
    private TextView tvCancel;

    public ScanQRBottomDialog(@NonNull Context context, String imgUrl) {
        super(context, R.style.BottomSheetDialog);
        View view = LayoutInflater.from(context).inflate(
                R.layout.dialog_scanqr_dialog, null);
        setContentView(view);
        tvScanQr = view.findViewById(R.id.tv_scan_qr);
        tvBrowsePhoto = view.findViewById(R.id.tv_browse_photo);
        tvCancel = view.findViewById(R.id.tv_cancel);

        tvScanQr.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (tvScanQr.getTag() instanceof String) {
                    String qrUrl = (String) tvScanQr.getTag();
                    DisplayUtil.openUrlByApp(context, qrUrl, false);
                }
                dismiss();
            }
        });

        tvBrowsePhoto.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                List<LifePhotoEntity> lifePhotoList = new ArrayList<>();
                lifePhotoList.add(new LifePhotoEntity(0, imgUrl));
                int index = 0;
                for (int i = 0; i < lifePhotoList.size(); i++) {
                    if (TextUtils.equals(imgUrl, lifePhotoList.get(i).getLife_photo())) {
                        index = i;
                        break;
                    }
                }
                LifePhotosBrowseActivity.launch(context, lifePhotoList, index);
                dismiss();
            }
        });
        tvCancel.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dismiss();
            }
        });

    }

    public void showDialog(Context context, Bitmap obmp) {
        int width = obmp.getWidth();
        int height = obmp.getHeight();
        int[] data = new int[width * height];
        obmp.getPixels(data, 0, width, 0, 0, width, height);
        RGBLuminanceSource source = new RGBLuminanceSource(width, height, data);
        BinaryBitmap bitmap = new BinaryBitmap(new HybridBinarizer(source));

        LifecycleOwner lifecycleOwner = null;
        if (context instanceof LifecycleOwner) {
            lifecycleOwner = (LifecycleOwner) context;
        }
        if (lifecycleOwner == null) {
            tvScanQr.setVisibility(View.GONE);
            show();
            return;
        }
        Observable.just(bitmap).flatMap(new Function<BinaryBitmap, ObservableSource<Result>>() {
            @Override
            public ObservableSource<Result> apply(BinaryBitmap bitmap) throws Throwable {
                QRCodeReader reader = new QRCodeReader();
                Result result = null;
                try {
                    result = reader.decode(bitmap);
                } catch (NotFoundException e) {
                    e.printStackTrace();
                } catch (ChecksumException e) {
                    e.printStackTrace();
                } catch (FormatException e) {
                    e.printStackTrace();
                }
                if (result == null) {
                    result = new Result("", new byte[]{}, new ResultPoint[]{}, BarcodeFormat.QR_CODE);
                }
                return Observable.just(result);
            }
        }).subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .to(bindAutoDispose(lifecycleOwner))
                .subscribe(new Consumer<Result>() {
                    @Override
                    public void accept(Result result) throws Throwable {
                        String url = result.getText();
                        if (!TextUtils.isEmpty(url)) {
                            if (url.toLowerCase().startsWith("http")) {
                                tvScanQr.setTag(url);
                            } else {
                                tvScanQr.setTag("http://" + url);
                            }
                            tvScanQr.setVisibility(View.VISIBLE);
                        } else {
                            tvScanQr.setVisibility(View.GONE);
                        }
                        show();
                    }
                });
    }


    public <T> AutoDisposeConverter<T> bindAutoDispose(LifecycleOwner lifecycleOwner) {
        return AutoDispose.autoDisposable(AndroidLifecycleScopeProvider
                .from(lifecycleOwner, Lifecycle.Event.ON_DESTROY));
    }
}
