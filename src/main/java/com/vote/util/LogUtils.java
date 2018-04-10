package com.vote.util;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

/**
 * 日志工具类
 * Created by sunwe on 2018/3/8.
 */
public class LogUtils {
    static private Logger logger = LogManager.getLogger("testTime");


    public static void trace(Object object) {
        logger.trace(object);
    }

    public static void debug(Object object) {
        logger.debug(object);
    }

    public static void info(Object object) {
        logger.info(object);
    }

    public static void warn(Object object) {
        logger.warn(object);
    }

    public static void error(Object object) {
        logger.error(object);
    }

    public static void fatal(Object object) {
        logger.fatal(object);
    }
}
