package com.smxy.daydayup.controller;

import com.smxy.daydayup.pojo.User;
import com.smxy.daydayup.pojo.Vercode;
import com.smxy.daydayup.pojo.ao.UserAo;
import com.smxy.daydayup.service.UserService;
import com.smxy.daydayup.service.VercodeService;
import com.smxy.daydayup.util.JwtUtils;
import com.smxy.daydayup.util.number.VerifyCodeUtil;
import com.smxy.daydayup.util.result.ResultUtil;
import com.smxy.daydayup.util.result.ReturnResult;
import com.smxy.daydayup.util.result.StatusCode;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailSendException;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


/**
 * @team daydayup
 * @time 2021-12-07 7:27
 */
@Slf4j
@Api(tags = "登录控制器")
@RestController
@RequestMapping("/user")
public class LoginController {

    // 邮箱正则效验
    private String regEx = "^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$";
    private String regEx2 = "^([a-z0-9A-Z]*)@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$";
    // 发件人
    private String sender = "yuexiamantian@163.com";
    // 邮箱验证码有效时长
    private Integer validTime = 5*60*1000;

    @Autowired
    private JavaMailSender mailSender; //自动装配邮箱接口
    @Autowired
    private UserService userService;
    @Autowired
    private VercodeService vercodeService;

//    @Auoptowired
//    private User user;
//    @Autowired
//    private UserAo userAo;
    public static class LoginRequest {
        private String usernumber;
        private String password;
        private Integer typeId;

        // Getter 和 Setter 方法
        public String getUsernumber() {
            return usernumber;
        }

        public void setUsernumber(String usernumber) {
            this.usernumber = usernumber;
        }

        public String getPassword() {
            return password;
        }

        public void setPassword(String password) {
            this.password = password;
        }

        public Integer getTypeId() {
            return typeId;
        }
        public void setTypeId(Integer type) {
            this.typeId = type;
        }
    }

    public static class UserRegisterRequest {
        private String userNumber;
        private String userName;
        private String userPassword;
        private Integer userGender;

        // Getter 方法
        public String getUserNumber() {
            return userNumber;
        }

        public String getUserName() {
            return userName;
        }

        public String getUserPassword() {
            return userPassword;
        }

        public Integer getUserGender() {
            return userGender;
        }

        // Setter 方法
        public void setUserNumber(String userNumber) {
            this.userNumber = userNumber;
        }

        public void setUserName(String userName) {
            this.userName = userName;
        }

        public void setUserPassword(String userPassword) {
            this.userPassword = userPassword;
        }

        public void setUserGender(Integer userGender) {
            this.userGender = userGender;
        }
    }

    @ApiOperation("用户邮箱登录接口")
    @ApiImplicitParams({
            @ApiImplicitParam(
                    name = "userEmail",
                    value = "用户邮箱",
                    required = true,
                    dataTypeClass = String.class
            ),
            @ApiImplicitParam(
                    name = "emailCode",
                    value = "邮箱验证码",
                    required = true,
                    dataTypeClass = String.class
            )
    })
    @PostMapping("/login/email")
    public ReturnResult userLoginByEmail(@RequestParam("userEmail") String userEmail,
                                         @RequestParam("emailCode") String emailCode){
        UserAo userAo = new UserAo();
        User user = new User();
        Vercode verCode = vercodeService.selectByVercodeKey(userEmail);
        if(!checkEmailCode(verCode,emailCode)){
            return ResultUtil.returnFail(StatusCode.DATA_ERROR,"验证码错误");
        }else{
//            userAo.setUserEmail(userEmail);
            user = userService.userLogin(userAo);
        }
        if(user != null) {
            return ResultUtil.returnSuccess(user, "登录成功");
        }else{
            return ResultUtil.returnFail(StatusCode.NOT_FIND_DATA,"邮箱错误");
        }
    }
    @ApiOperation("用户手机号登录接口")
    @ApiImplicitParams({
            @ApiImplicitParam(
                    name = "userTel",
                    value = "用户手机号",
                    required = true,
                    dataTypeClass = String.class
            ),
            @ApiImplicitParam(
                    name = "userPassword",
                    value = "用户密码",
                    required = true,
                    dataTypeClass = String.class
            )
    })

    @PostMapping("/login/tel")
    public ReturnResult userLoginByTel(@RequestParam("userTel") String userTel,
                                       @RequestParam("userPassword") String userPassword){
        UserAo userAo = new UserAo();
        User user = new User();
        if(userTel == null || userPassword == null ){
            return ResultUtil.returnFail(StatusCode.PARAMETER_ISNULL,"参数为空");  // 冗余代码，后端不应该进行非空判断，应该直接抛出异常
        }else{
//            userAo.setUserTel(userTel);
            userAo.setUserPassword(userPassword);
            user = userService.userLogin(userAo);
        }
        if(user != null) {
            return ResultUtil.returnSuccess(user, "登录成功");
        }else{
            return ResultUtil.returnFail(StatusCode.NOT_FIND_DATA,"手机号或密码错误");
        }
    }

    @ApiOperation("用户学号登录接口")
    @ApiImplicitParams({
            @ApiImplicitParam(
                    name = "userNumber",
                    value = "学号",
                    required = true,
                    dataTypeClass = String.class
            ),
            @ApiImplicitParam(
                    name = "userPassword",
                    value = "用户密码",
                    required = true,
                    dataTypeClass = String.class
            )
    })
    @PostMapping("/login/number")
    public ReturnResult userLoginByNumber(@RequestBody LoginRequest loginRequest){
        UserAo userAo = new UserAo();
        User user;
        String usernumber = loginRequest.getUsernumber();
        String password = loginRequest.getPassword();
        System.out.println(usernumber+' '+password);
        Integer typeId=loginRequest.getTypeId();
//        System.out.println(typeId);
        if(usernumber==null||password==null){
            return ResultUtil.returnFail(StatusCode.PARAMETER_ISNULL,"用户名或密码不能为空");
        }else{
            userAo.setUserNumber(usernumber);
            userAo.setUserPassword(password);
            userAo.setTypeId(typeId);
//            System.out.println(userAo);
            user = userService.userLogin(userAo);
        }
        if(user != null) {
            String ddToken = JwtUtils.createDDToken(user);
            user.setDdToken(ddToken);
            return ResultUtil.returnSuccess(user, "登录成功");
        }else{
            System.out.println(user);
            return ResultUtil.returnFail(StatusCode.NOT_FIND_DATA,"账号或密码错误");
        }
    }

    @ApiOperation("用户注册接口(完善必要信息)")
    @ApiImplicitParams({
            @ApiImplicitParam(
                    name = "userNumber",
                    value = "账号",
                    required = true,
                    dataTypeClass = String.class
            ),
            @ApiImplicitParam(
                    name = "userName",
                    value = "姓名",
                    required = true,
                    dataTypeClass = String.class
            ),
            @ApiImplicitParam(
                    name = "userPassword",
                    value = "密码",
                    required = true,
                    dataTypeClass = String.class
            ),
            @ApiImplicitParam(
                    name = "userGender",
                    value = "性别",
                    required = true,
                    dataTypeClass = Integer.class
            ),
    })
    @PostMapping("/register")
    public ReturnResult userRegister(@RequestBody UserRegisterRequest request){
        String userNumber = request.getUserNumber();
        String userName = request.getUserName();
        String userPassword = request.getUserPassword();
        Integer userGender = request.getUserGender();
        String info = userService.userRegister(userNumber,userName,userPassword,userGender);
        if(info!=null){
            return ResultUtil.returnSuccess(info,"注册成功");
        }else{
            return ResultUtil.returnFail(StatusCode.SERVER_EXCEPTION,"服务器异常，创建用户失败");
        }
        // 后端再次校验数据是否错误，需要确保账号具有唯一性
//        if (userNumber) {
//            log.warn("userId {} 非法账号数据 {}", userId, userNumber);
//            return ResultUtil.returnFail(StatusCode.SERVER_EXCEPTION, "服务器异常, 非法数据");
//        } else {
//
//        }
    }

    @ApiOperation("生成随机验证码接口")
    @GetMapping("/code")
    public ReturnResult generateCode(HttpSession session){
        String verCode = VerifyCodeUtil.generateCode();
        session.setAttribute("verCode",verCode);
        return ResultUtil.returnSuccess(verCode);
    }

    @ApiOperation(value = "发送邮箱的接口")
    @ApiImplicitParams({
            @ApiImplicitParam(
                    name = "userEmail",
                    value = "邮箱",
                    required = true,
                    dataTypeClass = String.class
            ),
            @ApiImplicitParam(
                    name = "tag",
                    value = "注册标识,判断是否为注册邮箱",
                    required = false,
                    dataTypeClass = String.class
            )
    })
    @PostMapping("/email")
    public ReturnResult toEmail(@RequestParam("userEmail") String userEmail,
                                @RequestParam(value = "tag",required = false) String tag){
//        if("register".equals(tag) && userService.checkEmail(userEmail)>0){
//            return ResultUtil.returnFail(StatusCode.SAME_FAIL,"该邮箱已被注册过");
//        }
        if("register".equals(tag)){
            return ResultUtil.returnFail(StatusCode.SAME_FAIL,"该邮箱已被注册过");
        }
        Pattern pattern = Pattern.compile(regEx);
        Pattern pattern2 = Pattern.compile(regEx2);
        Matcher matcher = pattern.matcher(userEmail);
        Matcher matcher2 = pattern2.matcher(userEmail);
        if(!matcher.matches() && !matcher2.matches()){
            return ResultUtil.returnFail(StatusCode.DATA_ERROR,"邮箱格式错误");
        }else {
            SimpleMailMessage message = new SimpleMailMessage();  //简单的邮件类
            String verCode = VerifyCodeUtil.generateCode(); // 生成随机的4位数验证码
            message.setFrom(sender);
            message.setTo(userEmail);
            message.setSubject("【三人行】您本次的验证码是");
            message.setText("尊敬的用户,您好:\n"
                    + "\n本次请求的邮件验证码为:\n" + verCode + "\n本验证码 5 分钟内效，请及时输入。（请勿泄露此验证码）\n"
                    + "\n如非本人操作，请忽略该邮件。\n(这是一封通过自动发送的邮件，请不要直接回复）");
            try {
                mailSender.send(message);
                Vercode record = new Vercode(null, userEmail, verCode, System.currentTimeMillis());
                if(vercodeService.selectByVercodeKey(userEmail)==null) {
                    vercodeService.insertSelective(record);
                }else{
                    vercodeService.updateByVercodeKey(record);
                }
                return ResultUtil.returnSuccess();
            }catch (MailSendException e){
                log.warn("发送邮件失败", e);
                return ResultUtil.returnFail(StatusCode.SERVER_EXCEPTION,"目标邮箱不存在");
            }catch (Exception e){
                log.warn("发送邮件失败", e);
                return ResultUtil.returnFail(StatusCode.SERVER_EXCEPTION,"文本邮件发送异常");
            }
        }
    }
//    @ApiOperation("显示所有学校的接口")
//    @GetMapping("/school")
//    public ReturnResult showSchool(){
//        return ResultUtil.returnSuccess(schoolService.selectAll(),"学校信息");
//    }

    // 效验邮箱验证码
    private boolean checkEmailCode(Vercode vercode,String emailCode){
        if(vercode==null
        || emailCode==null
        || "".equals(emailCode)){
            return false;
        }
        if(System.currentTimeMillis()-vercode.getTimeStamp()>validTime
        || !vercode.getVercodeValue().equals(emailCode)){
            return false;
        }else{
            return true;
        }
    }
}
