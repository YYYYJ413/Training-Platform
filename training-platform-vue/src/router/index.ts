import { createRouter, createWebHistory, type RouteRecordRaw } from 'vue-router';


const routes: Array<RouteRecordRaw> = [
    {
        path: "/Login",
        name: "toLogin",
        component: () => import("@/views/Login/login.vue"),
    },
    {
        path: '/signup',
        name: 'signup',
        component: () => import('@/views/Login/toSign.vue')
    },

    {
        path: '/',
        name: 'Home',
        component: () => import('@/views/Home/Home.vue')
    },
    {
        path: '/bg_home',
        name: 'bg_Home',
        component: () => import('@/views/Home/bg_home.vue'),
        children: [
            {
                path: 'papers',
                name: 'papers',
                component: () => import('@/views/Home/bg_paper.vue')
            },
            {
                path: 'exams',
                name: 'exams',
                component: () => import('@/views/Home/bg_ExamList.vue')
            },
            {
                path: 'users',
                name: 'users',
                component: () => import('@/views/Home/bg_User.vue')
            },
            {
                path: 'c',
                name: 'bgcourses',
                component: () => import('@/views/BackGround/bg_course/bg_course.vue')
            },
            {
                path: 'bg_c_add',
                name: 'bgc_add',
                component: () => import('@/views/BackGround/bg_course/bg_course_add.vue')
            },
            {
                path: 'bg_c_edit/:course_id',
                name: 'bg_course_edit',
                component:()=>import('@/views/Background/bg_course/bg_course_edit.vue')
            },
            {
                path: 'sectionAdd',
                name: 'sectionadd',
                component: () => import('@/views/BackGround/bg_course/bg_section_add.vue')
            },
            {
                path: 'questions',
                name: 'questions',
                component:()=>import('@/views/Background/bg_reply.vue')
            },
            {
                path: 'quebank',
                name: 'quebank',
                component:()=>import('@/views/Background/bg_quebank.vue')
            },
            {
                path: '/HomePage',
                name: 'HomePage',
                component: () => import('@/views/Home/HomePage.vue')
            },
            {
                path: 'quebank/:bankId',
                name: 'quedetail',
                component:()=>import('@/views/Background/bg_quedetail.vue')
            }
        ]
    },
    {
        path: '/course',
        name: 'Course',
        component: () => import('@/views/Home/Course.vue')
    },
    {
        path: '/course/:id',
        name: 'CourseDetail',
        component: () => import('@/views/Course/CourseDetail.vue')
    },
    // {
    //     path: "/studycenter",
    //     name: "StudyCenter",
    //     component: () => import('@/views/Home/StudyCenter.vue'),
    // },
    {
        path: "/studycenter/:index?",
        name: "StudyCenter",
        props: true,
        component: () => import('@/views/Home/StudyCenter.vue'),
    },
    {
        path: "/AI",
        name: "AI",
        component: () => import('@/views/AI/AI.vue'),
    },
    {
        path: "/notify",
        name: "Notify",
        component: () => import('@/views/Home/Notify.vue'),
    },
    {
        path: '/exam/:id',
        name: 'ExamPage',
        component: () => import('@/views/Home/ExamPage.vue')
    },
    {
        path: '/exam-result/:id',
        name: 'ExamResult',
        component: () => import('@/views/Home/ExamResult.vue')

    },

    {
        path: '/section',
        name: 'Section',
        component: () => import('@/views/Section/Section.vue'),
        children: [
            {
                path: 'ask',
                name: 'ask',
                component: () => import('@/views/Section/ask.vue')
            },
        ]
    },
    {
        path: '/Evaluation',
        name: 'Evaluation',
        component: () => import('@/views/Section/Evaluation.vue')
    },
    {
        path: '/SectionContent/:chapterId',
        name: 'SectionContent',
        component: () => import('@/views/Section/SectionContent.vue')
    },
    {
        path: '/bg',
        name: 'bg',
        component: () => import('@/views/BackGround/bg_bar.vue'),
        children: [
            {
                path: 'bgCourse',
                name: 'bgCourse',
                component: () => import('@/views/BackGround/bg_course/bg_course.vue'),
                children: [

                    {
                        path: 'bgCourseEdit',
                        name: 'bgCourseEdit',
                        component: () => import('@/views/BackGround/bg_course/bg_course_edit.vue')
                    },

                    {
                        path: 'bgCourseAdd',
                        name: 'bgCourseAdd',
                        component: () => import('@/views/BackGround/bg_course/bg_course_add.vue')
                    }
                ]
            }
        ]
    },
]

const router = createRouter({
    history: createWebHistory(import.meta.env.BASE_URL),
    routes,
})


export default router;