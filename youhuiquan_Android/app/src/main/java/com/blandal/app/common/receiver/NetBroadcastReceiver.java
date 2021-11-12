package com.blandal.app.common.receiver;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.util.Log;

import org.greenrobot.eventbus.EventBus;

import com.blandal.app.app.MyApplication;
import com.blandal.app.ui.main.event.NetStateEvent;
import com.blandal.app.util.PingNet;

/**
 * Description:网络监听
 * author:ljx
 * time  :2020/12/18 17 11
 */
public class NetBroadcastReceiver extends BroadcastReceiver {


    private static final String TAG = "NetBroadcastReceiver";

    private String getConnectionType(int type) {
        String connType = "";
        if (type == ConnectivityManager.TYPE_MOBILE) {
            connType = "3G网络数据";
        } else if (type == ConnectivityManager.TYPE_WIFI) {
            connType = "WIFI网络";
        }
        return connType;
    }


    @Override
    public void onReceive(Context context, Intent intent) {
//        // 这个监听wifi的打开与关闭，与wifi的连接无关
//        if (WifiManager.WIFI_STATE_CHANGED_ACTION.equals(intent.getAction())) {
//            int wifiState = intent.getIntExtra(WifiManager.EXTRA_WIFI_STATE, 0);
//            Log.e(TAG, "wifiState" + wifiState);
//            switch (wifiState) {
//                case WifiManager.WIFI_STATE_DISABLED:
//                    MyApplication.getInstance().setEnablaWifi(false);
//                    break;
//                case WifiManager.WIFI_STATE_DISABLING:
//
//                    break;
//                case WifiManager.WIFI_STATE_ENABLING:
//                    break;
//                case WifiManager.WIFI_STATE_ENABLED:
//                    MyApplication.getInstance().setEnablaWifi(true);
//                    break;
//                case WifiManager.WIFI_STATE_UNKNOWN:
//                    break;
//                default:
//                    break;
//
//
//            }
//        }
//        // 这个监听wifi的连接状态即是否连上了一个有效无线路由，当上边广播的状态是WifiManager
//        // .WIFI_STATE_DISABLING，和WIFI_STATE_DISABLED的时候，根本不会接到这个广播。
//        // 在上边广播接到广播是WifiManager.WIFI_STATE_ENABLED状态的同时也会接到这个广播，
//        // 当然刚打开wifi肯定还没有连接到有效的无线
//        if (WifiManager.NETWORK_STATE_CHANGED_ACTION.equals(intent.getAction())) {
//            Parcelable parcelableExtra = intent
//                    .getParcelableExtra(WifiManager.EXTRA_NETWORK_INFO);
//            if (null != parcelableExtra) {
//                NetworkInfo networkInfo = (NetworkInfo) parcelableExtra;
//                NetworkInfo.State state = networkInfo.getState();
//                boolean isConnected = state == NetworkInfo.State.CONNECTED;// 当然，这边可以更精确的确定状态
//                Log.e(TAG, "isConnected" + isConnected);
//                if (isConnected) {
//                    MyApplication.getInstance().setWifi(true);
//                } else {
//                    MyApplication.getInstance().setWifi(false);
//                }
//            }
//        }
        // 这个监听网络连接的设置，包括wifi和移动数据的打开和关闭。.
        // 最好用的还是这个监听。wifi如果打开，关闭，以及连接上可用的连接都会接到监听。见log
        // 这个广播的最大弊端是比上边两个广播的反应要慢，如果只是要监听wifi，我觉得还是用上边两个配合比较合适
        boolean isConnect = false;
        if (ConnectivityManager.CONNECTIVITY_ACTION.equals(intent.getAction())) {
            ConnectivityManager manager = (ConnectivityManager) context
                    .getSystemService(Context.CONNECTIVITY_SERVICE);
            Log.i(TAG, "CONNECTIVITY_ACTION");

            NetworkInfo activeNetwork = manager.getActiveNetworkInfo();
            if (activeNetwork != null) { // connected to the internet
                if (activeNetwork.isConnected()) {
                    if (activeNetwork.getType() == ConnectivityManager.TYPE_WIFI) {
                        // connected to wifi
                        //    MyApplication.getInstance().setWifi(true);
                        Log.e(TAG, "当前WiFi连接可用 ");
                    } else if (activeNetwork.getType() == ConnectivityManager.TYPE_MOBILE) {
                        // connected to the mobile provider's data plan
                        //    MyApplication.getInstance().setMobile(true);
                        Log.e(TAG, "当前移动网络连接可用 ");
                    }
                    isConnect = true;
                } else {
                    isConnect = false;
                    Log.e(TAG, "当前没有网络连接，请确保你已经打开网络 ");
                }

                Log.e(TAG, "info.getTypeName()" + activeNetwork.getTypeName());
                Log.e(TAG, "getSubtypeName()" + activeNetwork.getSubtypeName());
                Log.e(TAG, "getState()" + activeNetwork.getState());
                Log.e(TAG, "getDetailedState()"
                        + activeNetwork.getDetailedState().name());
                Log.e(TAG, "getDetailedState()" + activeNetwork.getExtraInfo());
                Log.e(TAG, "getType()" + activeNetwork.getType());
            } else {   // not connected to the internet
                Log.e(TAG, "当前没有网络连接，请确保你已经打开网络 ");
                //   MyApplication.getInstance().setWifi(false);
                //   MyApplication.getInstance().setMobile(false);
                isConnect = false;
            }

            try {
                new Thread(new Runnable() {
                    @Override
                    public void run() {
                        PingNet.PingNetEntity pingNetEntity = new PingNet.PingNetEntity("www.baidu.com", 3, 5, new StringBuffer());
                        pingNetEntity = PingNet.ping(pingNetEntity);
                        MyApplication.getInstance().setConnected(pingNetEntity.isResult());
                        EventBus.getDefault().post(new NetStateEvent());
                    }
                }).start();
            } catch (Exception e) {
                e.printStackTrace();
                MyApplication.getInstance().setConnected(false);
                EventBus.getDefault().post(new NetStateEvent());
            }


        }
    }


}
