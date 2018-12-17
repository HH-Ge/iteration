package cn.pup.erp.iteration.serviceimpl;

import cn.pup.erp.iteration.entity.Department;
import cn.pup.erp.iteration.mapper.DepartmentMapper;
import cn.pup.erp.iteration.service.DepartmentService;
import com.github.pagehelper.PageHelper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;


/**
 * @author HH
 */
@Service
public class DepartmentImpl implements DepartmentService {

    @Resource
    private DepartmentMapper departmentMapper;

    @Override
    public Department selectById(int departmentId) {

        return departmentMapper.selectByPrimaryKey(departmentId);
    }

    @Override
    public List<Department> selectAll(Integer pageNum, Integer pageSize, Map<String, Object> condition) {
        //将参数传给这个方法就可以实现物理分页了，非常简单。
        if (pageNum != null && pageSize != null) {
            PageHelper.startPage(pageNum, pageSize);
        }
        return departmentMapper.selectAll(condition);
    }


    @Override
    public Integer insert(Department record) {
        return departmentMapper.insert(record);
    }

    @Override
    public Integer updateById(Department record) {
        return departmentMapper.updateByPrimaryKey(record);
    }

    @Override
    public Integer deleteById(int departmentId) {
        return departmentMapper.deleteByPrimaryKey(departmentId);
    }
}
