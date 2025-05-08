package com.ders.bm470;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class Main {
    private static final Logger logger = LoggerFactory.getLogger(Main.class);

    public static void main(String[] args) {
        logger.info("✅ Log4j2 başarıyla çalışıyor!");
        logger.warn("Bu bir uyarıdır.");
        logger.error("Bu bir hata mesajıdır.");
    }
}
