package com.petcom.community.util;

import org.apache.commons.lang3.StringUtils;
import org.springframework.util.DigestUtils;

import java.util.UUID;

public class CommunityUtil {

    // generate random string (UUID)
    public static String generateUUID() {
        return UUID.randomUUID().toString().replaceAll("","");
    }

    // MD5 encipher
    public static String md5(String key) {
        if(StringUtils.isBlank(key)) {
            return null;
        }
        return DigestUtils.md5DigestAsHex(key.getBytes());
    }

}
