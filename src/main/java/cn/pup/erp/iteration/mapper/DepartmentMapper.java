package cn.pup.erp.iteration.mapper;

import cn.pup.erp.iteration.entity.Department;

import java.util.List;
import java.util.Map;

/**
 * 由于方法名要和 XML 文件中一一对应，所以直接采用的 Generator 生成的名字
 *
 * @author HH
 */
public interface DepartmentMapper {
    /**
     * 根据部门ID删除部门
     *
     * @param departmentId 部门ID
     * @return 操作结果
     */
    int deleteByPrimaryKey(Integer departmentId);

    /**
     * 插入部门，新增
     *
     * @param record 部门信息
     * @return 操作结果
     */
    int insert(Department record);

    /**
     * 根据部门ID查询单个部门
     *
     * @param departmentId 部门ID
     * @return 查询结果
     */
    Department selectByPrimaryKey(Integer departmentId);

    /**
     * 根据查询条件模糊查询部门，条件为空时返回全部。
     * 为避免在实体类中无休止的增加属性，使用 Map 对象。
     * 根据表单中的查询条件由 Controller 预先定义好，页面加载时传入。
     *
     * @param condition 查询条件，
     * @return 查询结果
     */
    List<Department> selectAll(Map<String, Object> condition);

    /**
     * 更新部门
     *
     * @param record 部门信息
     * @return 操作结果
     */
    int updateByPrimaryKey(Department record);

}