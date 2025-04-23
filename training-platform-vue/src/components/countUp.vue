<template>
    <span ref="countRef"></span>
</template>

<script setup lang="ts">
import { onMounted, watch, ref } from 'vue';
import { CountUp } from 'countup.js';

const props = defineProps({
    end: {
        type: Number,
        required: true,      
    },
    options: {
        type: Object,
        default: () => ({}),
        required: false,
    },
});

const countRef = ref < any > (null);
let countUp: any;
onMounted(() => {
    countUp = new CountUp(countRef.value, props.end, props.options);
    if (countUp.error) {
        console.error(countUp.error);
        return;
    }
    countUp.start();
});

watch(() => props.end, (newval) => {
    if (countUp) {
        countUp.update(newval);
    }
});
</script>