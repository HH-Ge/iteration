package cn.pup.erp.iteration.mapper;

import cn.pup.erp.iteration.entity.Feedback;

import java.util.List;
import java.util.Map;

public interface FeedbackMapper {

    int deleteByPrimaryKey(Integer feedbackId);

    int insert(Feedback record);

    Feedback selectByPrimaryKey(Integer feedbackId);

    List<Feedback> selectAll(Map<String, Object> condition);

    int updateByPrimaryKey(Feedback record);
}