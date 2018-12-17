package cn.pup.erp.iteration.utils;


import org.junit.Test;

public class IterationUtilTest {

    @Test
    public void testRandomInt() {
        int min = 1;
        int max = 10;
        int result;

        for (int i = 1; i <= 10; i++) {
            result = IterationUtil.randomInt(min, max);
            System.out.println("[" + i + "]: " + result);
        }
    }


}