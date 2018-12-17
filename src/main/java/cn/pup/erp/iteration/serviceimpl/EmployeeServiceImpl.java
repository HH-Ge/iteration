package cn.pup.erp.iteration.serviceimpl;

import cn.pup.erp.iteration.entity.Employee;
import cn.pup.erp.iteration.mapper.EmployeeMapper;
import cn.pup.erp.iteration.service.EmployeeService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service
public class EmployeeServiceImpl implements EmployeeService {

    @Resource
    private EmployeeMapper employeeMapper;

    @Override
    public Employee selectById(Integer employeeId) {
        return employeeMapper.selectByPrimaryKey(employeeId);
    }

    @Override
    public List<Employee> selectAll(Integer pageNum, Integer pageSize, Map<String, Object> condition) {
        return null;
    }

    @Override
    public Integer insert(Employee record) {
        return null;
    }

    @Override
    public Integer updateById(Employee record) {
        return null;
    }

    @Override
    public Integer deleteById(Integer employeeId) {
        return null;
    }
}
