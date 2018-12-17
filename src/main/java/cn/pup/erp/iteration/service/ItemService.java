package cn.pup.erp.iteration.service;

import cn.pup.erp.iteration.entity.Item;

import java.util.List;
import java.util.Map;

/**
 * @author hh680
 */
public interface ItemService {

    /**
     * 根据ID查单个条目
     *
     * @param itemId 条目ID
     * @return 查询结果
     */
    Item selectById(int itemId);

    /**
     * 根据 condition 模糊查询，condition为空时，返回全部
     *
     * @param pageNum   当前页码
     * @param pageSize  每页行数
     * @param condition 查询条件
     * @return 查询结果
     */
    List<Item> selectAll(Integer pageNum, Integer pageSize, Map<String, Object> condition);

    /**
     * 查询全部
     *
     * @return 查询结果
     */
    List<Item> selectAllByParentId(Integer parentId);

    /**
     * 插入新条目
     *
     * @param record 新条目信息
     * @return 操作结果
     */
    Integer insert(Item record);

    /**
     * 更新条目
     *
     * @param record 条目信息
     * @return 操作结果
     */
    Integer updateById(Item record);

    /**
     * 删除条目
     *
     * @param itemId 条目ID
     * @return 操作结果
     */
    Integer deleteById(int itemId);

}
