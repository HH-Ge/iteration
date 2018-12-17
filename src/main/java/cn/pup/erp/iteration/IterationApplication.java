package cn.pup.erp.iteration;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * @author HH
 */
@SpringBootApplication
@MapperScan("cn.pup.erp.iteration.mapper")
public class IterationApplication {

    public static void main(String[] args) {

        SpringApplication.run(IterationApplication.class, args);
    }
}
