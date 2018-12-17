package cn.pup.erp.iteration.serviceimpl;

import cn.pup.erp.iteration.entity.Feedback;
import cn.pup.erp.iteration.mapper.FeedbackMapper;
import cn.pup.erp.iteration.service.FeedbackService;
import com.github.pagehelper.PageHelper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service
public class FeedbackImpl implements FeedbackService {

    @Resource
    private FeedbackMapper feedbackMapper;

    @Override
    public Feedback selectById(int feedbackId) {
        return feedbackMapper.selectByPrimaryKey(feedbackId);
    }

    @Override
    public List<Feedback> selectAll(Integer pageNum, Integer pageSize, Map<String, Object> condition) {
        if (pageNum != null && pageSize != null) {
            PageHelper.startPage(pageNum, pageSize);
        }
        return feedbackMapper.selectAll(condition);
    }

    @Override
    public Integer insert(Feedback record) {
        return feedbackMapper.insert(record);
    }

    @Override
    public Integer updateById(Feedback record) {
        return feedbackMapper.updateByPrimaryKey(record);
    }

    @Override
    public Integer deleteById(int feedbackId) {
        return feedbackMapper.deleteByPrimaryKey(feedbackId);
    }
}
