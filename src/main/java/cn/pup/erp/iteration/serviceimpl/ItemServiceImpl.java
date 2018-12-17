package cn.pup.erp.iteration.serviceimpl;

import cn.pup.erp.iteration.entity.Item;
import cn.pup.erp.iteration.mapper.ItemMapper;
import cn.pup.erp.iteration.service.ItemService;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author hh680
 */

@Service
public class ItemServiceImpl implements ItemService {

    @Autowired
    private ItemMapper itemMapper;

    @Override
    public Item selectById(int itemId) {
        return itemMapper.selectByPrimaryKey(itemId);
    }

    @Override
    public List<Item> selectAll(Integer pageNum, Integer pageSize, Map<String, Object> condition) {
        if (pageNum != null && pageSize != null) {
            PageHelper.startPage(pageNum, pageSize);
        }
        return itemMapper.selectAll(condition);
    }

    @Override
    public List<Item> selectAllByParentId(Integer parentId) {
        Map<String, Object> condition = new HashMap<>(16);
        condition.put("parentId", parentId);
        return itemMapper.selectAll(condition);
    }

    @Override
    public Integer insert(Item record) {
        return itemMapper.insert(record);
    }

    @Override
    public Integer updateById(Item record) {
        return itemMapper.updateByPrimaryKey(record);
    }

    @Override
    public Integer deleteById(int itemId) {
        return itemMapper.deleteByPrimaryKey(itemId);
    }
}
