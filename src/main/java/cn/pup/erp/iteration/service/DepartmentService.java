package cn.pup.erp.iteration.service;

import cn.pup.erp.iteration.entity.Department;

import java.util.List;
import java.util.Map;

/**
 * 方法名大体根据 Mapper 对应产生
 *
 * @author HH
 */
public interface DepartmentService {

    /**
     * 根据ID查单个部门
     *
     * @param departmentId 部门ID
     * @return 查询结果
     */
    Department selectById(int departmentId);

    /**
     * 根据 condition 模糊查询，condition为空时，返回全部
     *
     * @param pageNum   当前页码
     * @param pageSize  每页行数
     * @param condition 查询条件
     * @return 查询结果
     */
    List<Department> selectAll(Integer pageNum, Integer pageSize, Map<String, Object> condition);

    /**
     * 插入新部门
     *
     * @param record 新部门信息
     * @return 操作结果
     */
    Integer insert(Department record);

    /**
     * 更新部门
     *
     * @param record 部门信息
     * @return 操作结果
     */
    Integer updateById(Department record);

    /**
     * 删除部门
     *
     * @param departmentId 部门ID
     * @return 操作结果
     */
    Integer deleteById(int departmentId);

}
