package cn.pup.erp.iteration.mapper;

import cn.pup.erp.iteration.entity.Item;

import java.util.List;
import java.util.Map;

public interface ItemMapper {

    int deleteByPrimaryKey(Integer itemId);

    int insert(Item record);

    Item selectByPrimaryKey(Integer itemId);

    List<Item> selectAll(Map<String, Object> condition);

    int updateByPrimaryKey(Item record);
}