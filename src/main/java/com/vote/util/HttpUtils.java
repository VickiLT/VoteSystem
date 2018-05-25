package com.vote.util;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by sunwe on 2018/5/25.
 */
public class HttpUtils {
    private static String[] IEBrowserSignals = {"MSIE", "Trident", "Edge"};

    public static boolean isMSBrowser(HttpServletRequest request) {
        String userAgent = request.getHeader("User-Agent");
        for (String signal : IEBrowserSignals) {
            if (userAgent.contains(signal))
                return true;
        }
        return false;
    }
}
