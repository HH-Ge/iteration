package cn.pup.erp.iteration.controller;

import cn.pup.erp.iteration.entity.Department;
import cn.pup.erp.iteration.service.DepartmentService;
import cn.pup.erp.iteration.utils.IterationUtil;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author HH
 */
@Controller
@RequestMapping("/dept")
public class DepartmentController {

    private final DepartmentService departmentService;

    @Autowired
    public DepartmentController(DepartmentService departmentService) {
        this.departmentService = departmentService;
    }

    /**
     * form表单提交 Date类型数据绑定
     * <注意> pattern 的格式一定一定一定要与页面的格式对应好
     *
     * @param binder 页面传来的数据？
     */
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }

    /**
     * 部门列表的分页显示
     * 传递 pageNum 和 pageSize 两个参数产生分页，默认显示第 1 页，每页 15 行
     * list 实际上是个 Page<List> 对象
     * 使用 pageInfo 对象，设定分页导航按钮数（navigatePages），完美取出分页信息
     * 但是，pageInfo 对象里面貌似还套着一个 list，而且这个 list 在 Thymeleaf 模板上还取不到值？
     * 只好多装一个 list 到 Model
     *
     * @param model    页面
     * @param pageNum  当前页码
     * @param pageSize 每页行数
     * @return 部门列表页 department
     */
    @RequestMapping("/list")
    public String listDepartment(Model model,
                                 @ModelAttribute(value = "filter") Department filter,
                                 @RequestParam(value = "pageNum", defaultValue = "1", required = false) int pageNum,
                                 @RequestParam(value = "pageSize", defaultValue = "15", required = false) int pageSize,
                                 @ModelAttribute(value = "gmtCreateMax") Date gmtCreateMax,
                                 @ModelAttribute(value = "gmtModifiedMax") Date gmtModifiedMax) throws Exception {

        //System.out.println("======== Controller /list  =============");
        //System.out.println("Model get = " + model);
        System.out.println(" filter =  " + filter);
        System.out.println(" gmtCreateMax = " + gmtCreateMax);
        System.out.println(" gmtModifiedMax = " + gmtModifiedMax);
        Department record = new Department();
//        Boolean hasFilter = model.containsAttribute("filter");
//        System.out.println("hasFilter = " + hasFilter + (hasFilter ? "; filter = " + filter : ""));
//        if (hasFilter) {
        if (filter != null) {
            BeanUtils.copyProperties(filter, record);
            IterationUtil.addLike(record);
        }
//        } else {
//            model.addAttribute("filter", filter);
//        }
        System.out.println("record = " + record);
        Map<String, Object> condition = new HashMap<>(16);
        condition.put("record", record);
        condition.put("gmtCreateMax", gmtCreateMax);
        condition.put("gmtModifiedMax", gmtModifiedMax);
        System.out.println("condition = " + condition);
        List<Department> departments = departmentService.selectAll(pageNum, pageSize, condition);
        PageInfo pageInfo = new PageInfo(departments, 5);
        //System.out.println(departments);
        model.addAttribute("depts", departments);
        model.addAttribute("pageInfo", pageInfo);
        //System.out.println("Model return = " + model);
        return "department/list";
    }

    /**
     * 添加新部门，响应添加页面的提交按钮
     *
     * @param dept 表单传回的 Department 对象
     * @return 跳转到 list 页面
     */
    @PostMapping("/edit")
    public String addNewDepartment(@ModelAttribute(value = "dept") Department dept) {
        Date date = new Date();
        dept.setCreator("HH");
        dept.setModifier("HH");
        dept.setGmtCreate(date);
        dept.setGmtModified(date);
        departmentService.insert(dept);
        return "redirect:list";
    }


    /**
     * 编辑部门信息，响应编辑页面（与添加页面复用）的提交按钮
     *
     * @param dept 表单传回的 Department 对象
     * @return 跳转到 list 页面
     */
    @PutMapping("/edit")
    public String updateDepartment(@ModelAttribute(value = "dept") Department dept) {
        System.out.println("###############################");
        System.out.println("UpdateDepartment : dept = " + dept);
        System.out.println("###############################");
        dept.setGmtModified(new Date());
        dept.setModifier("HH");
        System.out.println("###############################");
        System.out.println("dept = " + dept);
        System.out.println("###############################");
        departmentService.updateById(dept);

        return "redirect:list";
    }


    /**
     * 来到添加页面
     * , @ModelAttribute(value = "dept") Department dept
     *
     * @return 添加页面（与编辑页面复用）
     */
    @GetMapping(value = "/add")
    public String toAddPage(Model model) {
        // 如果没有表单需要的对象 condition，则为 Model 添加一个

        model.addAttribute("dept", new Department());

        return "department/edit";
    }

    /**
     * 来到编辑页面
     *
     * @return 编辑页面（与添加页面复用）
     */
    @GetMapping(value = "/show")
    public String toEditPage(Model model,
                             @RequestParam(value = "id", required = true) int deptId) {
        Department dept = departmentService.selectById(deptId);
        System.out.println("############################################");
        System.out.println("toEditPage : dept = " + dept);
        System.out.println("############################################");

        model.addAttribute("dept", dept);
        return "department/edit";
    }


}

