package com.petcom.community.util;

public interface CommunityConstant {
    /**
     * activation success
     */
    int ACTIVATION_SUCCESS = 0;

    /**
     * repeat activation
     */
    int ACTIVATION_REPEAT = 1;

    /**
     * activation failed
     */
    int ACTIVATION_FAILURE = 2;


    /**
     * RESTFUL response
     */
    String SUCCESS = "SUCCESS";

    String FAIL = "FAIL";

    String ERROR = "ERROR";

    String STATUS = "status";

    String MESSAGE = "message";

    /**
     * login expired time
     */

    int DEFAULT_EXPIRED_SECOND = 3600 * 12; // 12 hours

    int REMEBER_EXPIRED_SECOND = 3600 * 24 * 100; // over 3 month

}
