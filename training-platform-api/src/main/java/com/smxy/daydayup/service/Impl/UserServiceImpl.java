package com.smxy.daydayup.service.Impl;

import com.smxy.daydayup.mapper.UserMapper;
//import com.smxy.daydayup.pojo.StudentClass;
import com.smxy.daydayup.pojo.User;
import com.smxy.daydayup.pojo.ao.UserAo;
import com.smxy.daydayup.service.UserService;
import com.smxy.daydayup.util.IdUtil;
import com.smxy.daydayup.util.datetime.DateUtil;
import com.smxy.daydayup.util.number.EncryptionUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
  * @team daydayup
  * @time 2021-12-06 21:45
  */
@Service
public class UserServiceImpl implements UserService{

    // Mapper自动装配
    @Resource
    private UserMapper userMapper;
//    @Autowired
//    private StudentClassMapper studentClassMapper;

//    // 实体类自动装配
//    @Autowired
//    private StudentClass studentClass;
//    @Autowired
//    private User user;

    private String userUUID; //生成用户唯一的UUID
    private String studentClassUUID; //生成学生班级信息的唯一的UUID
    private String studentCollege; //学院名
    private String studentMajor; //专业名


    @Override
    public int deleteByPrimaryKey(String userId) {
        return userMapper.deleteByPrimaryKey(userId);
    }

    @Override
    public int insert(User record) {
        return userMapper.insert(record);
    }

    @Override
    public int insertSelective(User record) {
        return userMapper.insertSelective(record);
    }

    @Override
    public User selectByPrimaryKey(String userId) {
        return userMapper.selectByPrimaryKey(userId);
    }

    @Override
    public int updateByPrimaryKeySelective(User record) {
        return userMapper.updateByPrimaryKeySelective(record);
    }

    @Override
    public int updateByPrimaryKey(User record) {
        return userMapper.updateByPrimaryKey(record);
    }

    @Override
    public int checkNumber(String userNumber, Long schoolId) {
        return userMapper.checkNumber(userNumber,schoolId);
    }

    @Override
    public int checkTel(String userTel) {
        return userMapper.checkTel(userTel);
    }

    @Override
    public User userLogin(UserAo record) {
        User user = userMapper.userLogin(record);
        if(user == null
                || EncryptionUtil.verify(record.getUserPassword(),user.getUserPassword())){
            return user;
        }else{
            return null;
        }
    }

/*    @Override
    public String userInfoRegister(User record) {
        User user = new User();
        StudentClass studentClass = new StudentClass();
        Map<String,String> map = ResolveNumberUtil.constructMap(record.getUserNumber());
        if(!ResolveNumberUtil.resolveMap(map)){
            return "学号解析错误";
        }else{
//            studentCollege = collegeMapper.selectNameByNumber(map.get("college"),record.getSchoolId());
//            studentMajor = majorMapper.selectNameByNumber(map.get("major"),map.get("college"),record.getSchoolId());
            if(studentCollege==null
               || studentMajor == null && record.getUserNumber().length()!=8){
                return "学号/工号信息错误";
            }
            //配置班级表初始信息
            studentClassUUID = IdUtil.getUUID();
            studentClass.setStudentClassId(studentClassUUID);
            studentClass.setStudentCollege(studentCollege);
            studentClass.setStudentClassGrade(map.get("grade"));
            studentClass.setStudentClassMajor(studentMajor);
            studentClass.setStudentClassNumber(Integer.parseInt(map.get("number")));
            studentClass.setStudentClassIndex(Integer.parseInt(map.get("index")));
            studentClass.setGmtCreate(DateUtil.getNowDate());
            studentClass.setGmtModify(DateUtil.getNowDate());
            if(studentClassMapper.insert(studentClass)>0){
                if(userMapper.updateByPrimaryKeySelective(record)>0){
                    return "success";
                }else{
                    return "服务器异常,修改用户信息失败";
                }
            }else{
                return "服务器异常,创建班级失败";
            }
        }
    }*/

    @Override
    public String userRegister(String userNumber,String userName, String userPassword,int userGender) {
        userUUID = IdUtil.getUUID();
        int typeId=1000;
        if(userMapper.userRegister(userUUID, userNumber, userName, EncryptionUtil.md5WithSalt(userPassword),
                userGender,typeId, DateUtil.getNowDate(),DateUtil.getNowDate())>0){
            return userUUID;
        }else{
            return null;
        }
    }

}
