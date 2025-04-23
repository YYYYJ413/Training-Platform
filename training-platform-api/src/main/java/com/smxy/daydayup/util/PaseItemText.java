package com.smxy.daydayup.util;

import com.smxy.daydayup.pojo.ItemOption;
import com.smxy.daydayup.pojo.vo.ItemBankInfoVo;
import com.smxy.daydayup.util.enums.QuestionTypeEnum;
import com.smxy.daydayup.util.result.ParseQuestionRules;

import lombok.extern.slf4j.Slf4j;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

/**
 * 方式一：正则表达
 *      缺点：不能正确提取内容，部分题目提取特征不明显
 * 方式二：逐行读取+正则表达
 *
 **/
@Slf4j
public class PaseItemText {
    static final String[] letterList = { "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"};

    public static List<ItemBankInfoVo> parse(String text, ParseQuestionRules rule){

        String divisionRule=rule.getDivisionRule();
        String questionRule=rule.getQuestionRule();
        String answerRule=rule.getAnswerRule();
        String optionRule=rule.getOptionRule();
        //1.把文本分割成单独的题目
        String[] questionInfoStr = text.split(divisionRule);
        //2.遍历题目文本
        ItemBankInfoVo questionInfo;
        List<ItemBankInfoVo> list=new ArrayList<>();
        QuestionTypeEnum type = QuestionTypeEnum.SINGLE_CHOICE;

        for (String str : questionInfoStr) {
            if(str.isEmpty()){
                continue;
            }
            log.info("题目信息=>"+str);
            questionInfo=new ItemBankInfoVo();
            Pattern pattern= Pattern.compile(answerRule);
            // 现在创建 matcher 对象
            //2.1 提取答案
            Matcher matcher = pattern.matcher(str);
            List<String>answerList=new ArrayList<>();
            if(matcher.find()){
                answerList= Arrays.stream(matcher.group(1).split(rule.getAnswerSplit())).collect(Collectors.toList());
            }
            log.info("答案=>"+answerList);
            //2.1.1 把答案去了
            str=str.replaceAll(answerRule,"");
            log.info("去答案后题目信息=>"+str);
            //2.2 提取选项
            List<String> optionList=Arrays.stream(str.split(optionRule)).collect(Collectors.toList());
            //2.3.提取题目
            questionInfo.setItemContent(optionList.get(0));
            log.info("题目=>"+optionList.get(0));
            optionList.remove(0);
            log.info("选项=>"+optionList);
            if(questionInfo.getItemContent().isBlank()){
                continue;
            }

            //2.4 确定题型
            if(optionList.isEmpty()){
                if(answerList.size()==1){
                    type=QuestionTypeEnum.SUBJECTIVE;
                }else{
                    type=QuestionTypeEnum.COMPLETION;
                }
            }else{
                if(answerList.size()==1){
                    if(optionList.size()==2){
                        type=QuestionTypeEnum.JUDGEMENT;
                    }else{
                        type=QuestionTypeEnum.SINGLE_CHOICE;
                    }
                }else{
                    type=QuestionTypeEnum.MULTIPLE_CHOICE;
                }
            }
            questionInfo.setItemType(type);
            //2.5获取题目选项
            questionInfo.setItemOptions(getItem(type,answerList,optionList));
            list.add(questionInfo);
        }
        return list;
    }
    public static List<ItemBankInfoVo> lineParse(String text, ParseQuestionRules rule) throws IOException {
        BufferedReader bufferedReader=new BufferedReader(new InputStreamReader(new ByteArrayInputStream(text.getBytes(StandardCharsets.UTF_8))));
        String buffer;
        List<ItemBankInfoVo> list=new ArrayList<>();
        int preStep=0;
        String tempStr;
        ItemBankInfoVo questionInfo;
        List<ItemOption> questionItems;
        QuestionTypeEnum type;
        while ((buffer=bufferedReader.readLine())!=null){
            questionInfo=new ItemBankInfoVo();
            switch (preStep){
                //啥也没匹配到，折为上一步的内容
                case 1:
                    tempStr=questionInfo.getItemContent();
                    questionInfo.setItemContent(tempStr+buffer);
                case 2:
                case 3:

            }
            if(buffer.matches(rule.getQuestionRule())){
                //当匹配的下一个题目的时候添加到
                preStep=1;
                questionInfo.setItemContent(buffer);
                questionItems=new ArrayList<>();
//                continue;如果题目中包含答案的模式吧
            }
            if(buffer.matches(rule.getQuestionRule())){
                preStep=2;
//                continue;
            }
            if(buffer.matches(rule.getAnswerRule())){
                preStep=3;
//                continue;
            }

        }
        return list;
    }
    private static List<ItemOption> getItem(QuestionTypeEnum type,List<String> answerList,List<String> optionList){
        List<ItemOption> list=null;
        //选择填空
        if(type==QuestionTypeEnum.SUBJECTIVE||type==QuestionTypeEnum.COMPLETION){
            list=answerList.stream().filter(i->!i.isBlank()).map(i->{
                ItemOption item=new ItemOption();
                item.setOptionAnswer(i);
                return item;
            }).collect(Collectors.toList());
            //单选多选
        }else if(type==QuestionTypeEnum.SINGLE_CHOICE||type== QuestionTypeEnum.MULTIPLE_CHOICE){
            List<String> temAnswerList=answerList.stream().map(e -> {
                return e.replaceAll("\\r|\\n|\\s", "").toUpperCase();
            }).collect(Collectors.toList());
            //获取字母的下标
            list= IntStream.rangeClosed(0,optionList.size()-1).filter(i->!optionList.get(i).isBlank()).mapToObj(i->{
                ItemOption item=new ItemOption();
                item.setOptionAnswer(optionList.get(i));
                //确定选项答案
                boolean contains = temAnswerList.contains(letterList[i]);
                if(contains){
                    log.error("正确答案");
                    item.setOptionAnswer("1");
                }
                return item;
            }).collect(Collectors.toList());
        }else if(type==QuestionTypeEnum.JUDGEMENT){

        }
        return list;
    }
}
