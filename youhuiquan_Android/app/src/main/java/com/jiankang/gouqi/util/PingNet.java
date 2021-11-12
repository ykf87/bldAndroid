package com.jiankang.gouqi.util;

import android.util.Log;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

/**
 * Description:ping工具类
 * author:ljx
 * time  :2020/12/21 13 44
 */
public class PingNet {

    private static final String TAG = "PingNet";

    /**
     * @param pingNetEntity 检测网络实体类
     * @return 检测后的数据
     */
    public static PingNetEntity ping(PingNetEntity pingNetEntity) {
        String line = null;
        Process process = null;
        BufferedReader successReader = null;
        String command = "ping -c " + pingNetEntity.getPingCount() + " -w " + pingNetEntity.getPingWtime() + " " + pingNetEntity.getIp();
//        String command = "ping -c " + pingCount + " " + host;
        try {
            process = Runtime.getRuntime().exec(command);
            if (process == null) {
                Log.e(TAG, "ping fail:process is null.");
                append(pingNetEntity.getResultBuffer(), "ping fail:process is null.");
                pingNetEntity.setPingTime(null);
                pingNetEntity.setResult(false);
                return pingNetEntity;
            }
            successReader = new BufferedReader(new InputStreamReader(process.getInputStream()));
            while ((line = successReader.readLine()) != null) {
                Log.i(TAG, line);
                append(pingNetEntity.getResultBuffer(), line);
                String time;
                if ((time = getTime(line)) != null) {
                    pingNetEntity.setPingTime(time);
                }
            }
            int status = process.waitFor();
            if (status == 0) {
                Log.i(TAG, "exec cmd success:" + command);
                append(pingNetEntity.getResultBuffer(), "exec cmd success:" + command);
                pingNetEntity.setResult(true);
            } else {
                Log.e(TAG, "exec cmd fail.");
                append(pingNetEntity.getResultBuffer(), "exec cmd fail.");
                pingNetEntity.setPingTime(null);
                pingNetEntity.setResult(false);
            }
            Log.i(TAG, "exec finished.");
            append(pingNetEntity.getResultBuffer(), "exec finished.");
        } catch (IOException e) {
            Log.e(TAG, String.valueOf(e));
        } catch (InterruptedException e) {
            Log.e(TAG, String.valueOf(e));
        } finally {
            Log.i(TAG, "ping exit.");
            if (process != null) {
                process.destroy();
            }
            if (successReader != null) {
                try {
                    successReader.close();
                } catch (IOException e) {
                    Log.e(TAG, String.valueOf(e));
                }
            }
        }
        Log.i(TAG, pingNetEntity.getResultBuffer().toString());
        return pingNetEntity;
    }

    private static void append(StringBuffer stringBuffer, String text) {
        if (stringBuffer != null) {
            stringBuffer.append(text + "\n");
        }
    }

    private static String getTime(String line) {
        String[] lines = line.split("\n");
        String time = null;
        for (String l : lines) {
            if (!l.contains("time=")) {
                continue;
            }
            int index = l.indexOf("time=");
            time = l.substring(index + "time=".length());
            Log.i(TAG, time);
        }
        return time;
    }

    public static class PingNetEntity {
        /*
         TODO：进行ping操作的ip
         */
        private String ip;

        /*
         TODO：进行ping操作的次数
         */
        private int pingCount;

    /*
     TODO：ping操作超时时间
     */

        private int pingWtime;

        /*
         TODO：存储ping操作后得到的数据
         */
        private StringBuffer resultBuffer;

        /*
         TODO：ping ip花费的时间
         */
        private String pingTime;

        /*
         TODO：进行ping操作后的结果
         */
        private boolean result;

        public PingNetEntity(String ip, int pingCount, int pingWtime,StringBuffer resultBuffer) {
            this.ip = ip;
            this.pingWtime=pingWtime;
            this.pingCount = pingCount;
            this.resultBuffer = resultBuffer;
        }

        public String getPingTime() {
            return pingTime;
        }

        public void setPingTime(String pingTime) {
            this.pingTime = pingTime;
        }

        public StringBuffer getResultBuffer() {
            return resultBuffer;
        }

        public void setResultBuffer(StringBuffer resultBuffer) {
            this.resultBuffer = resultBuffer;
        }

        public int getPingCount() {
            return pingCount;
        }

        public void setPingCount(int pingCount) {
            this.pingCount = pingCount;
        }

        public String getIp() {
            return ip;
        }

        public void setIp(String ip) {
            this.ip = ip;
        }

        public boolean isResult() {
            return result;
        }

        public void setResult(boolean result) {
            this.result = result;
        }

        public int getPingWtime() {
            return pingWtime;
        }

        public void setPingWtime(int pingWtime) {
            this.pingWtime = pingWtime;
        }
    }

}
