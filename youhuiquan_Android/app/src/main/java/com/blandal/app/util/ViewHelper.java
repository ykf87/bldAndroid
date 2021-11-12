package com.blandal.app.util;

import android.view.View;

import com.jakewharton.rxbinding4.view.RxView;

import java.util.concurrent.TimeUnit;

import io.reactivex.rxjava3.android.schedulers.AndroidSchedulers;
import io.reactivex.rxjava3.functions.Consumer;

/**
 * Description:
 * Author: ljx
 * Date: 2020/7/25 15:02
 */
public class ViewHelper {

    public static void throttleClick(View view, Consumer consumer) {
        throttleClick(view, 500, consumer);
    }

    public static void throttleClick(View view, int MILLISECONDS, Consumer consumer) {

        if (view != null) {
            RxView.clicks(view)
                    .throttleFirst(MILLISECONDS, TimeUnit.MILLISECONDS)
                    .subscribeOn(AndroidSchedulers.mainThread())
                    .subscribe(consumer);
        }

    }
}
