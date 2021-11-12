package com.blandal.app.util;

import android.text.Html;
import android.text.TextUtils;
import android.widget.TextView;

/**
 */
public class HtmlUtil {

    /**
     * 加载html内容
     * @param textView
     * @param html
     */
    public static void forHtml(TextView textView, String html) {
        if (textView == null || TextUtils.isEmpty(html)) {
            return;
        }

        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.N) {
            textView.setText(Html.fromHtml(html, Html.FROM_HTML_MODE_LEGACY));
        } else {
            textView.setText(Html.fromHtml(html));
        }
    }

    /**
     * 富文本适配
     */
    public static String getHtmlData(String bodyHTML) {
        String head = "<head>"
                + "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, user-scalable=no\"> "
                + "<style>img{max-width: 100%; width:auto; height:auto;}</style>"
                + "<link href=\"quill.bubble.css\" type=\"text/css\" rel=\"stylesheet\"/>"
                + "<link href=\"quill.core.css\" type=\"text/css\" rel=\"stylesheet\"/>"
                + "<link href=\"quill.snow.css\" type=\"text/css\" rel=\"stylesheet\"/>"
                + "</head>";
        return "<html>" + head + "<body><div class=\"ql-editor\">" + bodyHTML + "</div></body></html>";
//        String head = "<head>"
//                + "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, user-scalable=no\"> "
//                + "<style>img{max-width: 100%; width:auto; height:auto;}</style>"
//                + "</head>";
//        return "<html>" + head + "<body>" + bodyHTML + "</body></html>";
    }
}
