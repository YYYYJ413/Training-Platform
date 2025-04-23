<template>
    <div class="preview">
        <!-- 题目 -->
        <div class="question-info">
            <div class="info">
                <slot name="number"></slot>
                <span class="number" v-if="props.number">{{ props.number }}.</span>
                <span class="type-name">({{ type.simpleName }})</span>

                <span>{{ question.itemContent }}({{ question.itemScore }}分)</span>
            </div>
            <slot name="question" :question="question" :options="options" :type="type"></slot>
        </div>
        <!-- 选项 -->
         <div class="options">
            <ul v-if="type.enumName == 'SINGLE_CHOICE' || type.enumName =='MULTIPLE_CHOICE'||type.enumName=='JUDGEMENT'">
                <!-- 单选/多选 -->
                <li v-for="(option,index) in options" :key="index">
                    <p class="option-content">{{ letterList[index] }}. {{ option.optionContent }}</p>
                </li>
            </ul>    
         </div>
        
        <!-- 答案 -->
        <div class="answer">
            <p><strong>答案：</strong>{{ getAnswer }}</p>
        </div>
    </div>
</template>

<script setup>
import { getQuestionType,letterList } from '@/enums/questionType';
import { computed, onMounted } from 'vue';

const props = defineProps({
    number: Number,
    itemType: String, //题目类型
    question: {
        type: Object,
        default: {
            "content": "",
            "courseId": "",
            "difficulty":""
        }
    },
    options: {
        type: Array,
        default:[]
    }
})

//题目类型
const type = computed(() => {
    return getQuestionType(props.itemType)
})
//题目答案
const getAnswer = computed(() => {
    const answer = []
    props.options.forEach((option, index) => {
        if (option.optionAnswer) {
            if (type.value.itemsConfig.prexType == 'letter') {
                answer.push(letterList[index]);
            } else {
                answer.push(option.optionAnswer)
            }
        }
    })
    if (answer.length == 0) {
        answer.push('略')
    }
    return answer.join('；')
})

onMounted(() => {
    // console.log(props.options);
})
</script>

<style>
.preview{
    padding: 10px;
    display: flex;
    flex-direction: column;
    margin-left: 45px;
    
    .question-info{
        line-height: 30px;
        text-align: left;

        .info{
            float: left;
        }
        .number {
            color: black;
            font-weight: bold;
        }
        .type-name{
            color:rgb(0, 0, 255);
            margin: 5px;
        }
    }

    .options{
        margin:5px;
        overflow: hidden;
        margin-left: 35px;

        .option-content{
            text-align: left;
        }

    }
    .answer{
        text-align: right;
        margin-right: 30px;
    }
}
</style>