package cn.pup.erp.iteration.service;

import cn.pup.erp.iteration.entity.Employee;

import java.util.List;
import java.util.Map;

/**
 * 方法名大体根据 Mapper 对应产生
 *
 * @author HH
 */
public interface EmployeeService {
    /**
     * 根据ID查单个员工
     *
     * @param employeeId 员工ID
     * @return 查询结果
     */
    Employee selectById(Integer employeeId);

    /**
     * 根据 condition 模糊查询，condition为空时，返回全部
     *
     * @param pageNum   当前页码
     * @param pageSize  每页行数
     * @param condition 查询条件
     * @return 查询结果
     */
    List<Employee> selectAll(Integer pageNum, Integer pageSize, Map<String, Object> condition);

    /**
     * 插入新员工
     *
     * @param record 新员工信息
     * @return 操作结果
     */
    Integer insert(Employee record);

    /**
     * 更新员工
     *
     * @param record 员工信息
     * @return 操作结果
     */
    Integer updateById(Employee record);

    /**
     * 删除员工
     *
     * @param employeeId 员工ID
     * @return 操作结果
     */
    Integer deleteById(Integer employeeId);

}
