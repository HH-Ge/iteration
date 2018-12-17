package cn.pup.erp.iteration.utils;


import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.Map;
import java.util.Random;

/**
 * @author HH
 */
public class IterationUtil {

    /**
     * 通过反射获取实体类的所有属性
     *
     * @param object
     * @throws NoSuchMethodException
     * @throws IllegalAccessException
     * @throws InvocationTargetException
     */
    public static void addLike(Object object) throws NoSuchMethodException, IllegalAccessException, InvocationTargetException {

        // 获取实体类的所有属性，返回Field数组
        Field[] field = object.getClass().getDeclaredFields();

        // 获取属性的名字
        String[] objectName = new String[field.length];
        String[] objectType = new String[field.length];
        for (int i = 0; i < field.length; i++) {
            // 获取属性的名字
            String name = field[i].getName();
            objectName[i] = name;
            // 获取属性类型
            String type = field[i].getGenericType().toString();
            objectType[i] = type;
            //关键。。。可访问私有变量
            field[i].setAccessible(true);
            //给属性设置
            // field[i].set(object, field[i].getType().getConstructor(field[i].getType()).newInstance());
            // 将属性的首字母大写
            name = name.replaceFirst(name.substring(0, 1), name.substring(0, 1)
                    .toUpperCase());

            if (type.equals("class java.lang.String")) {
                // 如果type是类类型，则前面包含"class "，后面跟类名
                Method getMethod = object.getClass().getMethod("get" + name);

                // 调用getter方法获取属性值
                String value = (String) getMethod.invoke(object);

                if (value != null && value.trim() != "") {
                    //System.out.println("attribute value:" + value);
                    //System.out.println(type + "[ " + name + " = " + (String) getMethod.invoke(object) + " ]");
                    Method setMethod = object.getClass().getMethod("set" + name, String.class);
                    //System.out.println("setMethod : " + setMethod);
                    if (value.trim() == "null") {
                        setMethod.invoke(object, "");
                    } else {
                        setMethod.invoke(object, "%" + value + "%");
                    }
                    //System.out.println(type + "[ " + name + " = " + (String) getMethod.invoke(object) + " ]");

                }
            }
        }
    }

    public static void bianlimap(Map<String, Object> map) {

        System.out.println("通过Map.entrySet遍历key和value");
        for (Map.Entry<String, Object> entry : map.entrySet()) {
            //Map.entry<Integer,String> 映射项（键-值对）  有几个方法：用上面的名字entry
            //entry.getKey() ;entry.getValue(); entry.setValue();
            //map.entrySet()  返回此映射中包含的映射关系的 Set视图。
            String key = entry.getKey();
            Object value = entry.getValue();

            if (value != null && value.getClass() == String.class) {
                value = "%" + value + "%";
                map.put(key, value);
            }
        }
    }


    /**
     * 返回一个 MIN 和 MAX 范围内的随机整数
     *
     * @param min 最小值
     * @param max 最大值
     * @return
     */
    public static int randomInt(int min, int max) {
        Random rand = new Random();
        return rand.nextInt(max - min + 1) + min;
    }


}
