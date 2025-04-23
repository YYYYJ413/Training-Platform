package com.smxy.daydayup.mapper;

import com.smxy.daydayup.pojo.Sign;
import com.smxy.daydayup.pojo.vo.HistorySignVo;
import com.smxy.daydayup.pojo.vo.SignVo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface SignMapper {
    int deleteByPrimaryKey(Integer signId);

    int insert(Sign record);

    int insertSelective(Sign record);

    Sign selectByPrimaryKey(Integer signId);

    int updateByPrimaryKeySelective(Sign record);

    int updateByPrimaryKey(Sign record);

    List<SignVo> selectSignInfoByCourseAndUser(@Param("courseId")Long courseId, @Param("userId")String userId);

    int updateUserSignByUserAndNumberAndCourse(@Param("userId")String userId,@Param("signNumber")Integer signNumber,@Param("courseId")Long courseId);

    List<HistorySignVo> selectHistorySignByCourse(@Param("courseId")Long courseId);

    List<String> selectUserByCourseAndNumber(@Param("courseId")Long courseId,@Param("signNumber")Integer signNumber);

    int selectCountByCourse(@Param("courseId")Long courseId);

    List<String> selectAllUserByCourse(@Param("courseId")Long courseId);

    List<String> selectUserIdByCourse(@Param("courseId")Long courseId);

    Integer selectMaxByCourse(@Param("courseId")Long courseId);
}