package cn.pup.erp.iteration.controller;

import cn.pup.erp.iteration.entity.Employee;
import cn.pup.erp.iteration.entity.Feedback;
import cn.pup.erp.iteration.entity.Item;
import cn.pup.erp.iteration.service.EmployeeService;
import cn.pup.erp.iteration.service.FeedbackService;
import cn.pup.erp.iteration.service.ItemService;
import cn.pup.erp.iteration.utils.IterationUtil;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author HH
 */
@Controller
@RequestMapping("/feedback")
public class FeedbackController {

    private final FeedbackService feedbackService;
    @Resource
    private ItemService itemService;
    @Resource
    private EmployeeService employeeService;

    @Autowired
    public FeedbackController(FeedbackService feedbackService) {
        this.feedbackService = feedbackService;
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
     * 反馈列表的分页显示
     * 传递 pageNum 和 pageSize 两个参数产生分页，默认显示第 1 页，每页 15 行
     * list 实际上是个 Page<List> 对象
     * 使用 pageInfo 对象，设定分页导航按钮数（navigatePages），完美取出分页信息
     * 但是，pageInfo 对象里面貌似还套着一个 list，而且这个 list 在 Thymeleaf 模板上还取不到值？
     * 只好多装一个 list 到 Model
     *
     * @param model    页面
     * @param pageNum  当前页码
     * @param pageSize 每页行数
     * @return 反馈列表页 feedback
     */
    @RequestMapping("/list")
    public String listFeedback(Model model,
                               @ModelAttribute(value = "filter") Feedback filter,
                               @RequestParam(value = "pageNum", defaultValue = "1", required = false) int pageNum,
                               @RequestParam(value = "pageSize", defaultValue = "15", required = false) int pageSize,
                               @ModelAttribute(value = "gmtCreateMax") Date gmtCreateMax,
                               @ModelAttribute(value = "gmtModifiedMax") Date gmtModifiedMax) throws Exception {

        //System.out.println("======== Controller /list  =============");
        //System.out.println("Model get = " + model);
        System.out.println(" filter =  " + filter);
        System.out.println(" gmtCreateMax = " + gmtCreateMax);
        System.out.println(" gmtModifiedMax = " + gmtModifiedMax);
        Feedback record = new Feedback();
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
        List<Feedback> feedbacks = feedbackService.selectAll(pageNum, pageSize, condition);
        PageInfo pageInfo = new PageInfo(feedbacks, 5);
        //System.out.println(feedbacks);
        model.addAttribute("depts", feedbacks);
        model.addAttribute("pageInfo", pageInfo);
        //System.out.println("Model return = " + model);
        return "feedback/list";
    }

    /**
     * 添加新反馈，响应添加页面的提交按钮
     *
     * @param record 表单传回的 Feedback 对象
     * @return 跳转到 list 页面
     */
    @PostMapping("/edit")
    public String addNewFeedback(@ModelAttribute(value = "record") Feedback record) {
        Date date = new Date();
        Employee creator = employeeService.selectById(IterationUtil.randomInt(1, 10));
        record.setCreator(creator.getEmployeeName());
        record.setModifier(creator.getEmployeeName());
        record.setGmtCreate(date);
        record.setGmtModified(date);
        record.setIsHasAttachment(false);
        record.setIsValid(true);
        record.setFeedbackStatus("未回复");
        feedbackService.insert(record);
        //return "redirect:list";
        return "ok";
    }


    /**
     * 编辑反馈信息，响应编辑页面（与添加页面复用）的提交按钮
     *
     * @param record 表单传回的 Feedback 对象
     * @return 跳转到 list 页面
     */
    @PutMapping("/edit")
    public String updateFeedback(@ModelAttribute(value = "record") Feedback record) {
        System.out.println("###############################");
        System.out.println("UpdateFeedback : record = " + record);
        System.out.println("###############################");
        record.setGmtModified(new Date());
        Employee modifier = employeeService.selectById(IterationUtil.randomInt(1, 10));
        record.setModifier(modifier.getEmployeeName());
        System.out.println("###############################");
        System.out.println("record = " + record);
        System.out.println("###############################");
        feedbackService.updateById(record);

        //return "redirect:list";
        return "ok";
    }


    /**
     * 来到添加页面
     * , @ModelAttribute(value = "dept") Feedback dept
     *
     * @return 添加页面（与编辑页面复用）
     */
    @GetMapping(value = "/add")
    public String toAddPage(Model model) {
        // 查询所有的模块
        List<Item> modules = itemService.selectAllByParentId(7);
        // 查询所有的分类
        List<Item> categories = itemService.selectAllByParentId(2);
        // 查询所有的类型
        List<Item> types = itemService.selectAllByParentId(3);
        // 为 Model 添加一个用于记录表单数据的Feedback对象： record
        model.addAttribute("record", new Feedback());
        model.addAttribute("modules", modules);
        model.addAttribute("categories", categories);
        model.addAttribute("types", types);
        return "feedback/edit";
    }

    /**
     * 来到编辑页面
     *
     * @return 编辑页面（与添加页面复用）
     */
    @GetMapping(value = "/show")
    public String toEditPage(Model model,
                             @RequestParam(value = "id", required = true) int feedbackId) {
        Feedback record = feedbackService.selectById(feedbackId);
        System.out.println("############################################");
        System.out.println("toEditPage : record = " + record);
        System.out.println("############################################");
        // 查询所有的模块
        List<Item> modules = itemService.selectAllByParentId(7);
        // 查询所有的分类
        List<Item> categories = itemService.selectAllByParentId(2);
        // 查询所有的类型
        List<Item> types = itemService.selectAllByParentId(3);
        // 查询所有的类型
        List<Item> status = itemService.selectAllByParentId(4);
        model.addAttribute("record", record);
        model.addAttribute("modules", modules);
        model.addAttribute("categories", categories);
        model.addAttribute("types", types);
        model.addAttribute("status", status);
        return "feedback/edit";
    }
}

