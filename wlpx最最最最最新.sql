/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80034
 Source Host           : localhost:3306
 Source Schema         : wlpx

 Target Server Type    : MySQL
 Target Server Version : 80034
 File Encoding         : 65001

 Date: 10/04/2025 16:05:56
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sm_assess
-- ----------------------------
DROP TABLE IF EXISTS `sm_assess`;
CREATE TABLE `sm_assess`  (
  `assess_id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `course_id` int UNSIGNED NULL DEFAULT NULL,
  `assess_score` decimal(4, 2) NULL DEFAULT NULL,
  `assess_content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `user_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `time_create` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `time_modify` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`assess_id`) USING BTREE,
  INDEX `course_id`(`course_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `sm_assess_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `sm_courses` (`course_id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `sm_assess_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `sm_users` (`user_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sm_assess
-- ----------------------------
INSERT INTO `sm_assess` VALUES (1, 1000, 5.00, '非常好', '7d9030e8cb5841c288c7d8b2412b97cc', '2025-04-02 11:16:54', '2025-04-02 11:16:54');
INSERT INTO `sm_assess` VALUES (2, 1000, 4.50, '课程很有趣，老师讲解清晰', '7d9030e8cb5841c288c7d8b2412b97cc', '2025-04-09 10:17:47', '2025-04-09 10:17:47');
INSERT INTO `sm_assess` VALUES (3, 1005, 4.50, '收获很大，对慢性病管理有了新认识', '7d9030e8cb5841c288c7d8b2412b97cc', '2025-04-09 10:17:53', '2025-04-09 10:17:53');
INSERT INTO `sm_assess` VALUES (4, 1003, 3.00, '老师很好，但是给分低', '7d9030e8cb5841c288c7d8b2412b97cc', '2025-04-09 10:19:07', '2025-04-09 10:19:07');
INSERT INTO `sm_assess` VALUES (5, 1004, 4.00, '学分很高，值得一选', '7d9030e8cb5841c288c7d8b2412b97cc', '2025-04-09 10:18:05', '2025-04-09 10:18:05');
INSERT INTO `sm_assess` VALUES (6, 1003, 4.00, '学到新知识', '7d9030e8cb5841c288c7d8b2412b97cc', '2025-04-09 10:18:22', '2025-04-09 10:18:22');
INSERT INTO `sm_assess` VALUES (7, 1000, 4.00, '来选', '7d9030e8cb5841c288c7d8b2412b97cc', '2025-04-09 10:19:12', '2025-04-09 10:19:12');
INSERT INTO `sm_assess` VALUES (8, 1002, 4.00, '还可以', '7d9030e8cb5841c288c7d8b2412b97cc', '2025-04-09 10:19:17', '2025-04-09 10:19:17');
INSERT INTO `sm_assess` VALUES (9, 1000, 3.75, '可以选', '7d9030e8cb5841c288c7d8b2412b97cc', '2025-04-09 10:19:55', '2025-04-09 10:19:55');
INSERT INTO `sm_assess` VALUES (10, 1000, 4.25, '这门课程确实能让人学到知识，对学前儿童护理更为了解了，谢谢老师', '7d9030e8cb5841c288c7d8b2412b97cc', '2025-04-09 23:50:30', '2025-04-09 23:50:30');
INSERT INTO `sm_assess` VALUES (11, 1000, 4.50, '', '7d9030e8cb5841c288c7d8b2412b97cc', '2025-04-10 10:03:01', '2025-04-10 10:03:01');
INSERT INTO `sm_assess` VALUES (12, 1000, 4.25, '', '7d9030e8cb5841c288c7d8b2412b97cc', '2025-04-10 15:45:32', '2025-04-10 15:45:32');
INSERT INTO `sm_assess` VALUES (13, 1000, 4.25, '<script>test(); function test(){alert(123);}</script>', '7d9030e8cb5841c288c7d8b2412b97cc', '2025-04-10 15:53:15', '2025-04-10 15:53:15');

-- ----------------------------
-- Table structure for sm_bank_info
-- ----------------------------
DROP TABLE IF EXISTS `sm_bank_info`;
CREATE TABLE `sm_bank_info`  (
  `bank_id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `course_id` int UNSIGNED NOT NULL COMMENT '课程id',
  `item_count` int NOT NULL DEFAULT 0 COMMENT '题目数量',
  `time_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `time_modify` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `bank_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL COMMENT '题库名称',
  PRIMARY KEY (`bank_id`) USING BTREE,
  INDEX `course_id`(`course_id`) USING BTREE,
  CONSTRAINT `sm_bank_info_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `sm_courses` (`course_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1013 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sm_bank_info
-- ----------------------------
INSERT INTO `sm_bank_info` VALUES (1, 1003, 21, '2024-08-19 11:00:00', '2025-04-10 15:51:04', '常见疾病诊断与处理题库');
INSERT INTO `sm_bank_info` VALUES (2, 1004, 24, '2024-08-19 11:00:00', '2025-04-09 17:46:03', '基层急救技能题库');
INSERT INTO `sm_bank_info` VALUES (3, 1005, 11, '2024-08-19 11:00:00', '2025-04-09 15:57:05', '慢性病管理题库');
INSERT INTO `sm_bank_info` VALUES (4, 1006, 5, '2024-08-19 11:00:00', '2025-04-06 11:33:17', '传染病防控');
INSERT INTO `sm_bank_info` VALUES (1005, 1000, 9, '2025-04-09 14:58:55', '2025-04-09 18:01:58', '学前儿童卫生与保健题库');
INSERT INTO `sm_bank_info` VALUES (1006, 1002, 14, '2025-04-09 15:19:54', '2025-04-09 15:31:39', '突发公共卫生事件应急管理题库');
INSERT INTO `sm_bank_info` VALUES (1007, 1003, 11, '2025-04-09 15:38:53', '2025-04-09 15:44:12', '常见疾病诊断与处理');
INSERT INTO `sm_bank_info` VALUES (1008, 1004, 15, '2025-04-09 15:45:42', '2025-04-09 15:51:15', '基层急救技能题库');
INSERT INTO `sm_bank_info` VALUES (1009, 1007, 12, '2025-04-09 15:57:46', '2025-04-09 16:21:35', '中医适宜技术题库');
INSERT INTO `sm_bank_info` VALUES (1010, 1014, 13, '2025-04-09 16:24:15', '2025-04-09 16:46:00', '基层医疗机构感染防控实务题库');
INSERT INTO `sm_bank_info` VALUES (1011, 1015, 18, '2025-04-09 16:46:38', '2025-04-09 17:03:12', '医患沟通技巧与医疗纠纷防范题库');
INSERT INTO `sm_bank_info` VALUES (1012, 1010, 18, '2025-04-09 17:05:39', '2025-04-09 17:19:54', '卫生与健康题库');

-- ----------------------------
-- Table structure for sm_chapters
-- ----------------------------
DROP TABLE IF EXISTS `sm_chapters`;
CREATE TABLE `sm_chapters`  (
  `chapter_id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `course_id` int UNSIGNED NOT NULL,
  `chapter_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `chapter_order` int UNSIGNED NOT NULL,
  `chapter_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `time_create` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `time_modify` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `chapter_belong` int NULL DEFAULT NULL,
  PRIMARY KEY (`chapter_id`) USING BTREE,
  INDEX `course_id`(`course_id`) USING BTREE,
  CONSTRAINT `sm_chapters_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `sm_courses` (`course_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1102 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sm_chapters
-- ----------------------------
INSERT INTO `sm_chapters` VALUES (1000, 1000, '学前儿童各系统发育特点及保健措施', 1, 'https://prod-streaming-video-msn-com.akamaized.net/a8c412fa-f696-4ff2-9c76-e8ed9cdffe0f/604a87fc-e7bc-463e-8d56-cde7e661d690.mp4', '2025-03-30 08:55:58', NULL, 1);
INSERT INTO `sm_chapters` VALUES (1001, 1000, '幼儿园安全教育', 1, 'https://media.w3.org/2010/05/sintel/trailer.mp4', '2025-03-30 08:55:58', NULL, 5);
INSERT INTO `sm_chapters` VALUES (1002, 1002, '突发公共卫生事件的相关概念', 1, 'https://prod-streaming-video-msn-com.akamaized.net/b7014b7e-b38f-4a64-bd95-4a28a8ef6dee/113a2bf3-3a5f-45d4-8b6f-e40ce8559da3.mp4', '2025-03-30 08:55:58', NULL, 1);
INSERT INTO `sm_chapters` VALUES (1003, 1002, '突发公共卫生事件的应急反应机制', 3, 'https://prod-streaming-video-msn-com.akamaized.net/b7014b7e-b38f-4a64-bd95-4a28a8ef6dee/113a2bf3-3a5f-45d4-8b6f-e40ce8559da3.mp4', '2025-03-30 08:55:58', NULL, 1);
INSERT INTO `sm_chapters` VALUES (1004, 1002, '突发公共卫生事件流行病学的调查方法', 2, 'http://mirror.aarnet.edu.au/pub/TED-talks/911Mothers_2010W-480p.mp4', '2025-03-30 08:55:58', NULL, 1);
INSERT INTO `sm_chapters` VALUES (1005, 1000, '学前儿童的营养需求', 1, 'https://media.w3.org/2010/05/sintel/trailer.mp4', '2025-03-31 15:01:00', NULL, 2);
INSERT INTO `sm_chapters` VALUES (1006, 1003, '基层常见症状鉴别诊断', 1, 'https://www.w3schools.com/html/movie.mp4', '2025-03-30 13:23:00', '2025-04-09 15:41:22', 1);
INSERT INTO `sm_chapters` VALUES (1007, 1003, '心血管系统疾病 (高血压、冠心病)', 2, 'https://www.w3schools.com/html/movie.mp4', '2025-03-30 13:23:00', '2025-04-09 15:41:23', 1);
INSERT INTO `sm_chapters` VALUES (1008, 1003, '呼吸系统疾病 (肺炎、慢阻肺)', 3, 'https://www.w3schools.com/html/movie.mp4', '2025-03-30 13:23:00', '2025-04-09 15:41:24', 1);
INSERT INTO `sm_chapters` VALUES (1009, 1003, '消化系统疾病(胃炎、肝炎)', 4, 'https://www.w3schools.com/html/movie.mp4', '2025-03-30 13:23:00', '2025-04-09 15:41:25', 2);
INSERT INTO `sm_chapters` VALUES (1010, 1003, '糖尿病与代谢综合征管理', 5, 'https://www.w3schools.com/html/movie.mp4', '2025-03-30 13:23:00', '2025-04-09 15:41:26', 2);
INSERT INTO `sm_chapters` VALUES (1011, 1003, '病例分析与误诊防范', 6, 'https://www.w3schools.com/html/movie.mp4', '2025-03-30 13:23:00', '2025-04-09 15:41:27', 2);
INSERT INTO `sm_chapters` VALUES (1012, 1004, '心肺复苏（CPR）操作规范', 1, 'https://www.w3schools.com/html/movie.mp4', '2025-03-31 09:00:00', '2025-04-09 15:41:28', 1);
INSERT INTO `sm_chapters` VALUES (1013, 1004, '创伤急救(止血、包扎、固定)', 2, 'https://www.w3schools.com/html/movie.mp4', '2025-03-31 09:00:00', '2025-04-09 15:41:29', 1);
INSERT INTO `sm_chapters` VALUES (1014, 1004, '急性中毒处理 (农药、一氧化碳)', 3, 'https://www.w3schools.com/html/movie.mp4', '2025-03-31 09:00:00', '2025-04-09 15:41:30', 2);
INSERT INTO `sm_chapters` VALUES (1015, 1004, '过敏性休克与哮喘急性发作', 4, 'http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4', '2025-03-31 09:00:00', '2025-04-09 18:31:26', 2);
INSERT INTO `sm_chapters` VALUES (1016, 1004, '急救设备使用(AED、氧气瓶)', 5, 'http://vfx.mtime.cn/Video/2019/02/04/mp4/190204084208765161.mp4', '2025-03-31 09:00:00', '2025-04-09 18:31:49', 3);
INSERT INTO `sm_chapters` VALUES (1017, 1004, '模拟演练与团队协作', 6, 'https://prod-streaming-video-msn-com.akamaized.net/b7014b7e-b38f-4a64-bd95-4a28a8ef6dee/113a2bf3-3a5f-45d4-8b6f-e40ce8559da3.mp4', '2025-03-31 09:00:00', '2025-04-09 23:39:09', 3);
INSERT INTO `sm_chapters` VALUES (1018, 1005, '慢性病管理概述', 1, 'https://prod-streaming-video-msn-com.akamaized.net/b7014b7e-b38f-4a64-bd95-4a28a8ef6dee/113a2bf3-3a5f-45d4-8b6f-e40ce8559da3.mp4', '2025-04-01 10:00:00', '2025-04-09 23:39:09', 1);
INSERT INTO `sm_chapters` VALUES (1019, 1005, '高血压管理', 2, 'https://prod-streaming-video-msn-com.akamaized.net/b7014b7e-b38f-4a64-bd95-4a28a8ef6dee/113a2bf3-3a5f-45d4-8b6f-e40ce8559da3.mp4', '2025-04-01 10:00:00', '2025-04-09 23:39:08', 1);
INSERT INTO `sm_chapters` VALUES (1020, 1005, '糖尿病管理', 3, 'https://prod-streaming-video-msn-com.akamaized.net/b7014b7e-b38f-4a64-bd95-4a28a8ef6dee/113a2bf3-3a5f-45d4-8b6f-e40ce8559da3.mp4', '2025-04-01 10:00:00', '2025-04-09 23:39:11', 2);
INSERT INTO `sm_chapters` VALUES (1021, 1005, '慢性阻塞性肺疾病管理', 4, 'https://prod-streaming-video-msn-com.akamaized.net/b7014b7e-b38f-4a64-bd95-4a28a8ef6dee/113a2bf3-3a5f-45d4-8b6f-e40ce8559da3.mp4', '2025-04-01 10:00:00', '2025-04-09 23:39:12', 2);
INSERT INTO `sm_chapters` VALUES (1022, 1006, '传染病防控概述', 1, 'http://vfx.mtime.cn/Video/2019/02/04/mp4/190204084208765161.mp4', '2025-04-02 11:00:00', '2025-04-09 23:39:17', 1);
INSERT INTO `sm_chapters` VALUES (1023, 1006, '常见传染病类型', 2, 'https://prod-streaming-video-msn-com.akamaized.net/b7014b7e-b38f-4a64-bd95-4a28a8ef6dee/113a2bf3-3a5f-45d4-8b6f-e40ce8559da3.mp4', '2025-04-02 11:00:00', '2025-04-09 23:39:14', 1);
INSERT INTO `sm_chapters` VALUES (1024, 1006, '传染病防控措施', 3, 'http://vfx.mtime.cn/Video/2019/02/04/mp4/190204084208765161.mp4', '2025-04-02 11:00:00', '2025-04-09 23:39:19', 2);
INSERT INTO `sm_chapters` VALUES (1025, 1006, '疫苗接种与预防', 4, 'http://vfx.mtime.cn/Video/2019/02/04/mp4/190204084208765161.mp4', '2025-04-02 11:00:00', '2025-04-09 23:39:19', 2);
INSERT INTO `sm_chapters` VALUES (1026, 1011, '为什么要学习', 1, '为中华之崛起而读书', '2025-04-08 23:20:41', '2025-04-08 23:20:41', 1);
INSERT INTO `sm_chapters` VALUES (1027, 1011, '如何学习', 2, 'nothing', '2025-04-08 23:20:41', '2025-04-08 23:20:41', 1);
INSERT INTO `sm_chapters` VALUES (1028, 1011, '为什么要学习', 1, '为中华之崛起而读书', '2025-04-08 23:23:21', '2025-04-08 23:23:21', 1);
INSERT INTO `sm_chapters` VALUES (1029, 1011, '如何学习', 2, 'nothing', '2025-04-08 23:23:21', '2025-04-08 23:23:21', 1);
INSERT INTO `sm_chapters` VALUES (1089, 1000, '幼儿园健康教育', 2, 'te', '2025-04-09 15:41:17', NULL, 5);
INSERT INTO `sm_chapters` VALUES (1090, 1000, '学前儿童膳食管理的卫生要求', 2, 'https://prod-streaming-video-msn-com.akamaized.net/a8c412fa-f696-4ff2-9c76-e8ed9cdffe0f/604a87fc-e7bc-463e-8d56-cde7e661d690.mp4', '2025-04-09 15:49:59', NULL, 2);
INSERT INTO `sm_chapters` VALUES (1091, 1000, '幼儿园环境的清洁和常见消毒的方法', 1, 'https://prod-streaming-video-msn-com.akamaized.net/a8c412fa-f696-4ff2-9c76-e8ed9cdffe0f/604a87fc-e7bc-463e-8d56-cde7e661d690.mp4', '2025-04-09 15:56:12', NULL, 3);
INSERT INTO `sm_chapters` VALUES (1092, 1000, '学前儿童常见心理行为', 1, 'https://media.w3.org/2010/05/sintel/trailer.mp4', '2025-04-09 15:56:12', NULL, 4);
INSERT INTO `sm_chapters` VALUES (1093, 1000, '学前儿童常见心理疾患及预防', 2, 'https://prod-streaming-video-msn-com.akamaized.net/a8c412fa-f696-4ff2-9c76-e8ed9cdffe0f/604a87fc-e7bc-463e-8d56-cde7e661d690.mp4', '2025-04-09 15:56:12', NULL, 4);
INSERT INTO `sm_chapters` VALUES (1094, 1000, '学前儿童身体健康的评价', 1, 'https://media.w3.org/2010/05/sintel/trailer.mp4', '2025-04-09 15:56:12', NULL, 6);
INSERT INTO `sm_chapters` VALUES (1095, 1000, '学前儿童的安全与急救', 2, 'https://media.w3.org/2010/05/sintel/trailer.mp4', '2025-04-09 15:56:12', NULL, 3);
INSERT INTO `sm_chapters` VALUES (1102, 1002, '食物中毒及化学品中毒事件应急处理', 1, 'https://prod-streaming-video-msn-com.akamaized.net/b7014b7e-b38f-4a64-bd95-4a28a8ef6dee/113a2bf3-3a5f-45d4-8b6f-e40ce8559da3.mp4', '2025-04-09 23:23:46', '2025-04-09 23:23:46', 4);
INSERT INTO `sm_chapters` VALUES (1103, 1002, '传染病突发事件的应对措施', 2, 'https://prod-streaming-video-msn-com.akamaized.net/b7014b7e-b38f-4a64-bd95-4a28a8ef6dee/113a2bf3-3a5f-45d4-8b6f-e40ce8559da3.mp4', '2025-04-09 23:23:46', '2025-04-09 23:23:46', 3);
INSERT INTO `sm_chapters` VALUES (1104, 1002, '突发公共卫生事件的社区预防', 1, 'https://prod-streaming-video-msn-com.akamaized.net/b7014b7e-b38f-4a64-bd95-4a28a8ef6dee/113a2bf3-3a5f-45d4-8b6f-e40ce8559da3.mp4', '2025-04-09 23:23:46', '2025-04-09 23:23:46', 5);
INSERT INTO `sm_chapters` VALUES (1105, 1002, '传染病突发事件的生物学基础与表现形式', 1, 'https://prod-streaming-video-msn-com.akamaized.net/b7014b7e-b38f-4a64-bd95-4a28a8ef6dee/113a2bf3-3a5f-45d4-8b6f-e40ce8559da3.mp4', '2025-04-09 23:23:46', '2025-04-09 23:23:46', 3);
INSERT INTO `sm_chapters` VALUES (1106, 1002, '引发突发事件的主要传染病简况', 1, 'https://prod-streaming-video-msn-com.akamaized.net/b7014b7e-b38f-4a64-bd95-4a28a8ef6dee/113a2bf3-3a5f-45d4-8b6f-e40ce8559da3.mp4', '2025-04-09 23:23:46', '2025-04-09 23:23:46', 2);
INSERT INTO `sm_chapters` VALUES (1107, 1002, '引发突发事件的主要传染病简况', 1, 'https://prod-streaming-video-msn-com.akamaized.net/b7014b7e-b38f-4a64-bd95-4a28a8ef6dee/113a2bf3-3a5f-45d4-8b6f-e40ce8559da3.mp4', '2025-04-09 23:23:54', '2025-04-09 23:23:54', 2);
INSERT INTO `sm_chapters` VALUES (1108, 1002, '传染病突发事件的生物学基础与表现形式', 1, 'https://prod-streaming-video-msn-com.akamaized.net/b7014b7e-b38f-4a64-bd95-4a28a8ef6dee/113a2bf3-3a5f-45d4-8b6f-e40ce8559da3.mp4', '2025-04-09 23:23:54', '2025-04-09 23:23:54', 3);
INSERT INTO `sm_chapters` VALUES (1109, 1002, '传染病突发事件的应对措施', 2, 'https://prod-streaming-video-msn-com.akamaized.net/b7014b7e-b38f-4a64-bd95-4a28a8ef6dee/113a2bf3-3a5f-45d4-8b6f-e40ce8559da3.mp4', '2025-04-09 23:23:54', '2025-04-09 23:23:54', 3);
INSERT INTO `sm_chapters` VALUES (1110, 1002, '食物中毒及化学品中毒事件应急处理', 1, 'https://prod-streaming-video-msn-com.akamaized.net/b7014b7e-b38f-4a64-bd95-4a28a8ef6dee/113a2bf3-3a5f-45d4-8b6f-e40ce8559da3.mp4', '2025-04-09 23:23:54', '2025-04-09 23:23:54', 4);
INSERT INTO `sm_chapters` VALUES (1111, 1002, '突发公共卫生事件的社区预防', 1, 'https://prod-streaming-video-msn-com.akamaized.net/b7014b7e-b38f-4a64-bd95-4a28a8ef6dee/113a2bf3-3a5f-45d4-8b6f-e40ce8559da3.mp4', '2025-04-09 23:23:54', '2025-04-09 23:23:54', 5);
INSERT INTO `sm_chapters` VALUES (1112, 1005, '脑卒中管理', 1, 'https://prod-streaming-video-msn-com.akamaized.net/a8c412fa-f696-4ff2-9c76-e8ed9cdffe0f/604a87fc-e7bc-463e-8d56-cde7e661d690.mp4', '2025-04-09 23:29:38', '2025-04-09 23:29:38', 3);
INSERT INTO `sm_chapters` VALUES (1113, 1005, '冠心病管理', 1, 'https://prod-streaming-video-msn-com.akamaized.net/a8c412fa-f696-4ff2-9c76-e8ed9cdffe0f/604a87fc-e7bc-463e-8d56-cde7e661d690.mp4', '2025-04-09 23:29:38', '2025-04-09 23:29:38', 4);
INSERT INTO `sm_chapters` VALUES (1114, 1000, '学前儿童心理健康的评价', 2, 'https://media.w3.org/2010/05/sintel/trailer.mp4', '2025-04-10 10:02:05', '2025-04-10 10:02:05', 6);

-- ----------------------------
-- Table structure for sm_courses
-- ----------------------------
DROP TABLE IF EXISTS `sm_courses`;
CREATE TABLE `sm_courses`  (
  `course_id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `course_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `course_cover` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `course_description` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `course_type` tinyint UNSIGNED NULL DEFAULT NULL,
  `course_teacher` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `time_create` datetime NULL DEFAULT NULL,
  `time_modify` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`course_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1029 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sm_courses
-- ----------------------------
INSERT INTO `sm_courses` VALUES (1000, '学前儿童卫生与保健', 'https://ts1.tc.mm.bing.net/th/id/R-C.bfe44a1c991fa6fce79ee99f3abdb96d?rik=Ur%2fOw54HfyOtWw&riu=http%3a%2f%2fp.ananas.chaoxing.com%2fstar3%2f668_376c%2f268107f3d6e40655a43c70eb79d26f3c.jpg&ehk=olfVKe5%2fuVMiyJ2VPCFpPp2ubUweBj1bvdqBqaIovdI%3d&risl=&pid=ImgRaw&r=0', '旨在自然引出与学前儿童生长发育相适应的各项卫生要求，以便为学前儿童创设良好的卫生环境', 0, '黄一卷', '2025-04-01 15:20:06', '2025-04-10 10:10:41');
INSERT INTO `sm_courses` VALUES (1002, '突发公共卫生事件应急管理', 'https://jgdj.ecust.edu.cn/_upload/article/images/df/8a/49396b4c41ed8401d7b4b28f8b6b/9bfdd28c-f886-4f25-9332-676e8a2d69b9.jpg', '传染病突发事件应急处理、心理危机干预及突发公共卫生事件的社区预防', 1, '苏哈利', '2025-03-30 13:07:51', '2025-04-09 23:24:21');
INSERT INTO `sm_courses` VALUES (1003, '常见疾病诊断与处理', 'https://n.sinaimg.cn/sinakd20220216ac/483/w900h383/20220216/deac-eeb7cdedeade5efedc5d895c8fab6a85.jpg', '一些常见的疾病诊断方法和处理', 1, '苏哈利', '2025-03-30 13:23:00', '2025-04-04 23:48:25');
INSERT INTO `sm_courses` VALUES (1004, '基层急救技能', 'https://jjglxy.fafu.edu.cn/_upload/article/images/30/ac/574e9524447b8b241194a6b04c8d/488f5cf8-a1c0-4c41-aae5-5a0d1fb3f7aa.jpg', '介绍基层急救的基本技能和操作', 1, '李粤通', '2025-03-31 09:00:00', '2025-04-09 23:35:16');
INSERT INTO `sm_courses` VALUES (1005, '慢性病管理', 'https://img95.699pic.com/photo/60026/5460.jpg_wh860.jpg', '慢性病的管理方法和注意事项', 1, '程暗棋', '2025-04-01 10:00:00', '2025-04-09 23:33:36');
INSERT INTO `sm_courses` VALUES (1006, '传染病防控', 'https://tse4-mm.cn.bing.net/th/id/OIP-C.eW0W0IYUzI_S19XD-xqhPgHaFU?rs=1&pid=ImgDetMainhttps://img95.699pic.com/photo/60026/5460.jpg_wh860.jpg', '传染病的防控措施和预防方法', 1, '黄一卷', '2025-04-02 11:00:00', '2025-04-09 23:31:10');
INSERT INTO `sm_courses` VALUES (1007, '中医适宜技术', 'https://ts1.tc.mm.bing.net/th/id/R-C.12c291cc0350d007a5f8ae554077f28c?rik=41uC1fNphYsPgw&riu=http%3a%2f%2fwstx.web.vleader.net.cn%2f354CE3D88F0E43DCBDD17F1C58D3B9C5%2f202312021405537912.jpg&ehk=kf8Z2fA9uHMDKmuhhRpU3r07BVCdrLZmvreKjDwwWbU%3d&risl=&pid=ImgRaw&r=0', '包括艾香导引罐、推拿梅花针、刮痧耳穴贴。', 0, '刘迈兰', '2025-04-04 16:09:41', '2025-04-09 11:38:10');
INSERT INTO `sm_courses` VALUES (1008, '健康导航与科学用药', 'https://tse1-mm.cn.bing.net/th/id/OIP-C.FaTltfALFnlCOnSRS9EgfAHaFj?rs=1&pid=ImgDetMain', '掌握常见疾病的预防和治疗知识', 1, '起司君', '2025-04-04 21:41:32', '2025-04-09 11:12:29');
INSERT INTO `sm_courses` VALUES (1009, '基层常见病', 'https://tse4-mm.cn.bing.net/th/id/OIP-C.jdY60FzeiKQiXsCEceHXgQHaEK?rs=1&pid=ImgDetMain', '内外科常见的临床症状', 1, '士大夫', '2025-04-04 21:57:08', '2025-04-09 11:33:33');
INSERT INTO `sm_courses` VALUES (1010, '卫生与健康', 'https://image.zhihuishu.com/zhs/zhihuishu_creatCourse_h5/SOURCENAME/202112/0390f1dcc79c487a821f2cf7f9b8fc94_s1.jpg', '卫生的沿革及分类，卫生与健康的关系，与健康相关内容。', 0, '陈春', '2025-04-07 14:44:34', '2025-04-09 11:37:48');
INSERT INTO `sm_courses` VALUES (1011, '基本公共卫生服务项目解读与实施', 'https://pic.ntimg.cn/file/20230315/3265662_214136822108_2.jpg', '从居民健康档案建立、预防接种到妇幼保健等各个项目展开。', 1, '环氧基', '2025-04-08 21:55:38', '2025-04-09 11:40:39');
INSERT INTO `sm_courses` VALUES (1012, '基层急救技能培训', 'https://img1.dxycdn.com/2023/0221/674/1124103063266721063-183.jpg', '聚焦基层常见急危重症的现场急救处理，如心肺复苏、创伤止血包扎、骨折固定等。', 1, '水滴君', '2025-04-08 23:30:25', '2025-04-09 11:30:52');
INSERT INTO `sm_courses` VALUES (1013, '中医药适宜技术在基层的应用', 'https://tse1-mm.cn.bing.net/th/id/OIP-C.isdcoGeluqbZ7_m5hfh5xAHaFj?rs=1&pid=ImgDetMain', '介绍针灸、推拿、拔罐、艾灸等多种中医药适宜技术在基层常见疾病治疗与预防中的应用。', 0, '聂世纪', '2025-04-09 10:09:37', '2025-04-09 11:38:29');
INSERT INTO `sm_courses` VALUES (1014, '基层医疗机构感染防控实务', 'https://img.alicdn.com/i4/787562409/O1CN01nXrqNq1TfMifACrSl_!!787562409.jpg', '深入剖析基层医疗机构感染防控的关键环节，包括手卫生、消毒隔离、医疗废物管理等。', 1, '赛德娜', '2025-04-09 10:23:54', '2025-04-09 11:30:36');
INSERT INTO `sm_courses` VALUES (1015, '医患沟通技巧与医疗纠纷防范', 'https://tse2-mm.cn.bing.net/th/id/OIP-C.0yyfVCleIN_XHQu1JeWq8QHaFI?rs=1&pid=ImgDetMain', '从医患沟通的重要性出发，传授有效的沟通方法与技巧，帮助学员改善医患关系。', 1, '威化饼', '2025-04-09 10:30:55', '2025-04-09 11:30:24');

-- ----------------------------
-- Table structure for sm_courses_assess
-- ----------------------------
DROP TABLE IF EXISTS `sm_courses_assess`;
CREATE TABLE `sm_courses_assess`  (
  `course_assess_id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `course_id` int UNSIGNED NULL DEFAULT NULL,
  `course_assess_score` decimal(4, 2) NULL DEFAULT NULL,
  `course_assess_content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `user_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `time_create` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `time_modify` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`course_assess_id`) USING BTREE,
  INDEX `course_id`(`course_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `sm_courses_assess_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `sm_courses` (`course_id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `sm_courses_assess_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `sm_users` (`user_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sm_courses_assess
-- ----------------------------

-- ----------------------------
-- Table structure for sm_exams
-- ----------------------------
DROP TABLE IF EXISTS `sm_exams`;
CREATE TABLE `sm_exams`  (
  `exam_id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `exam_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL COMMENT '考试标题',
  `course_id` int UNSIGNED NOT NULL COMMENT '课程id',
  `paper_id` int UNSIGNED NOT NULL,
  `retake_allowed` int(1) UNSIGNED ZEROFILL NULL DEFAULT NULL COMMENT '允许重考次数',
  `question_disorder` int NULL DEFAULT 0 COMMENT '题目乱序',
  `option_disorder` int NULL DEFAULT 0 COMMENT '选项乱序',
  `pass_mark` int NULL DEFAULT NULL COMMENT '及格分数',
  `duration` int NULL DEFAULT NULL COMMENT '考试时长',
  `time_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `time_modify` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`exam_id`) USING BTREE,
  INDEX `course_id`(`course_id`) USING BTREE,
  INDEX `paper_id`(`paper_id`) USING BTREE,
  CONSTRAINT `sm_exams_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `sm_courses` (`course_id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `sm_exams_ibfk_2` FOREIGN KEY (`paper_id`) REFERENCES `sm_papers_info` (`paper_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 54 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sm_exams
-- ----------------------------
INSERT INTO `sm_exams` VALUES (37, '学前儿童卫生与保健期末考试', 1000, 27, 1, 0, 1, 20, 30, '2025-04-09 18:12:49', '2025-04-09 18:59:45');
INSERT INTO `sm_exams` VALUES (38, '突发公共卫生事件应急管理', 1002, 28, 0, 0, 0, 60, 60, '2025-04-09 18:13:56', '2025-04-09 18:13:56');
INSERT INTO `sm_exams` VALUES (39, '常见疾病诊断与处理', 1003, 29, 1, 0, 0, 40, 60, '2025-04-09 18:14:35', '2025-04-09 18:14:35');
INSERT INTO `sm_exams` VALUES (40, '基层急救技能期末考', 1004, 31, 2, 0, 0, 65, 80, '2025-04-09 18:15:24', '2025-04-09 18:15:24');
INSERT INTO `sm_exams` VALUES (41, '慢性病管理期中考', 1005, 32, 2, 0, 0, 70, 80, '2025-04-09 18:16:09', '2025-04-09 18:16:09');
INSERT INTO `sm_exams` VALUES (42, '传染病防控期中考', 1006, 33, 2, 0, 0, 60, 60, '2025-04-09 18:16:47', '2025-04-09 18:16:47');
INSERT INTO `sm_exams` VALUES (43, '中医适宜技术期中考', 1007, 34, 2, 0, 0, 50, 60, '2025-04-09 18:17:53', '2025-04-09 18:17:53');
INSERT INTO `sm_exams` VALUES (44, '健康导航与科学用药期中考', 1008, 35, 1, 0, 0, 10, 30, '2025-04-09 18:18:19', '2025-04-09 18:18:19');
INSERT INTO `sm_exams` VALUES (45, '基层常见病期中考', 1009, 36, 1, 0, 0, 30, 30, '2025-04-09 18:18:43', '2025-04-09 18:18:43');
INSERT INTO `sm_exams` VALUES (46, '卫生与健康期中考', 1010, 37, 1, 0, 0, 80, 60, '2025-04-09 18:19:16', '2025-04-09 18:19:16');
INSERT INTO `sm_exams` VALUES (47, '基本公共卫生服务项目解读与实施期中考', 1011, 38, 2, 0, 0, 60, 60, '2025-04-09 18:19:50', '2025-04-09 18:19:50');
INSERT INTO `sm_exams` VALUES (48, '基层急救技能培训期中考', 1012, 39, 2, 0, 0, 60, 60, '2025-04-09 18:20:09', '2025-04-09 18:20:09');
INSERT INTO `sm_exams` VALUES (49, '中医药适宜技术在基层的应用期中考', 1013, 40, 2, 0, 0, 30, 60, '2025-04-09 18:20:26', '2025-04-09 18:20:26');
INSERT INTO `sm_exams` VALUES (50, '基层医疗机构感染防控实务期中考', 1014, 41, 2, 0, 0, 40, 60, '2025-04-09 18:20:54', '2025-04-09 18:20:54');
INSERT INTO `sm_exams` VALUES (51, '医惠沟通技巧与医疗纠纷防范期中考', 1015, 42, 2, 0, 0, 85, 90, '2025-04-09 18:21:30', '2025-04-09 18:21:30');
INSERT INTO `sm_exams` VALUES (55, 'test', 1000, 46, 0, 1, 1, 20, 120, '2025-04-10 13:35:55', '2025-04-10 13:35:55');

-- ----------------------------
-- Table structure for sm_item_bank
-- ----------------------------
DROP TABLE IF EXISTS `sm_item_bank`;
CREATE TABLE `sm_item_bank`  (
  `item_id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `item_content` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL COMMENT '题目名称',
  `item_type` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL COMMENT '题目类型：0：单选、1：多选、2：判断、3：填空、4：主观',
  `item_difficulty` tinyint NOT NULL DEFAULT 2 COMMENT '题目难度',
  `item_score` float NULL DEFAULT 5 COMMENT '题目分值',
  `time_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `time_modify` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `bank_id` int UNSIGNED NULL DEFAULT NULL COMMENT '题库ID',
  PRIMARY KEY (`item_id`) USING BTREE,
  INDEX `sm_item_bank_ibfk_1`(`bank_id`) USING BTREE,
  CONSTRAINT `sm_item_bank_ibfk_1` FOREIGN KEY (`bank_id`) REFERENCES `sm_bank_info` (`bank_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1163 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sm_item_bank
-- ----------------------------
INSERT INTO `sm_item_bank` VALUES (101, '高血压的诊断标准是什么？', '0', 2, 10, '2025-04-15 09:00:00', '2025-04-06 10:53:42', 1);
INSERT INTO `sm_item_bank` VALUES (102, '以下哪些是冠心病的症状？', '1', 3, 15, '2025-06-01 10:00:00', '2025-04-06 10:53:44', 1);
INSERT INTO `sm_item_bank` VALUES (103, '慢性阻塞性肺疾病（COPD）的诊断依据是什么？', '0', 2, 10, '2025-05-15 11:00:00', '2025-04-06 10:53:45', 1);
INSERT INTO `sm_item_bank` VALUES (104, '糖尿病的诊断标准是什么？', '0', 3, 10, '2025-04-15 09:00:00', '2025-04-06 10:53:46', 1);
INSERT INTO `sm_item_bank` VALUES (105, '请判断：所有糖尿病患者都需要使用胰岛素治疗。', '2', 1, 5, '2025-06-01 10:00:00', '2025-04-06 10:53:53', 1);
INSERT INTO `sm_item_bank` VALUES (106, '心肺复苏（CPR）的正确步骤是什么？', '0', 3, 15, '2025-04-20 09:00:00', '2025-04-06 10:53:55', 2);
INSERT INTO `sm_item_bank` VALUES (107, '以下哪些是创伤急救的基本原则？', '1', 2, 10, '2025-06-05 10:00:00', '2025-04-06 10:53:55', 2);
INSERT INTO `sm_item_bank` VALUES (108, '急性中毒的处理方法有哪些？', '0', 3, 15, '2025-05-20 11:00:00', '2025-04-06 10:53:56', 2);
INSERT INTO `sm_item_bank` VALUES (109, '请判断：所有过敏性休克患者都需要使用肾上腺素。', '2', 1, 5, '2025-04-20 09:00:00', '2025-04-06 10:53:57', 2);
INSERT INTO `sm_item_bank` VALUES (110, '描述急救设备AED的使用步骤。', '4', 4, 20, '2025-06-05 10:00:00', '2025-04-06 10:53:58', 2);
INSERT INTO `sm_item_bank` VALUES (111, '高血压的管理策略有哪些？', '0', 2, 10, '2025-04-25 09:00:00', '2025-04-06 10:54:02', 3);
INSERT INTO `sm_item_bank` VALUES (112, '糖尿病的治疗目标是什么？', '0', 3, 15, '2025-06-10 10:00:00', '2025-04-06 10:54:03', 3);
INSERT INTO `sm_item_bank` VALUES (113, '慢性阻塞性肺疾病的预防措施有哪些？', '1', 2, 10, '2025-05-25 11:00:00', '2025-04-06 10:54:03', 3);
INSERT INTO `sm_item_bank` VALUES (114, '请判断：所有慢性病患者都需要定期复查。', '2', 1, 5, '2025-04-25 09:00:00', '2025-04-06 10:54:04', 3);
INSERT INTO `sm_item_bank` VALUES (115, '描述慢性病管理的重要性。', '4', 4, 20, '2025-06-10 10:00:00', '2025-04-06 10:54:05', 3);
INSERT INTO `sm_item_bank` VALUES (116, '传染病的传播途径有哪些？', '0', 2, 10, '2025-04-30 09:00:00', '2025-04-06 10:54:09', 4);
INSERT INTO `sm_item_bank` VALUES (117, '疫苗接种的重要性是什么？', '0', 3, 15, '2025-06-15 10:00:00', '2025-04-06 10:54:10', 4);
INSERT INTO `sm_item_bank` VALUES (118, '常见的传染病有哪些？', '1', 2, 10, '2025-06-01 11:00:00', '2025-04-06 10:54:11', 4);
INSERT INTO `sm_item_bank` VALUES (119, '请判断：所有传染病都可以通过疫苗预防。', '2', 1, 5, '2025-04-30 09:00:00', '2025-04-06 10:54:12', 4);
INSERT INTO `sm_item_bank` VALUES (120, '描述传染病防控的基本策略。', '4', 4, 20, '2025-06-15 10:00:00', '2025-04-06 10:54:13', 4);
INSERT INTO `sm_item_bank` VALUES (1005, '婴幼儿大脑对葡萄糖有特殊的依赖，因此，学前儿童每餐的膳食中应摄入一定量的 ( )，以满足脑组织代谢所需要的能量。', '0', 2, 5, '2025-04-09 15:01:36', '2025-04-09 15:01:36', 1005);
INSERT INTO `sm_item_bank` VALUES (1006, '侏儒症是因垂体的生长激素分泌过（ ）。', '0', 1, 5, '2025-04-09 15:02:46', '2025-04-09 15:02:46', 1005);
INSERT INTO `sm_item_bank` VALUES (1007, '关系到儿童生长发育和智力发展的内分泌腺是（ ）。', '0', 3, 5, '2025-04-09 15:03:17', '2025-04-09 15:03:17', 1005);
INSERT INTO `sm_item_bank` VALUES (1008, '简述学前儿童合理膳食的要求。', '4', 4, 5, '2025-04-09 15:07:35', '2025-04-09 15:07:35', 1005);
INSERT INTO `sm_item_bank` VALUES (1009, '生长发育评价中最重要和最常用的形态指标是（）。', '1', 4, 5, '2025-04-09 15:10:14', '2025-04-09 15:10:14', 1005);
INSERT INTO `sm_item_bank` VALUES (1010, '新生儿期具体是指从出生到1个月。', '2', 4, 5, '2025-04-09 15:10:59', '2025-04-09 15:10:59', 1005);
INSERT INTO `sm_item_bank` VALUES (1011, '给儿童测体温前要让体温计的水银线处于34°C以下。', '2', 5, 5, '2025-04-09 15:13:15', '2025-04-09 15:13:15', 1005);
INSERT INTO `sm_item_bank` VALUES (1012, '下列疾病中，不属于传染病的是（）。', '1', 5, 5, '2025-04-09 15:15:07', '2025-04-09 15:15:07', 1005);
INSERT INTO `sm_item_bank` VALUES (1013, '突发公共卫生事件是指突然发生，造成或者可能造成社会公众健康严重损害的重大传染病疫情、（ ）疾病、重大食物和职业中毒以及其他严重影响公众健康的事件。', '0', 1, 5, '2025-04-09 15:20:28', '2025-04-09 15:20:28', 1006);
INSERT INTO `sm_item_bank` VALUES (1014, '下面哪项不是我国突发公共卫生事件的分类？（ ）', '0', 1, 5, '2025-04-09 15:21:27', '2025-04-09 15:21:27', 1006);
INSERT INTO `sm_item_bank` VALUES (1015, '下列哪种情形可定为特别重大突发公共卫生事件 (Ⅰ 级)?（ ）', '0', 1, 5, '2025-04-09 15:22:06', '2025-04-09 15:22:06', 1006);
INSERT INTO `sm_item_bank` VALUES (1016, '突发公共卫生事件应急管理是在突发公共事件的发生前、发生中、发生后的各个阶段，用有效方法对其加以干预和控制，使其造成的 ( ) 。', '0', 1, 5, '2025-04-09 15:22:50', '2025-04-09 15:22:50', 1006);
INSERT INTO `sm_item_bank` VALUES (1017, '《突发公共卫生事件应急条例》出台的背景是（ ）', '0', 1, 5, '2025-04-09 15:23:16', '2025-04-09 15:23:16', 1006);
INSERT INTO `sm_item_bank` VALUES (1018, '突发公共卫生事件的特征（ ）', '1', 1, 5, '2025-04-09 15:24:02', '2025-04-09 15:24:02', 1006);
INSERT INTO `sm_item_bank` VALUES (1019, '突发公共卫生事件的分级（ ）', '1', 1, 5, '2025-04-09 15:24:30', '2025-04-09 15:24:30', 1006);
INSERT INTO `sm_item_bank` VALUES (1020, '突发公共卫生事件应急管理的关键环节？（ ）', '1', 1, 5, '2025-04-09 15:24:57', '2025-04-09 15:24:57', 1006);
INSERT INTO `sm_item_bank` VALUES (1021, '突发公共卫生事件应急管理的原则、内容？（ ）', '1', 1, 5, '2025-04-09 15:25:36', '2025-04-09 15:25:36', 1006);
INSERT INTO `sm_item_bank` VALUES (1022, '突发公共卫生事件的 “一案三制” 建设？（ ）', '1', 1, 5, '2025-04-09 15:30:19', '2025-04-09 15:30:19', 1006);
INSERT INTO `sm_item_bank` VALUES (1023, '《突发公共卫生事件应急条例》的施行为建立和完善突发公共卫生事件应急处理体系提供了全社会重要法律保障，对有效应对当前或今后可能发生的突发公共卫生事件的危害，保障公众身体健康与生命安全，维护正常的社会秩序都将发挥重要的作用。（ ）', '2', 1, 5, '2025-04-09 15:30:38', '2025-04-09 15:30:38', 1006);
INSERT INTO `sm_item_bank` VALUES (1024, '突发公共卫生的管理应遵循预防为主、常备不懈的方针，贯彻统一领导、分级负责、反应及时、措施果断、依靠科学、加强合作的原则。（ ）', '2', 3, 5, '2025-04-09 15:30:54', '2025-04-09 15:31:15', 1006);
INSERT INTO `sm_item_bank` VALUES (1025, '突发公共卫生事件发生后，县级卫生行政主管部门不得越级向国家卫健委报告。（ ）', '2', 1, 5, '2025-04-09 15:31:28', '2025-04-09 15:31:28', 1006);
INSERT INTO `sm_item_bank` VALUES (1026, '突发事件的管理遵循预防为主、预防与应急相结合的原则。（ ）', '2', 1, 5, '2025-04-09 15:31:39', '2025-04-09 15:31:39', 1006);
INSERT INTO `sm_item_bank` VALUES (1027, '下列哪种疾病咳嗽时伴有鸡鸣样回声？（ ）', '0', 2, 5, '2025-04-09 15:39:26', '2025-04-09 15:39:26', 1007);
INSERT INTO `sm_item_bank` VALUES (1028, '患者出现上腹部规律性疼痛，多在空腹时发作，进食后缓解，最可能的疾病是（ ）', '0', 2, 5, '2025-04-09 15:40:45', '2025-04-09 15:40:45', 1007);
INSERT INTO `sm_item_bank` VALUES (1029, '下列哪项是诊断糖尿病的主要依据？（ ）', '0', 3, 5, '2025-04-09 15:41:10', '2025-04-09 15:41:10', 1007);
INSERT INTO `sm_item_bank` VALUES (1030, '下列属于肺炎的常见症状的有（ ）', '1', 3, 5, '2025-04-09 15:41:51', '2025-04-09 15:41:51', 1007);
INSERT INTO `sm_item_bank` VALUES (1031, '诊断心律失常可通过以下哪些检查？（ ）', '1', 4, 5, '2025-04-09 15:42:20', '2025-04-09 15:42:20', 1007);
INSERT INTO `sm_item_bank` VALUES (1032, '心绞痛发作时，疼痛部位主要在__________。', '3', 4, 5, '2025-04-09 15:42:39', '2025-04-09 15:42:39', 1007);
INSERT INTO `sm_item_bank` VALUES (1033, '尿路感染最常见的致病菌是__________。', '3', 2, 5, '2025-04-09 15:42:55', '2025-04-09 15:42:55', 1007);
INSERT INTO `sm_item_bank` VALUES (1034, '支气管哮喘的典型临床表现是__________。', '3', 3, 5, '2025-04-09 15:43:10', '2025-04-09 15:43:10', 1007);
INSERT INTO `sm_item_bank` VALUES (1035, '高血压患者只要血压控制正常，就可以自行停药。（ ）', '2', 2, 5, '2025-04-09 15:43:33', '2025-04-09 15:43:33', 1007);
INSERT INTO `sm_item_bank` VALUES (1036, '急性阑尾炎患者早期腹痛多位于脐周或上腹部，数小时后转移并固定于右下腹。（ ）', '2', 2, 5, '2025-04-09 15:43:47', '2025-04-09 15:43:47', 1007);
INSERT INTO `sm_item_bank` VALUES (1037, '简述急性心肌梗死的诊断要点。', '4', 2, 5, '2025-04-09 15:44:12', '2025-04-09 15:44:12', 1007);
INSERT INTO `sm_item_bank` VALUES (1038, '心肺复苏时，胸外按压的部位是（ ）', '0', 2, 5, '2025-04-09 15:46:14', '2025-04-09 15:46:14', 1008);
INSERT INTO `sm_item_bank` VALUES (1039, '成人进行心肺复苏时，胸外按压的频率为（ ）', '0', 2, 5, '2025-04-09 15:46:40', '2025-04-09 15:46:40', 1008);
INSERT INTO `sm_item_bank` VALUES (1040, '海姆立克急救法主要用于抢救（ ）', '0', 2, 5, '2025-04-09 15:47:00', '2025-04-09 15:47:00', 1008);
INSERT INTO `sm_item_bank` VALUES (1041, '现场急救的基本原则包括（ ）', '1', 3, 5, '2025-04-09 15:47:45', '2025-04-09 15:47:45', 1008);
INSERT INTO `sm_item_bank` VALUES (1042, '下列属于创伤急救四大技术的是（ ）', '1', 3, 5, '2025-04-09 15:48:13', '2025-04-09 15:48:13', 1008);
INSERT INTO `sm_item_bank` VALUES (1043, '溺水患者的现场急救措施有（ ）', '1', 3, 5, '2025-04-09 15:48:36', '2025-04-09 15:48:36', 1008);
INSERT INTO `sm_item_bank` VALUES (1044, '心肺复苏的英文缩写是______。', '3', 3, 5, '2025-04-09 15:49:01', '2025-04-09 15:49:01', 1008);
INSERT INTO `sm_item_bank` VALUES (1045, '被犬咬伤后，应立即用______冲洗伤口。', '3', 3, 5, '2025-04-09 15:49:18', '2025-04-09 15:49:18', 1008);
INSERT INTO `sm_item_bank` VALUES (1046, '气道异物梗阻时，对于 1 岁以上儿童及成人，可采用______急救法进行急救。', '3', 3, 5, '2025-04-09 15:49:30', '2025-04-09 15:49:30', 1008);
INSERT INTO `sm_item_bank` VALUES (1047, '创伤出血时，按压止血应压迫伤口的______端。', '3', 4, 5, '2025-04-09 15:49:44', '2025-04-09 15:49:44', 1008);
INSERT INTO `sm_item_bank` VALUES (1048, '进行胸外按压时，按压深度越深越好。（ ）', '2', 4, 5, '2025-04-09 15:49:57', '2025-04-09 15:49:57', 1008);
INSERT INTO `sm_item_bank` VALUES (1049, '对于骨折患者，应立即进行复位。（ ）', '2', 2, 5, '2025-04-09 15:50:08', '2025-04-09 15:50:08', 1008);
INSERT INTO `sm_item_bank` VALUES (1050, '患者救上岸后，应先进行倒水，再判断呼吸心跳情况。（ ）', '2', 2, 5, '2025-04-09 15:50:30', '2025-04-09 15:50:30', 1008);
INSERT INTO `sm_item_bank` VALUES (1051, '简述心肺复苏的操作步骤。', '4', 2, 5, '2025-04-09 15:50:46', '2025-04-09 15:50:46', 1008);
INSERT INTO `sm_item_bank` VALUES (1052, '简述创伤出血的止血方法（至少列举 3 种）。', '4', 2, 5, '2025-04-09 15:51:15', '2025-04-09 15:51:15', 1008);
INSERT INTO `sm_item_bank` VALUES (1056, '以下哪种疾病属于慢性病？（  ）', '0', 2, 5, '2025-04-09 15:53:04', '2025-04-09 15:53:04', 3);
INSERT INTO `sm_item_bank` VALUES (1060, '诊断糖尿病的空腹血糖标准是（  ）', '0', 1, 5, '2025-04-09 15:54:14', '2025-04-09 15:54:14', 3);
INSERT INTO `sm_item_bank` VALUES (1061, '下列哪项不是慢性病的特点？（  ）', '0', 2, 5, '2025-04-09 15:54:53', '2025-04-09 15:54:53', 3);
INSERT INTO `sm_item_bank` VALUES (1063, '慢性病管理的内容包括（  ）', '1', 3, 5, '2025-04-09 15:55:57', '2025-04-09 15:55:57', 3);
INSERT INTO `sm_item_bank` VALUES (1064, '高血压患者应减少钠盐摄入，每人每日食盐摄入量应不超过__________克。', '3', 3, 5, '2025-04-09 15:56:29', '2025-04-09 15:56:29', 3);
INSERT INTO `sm_item_bank` VALUES (1065, '简述糖尿病患者足部护理的要点。', '4', 5, 5, '2025-04-09 15:57:05', '2025-04-09 15:57:05', 3);
INSERT INTO `sm_item_bank` VALUES (1066, '下列哪种穴位定位方法属于骨度分寸法？（  ）', '0', 3, 5, '2025-04-09 16:02:41', '2025-04-09 16:02:41', 1009);
INSERT INTO `sm_item_bank` VALUES (1067, '针刺时，针身与皮肤呈 45° 角刺入的方法称为（  ）', '0', 1, 5, '2025-04-09 16:03:20', '2025-04-09 16:03:20', 1009);
INSERT INTO `sm_item_bank` VALUES (1068, '推拿手法中，以拇指罗纹面着力，腕部放松，以肘部为支点，前臂做主动摆动的手法是（  ）', '0', 3, 5, '2025-04-09 16:17:11', '2025-04-09 16:17:11', 1009);
INSERT INTO `sm_item_bank` VALUES (1069, '以下属于中医适宜技术的有（  ）', '1', 3, 5, '2025-04-09 16:17:47', '2025-04-09 16:17:47', 1009);
INSERT INTO `sm_item_bank` VALUES (1070, '针刺的注意事项包括（  ）', '1', 3, 5, '2025-04-09 16:18:27', '2025-04-09 16:18:27', 1009);
INSERT INTO `sm_item_bank` VALUES (1071, '推拿的作用包括（  ）', '1', 3, 5, '2025-04-09 16:19:14', '2025-04-09 16:19:14', 1009);
INSERT INTO `sm_item_bank` VALUES (1072, '拔罐的作用有（  ）', '1', 3, 5, '2025-04-09 16:19:50', '2025-04-09 16:19:50', 1009);
INSERT INTO `sm_item_bank` VALUES (1073, '艾灸的功效有（  ）', '1', 3, 5, '2025-04-09 16:20:17', '2025-04-09 16:20:17', 1009);
INSERT INTO `sm_item_bank` VALUES (1074, '艾灸的主要材料是______。', '3', 3, 5, '2025-04-09 16:20:35', '2025-04-09 16:20:35', 1009);
INSERT INTO `sm_item_bank` VALUES (1075, '所有穴位都可以采用艾灸治疗。（  ）', '2', 3, 5, '2025-04-09 16:20:50', '2025-04-09 16:20:50', 1009);
INSERT INTO `sm_item_bank` VALUES (1076, '针刺时出现滞针，应强行拔针。（  ）', '2', 3, 5, '2025-04-09 16:21:11', '2025-04-09 16:21:11', 1009);
INSERT INTO `sm_item_bank` VALUES (1077, '简述针灸治疗的选穴原则。', '4', 5, 5, '2025-04-09 16:21:35', '2025-04-09 16:21:35', 1009);
INSERT INTO `sm_item_bank` VALUES (1078, '基层医疗机构中，手卫生最常用的方法是（  ）', '0', 1, 5, '2025-04-09 16:40:07', '2025-04-09 16:40:07', 1010);
INSERT INTO `sm_item_bank` VALUES (1079, '含氯消毒剂进行物体表面消毒时，一般有效氯浓度应为（  ）', '0', 1, 5, '2025-04-09 16:40:36', '2025-04-09 16:40:36', 1010);
INSERT INTO `sm_item_bank` VALUES (1080, '医疗废物分类中，使用后的一次性注射器属于（  ）', '0', 2, 5, '2025-04-09 16:41:10', '2025-04-09 16:41:10', 1010);
INSERT INTO `sm_item_bank` VALUES (1081, '基层医疗机构内，空气消毒首选的方法是（  ）', '0', 2, 5, '2025-04-09 16:41:38', '2025-04-09 16:41:38', 1010);
INSERT INTO `sm_item_bank` VALUES (1082, '下列哪种情况不需要进行终末消毒？（  ）', '0', 3, 5, '2025-04-09 16:42:13', '2025-04-09 16:42:13', 1010);
INSERT INTO `sm_item_bank` VALUES (1083, '手卫生的指征包括（  ）', '1', 3, 5, '2025-04-09 16:42:42', '2025-04-09 16:42:42', 1010);
INSERT INTO `sm_item_bank` VALUES (1084, '消毒隔离的措施包括（  ）', '1', 3, 5, '2025-04-09 16:43:11', '2025-04-09 16:43:11', 1010);
INSERT INTO `sm_item_bank` VALUES (1085, '基层医疗机构感染防控中，对医务人员的培训内容应包括（  ）', '1', 3, 5, '2025-04-09 16:44:17', '2025-04-09 16:44:17', 1010);
INSERT INTO `sm_item_bank` VALUES (1087, '自然通风能有效降低室内病原体浓度，所以不需要进行其他空气消毒措施。（  ）', '2', 3, 5, '2025-04-09 16:44:40', '2025-04-09 16:44:40', 1010);
INSERT INTO `sm_item_bank` VALUES (1088, '基层医疗机构的地面每天只需清扫，不需要消毒。（  ）', '2', 3, 5, '2025-04-09 16:44:54', '2025-04-09 16:44:54', 1010);
INSERT INTO `sm_item_bank` VALUES (1089, '简述基层医疗机构治疗室的感染防控要点。', '4', 5, 5, '2025-04-09 16:45:11', '2025-04-09 16:46:10', 1010);
INSERT INTO `sm_item_bank` VALUES (1090, '请列举三种基层医疗机构常用的消毒方法及其适用范围。', '4', 3, 5, '2025-04-09 16:45:28', '2025-04-09 16:45:28', 1010);
INSERT INTO `sm_item_bank` VALUES (1091, '简述基层医疗机构医务人员发生职业暴露后的处理措施。', '4', 5, 5, '2025-04-09 16:46:00', '2025-04-09 16:46:06', 1010);
INSERT INTO `sm_item_bank` VALUES (1092, '以下哪项不属于医患沟通的基本原则？（  ）', '0', 2, 5, '2025-04-09 16:47:43', '2025-04-09 16:47:43', 1011);
INSERT INTO `sm_item_bank` VALUES (1093, '在医患沟通中，倾听的关键是（  ）', '0', 2, 5, '2025-04-09 16:48:23', '2025-04-09 16:48:23', 1011);
INSERT INTO `sm_item_bank` VALUES (1094, '导致医疗纠纷发生的最主要原因是（  ）', '0', 3, 5, '2025-04-09 16:49:04', '2025-04-09 16:49:04', 1011);
INSERT INTO `sm_item_bank` VALUES (1095, '当患者对治疗方案提出疑问时，医生应（  ）', '0', 3, 5, '2025-04-09 16:49:46', '2025-04-09 16:49:46', 1011);
INSERT INTO `sm_item_bank` VALUES (1096, '以下哪种行为有助于防范医疗纠纷？（  ）', '0', 3, 5, '2025-04-09 16:50:28', '2025-04-09 16:50:28', 1011);
INSERT INTO `sm_item_bank` VALUES (1097, '医患沟通的技巧包括（  ）', '1', 3, 5, '2025-04-09 16:51:12', '2025-04-09 16:51:12', 1011);
INSERT INTO `sm_item_bank` VALUES (1098, '医疗纠纷发生后，医疗机构可采取的处理措施有（  ）', '1', 3, 5, '2025-04-09 16:51:42', '2025-04-09 16:51:42', 1011);
INSERT INTO `sm_item_bank` VALUES (1099, '哪些因素可能影响医患关系？（  ）', '1', 3, 5, '2025-04-09 16:52:11', '2025-04-09 16:52:11', 1011);
INSERT INTO `sm_item_bank` VALUES (1100, '医患沟通中，医生可以通过以下哪些方式表达同理心？（  ）', '1', 3, 5, '2025-04-09 16:52:46', '2025-04-09 16:52:46', 1011);
INSERT INTO `sm_item_bank` VALUES (1101, '医生在与患者沟通时，应避免使用医学______，尽量使用通俗易懂的语言。', '3', 3, 5, '2025-04-09 16:53:08', '2025-04-09 16:53:08', 1011);
INSERT INTO `sm_item_bank` VALUES (1102, '______是防范医疗纠纷的第一道防线。', '3', 3, 5, '2025-04-09 16:53:26', '2025-04-09 16:53:26', 1011);
INSERT INTO `sm_item_bank` VALUES (1103, '医疗纠纷的处理途径主要有协商、______和诉讼。', '3', 3, 5, '2025-04-09 16:53:40', '2025-04-09 16:53:40', 1011);
INSERT INTO `sm_item_bank` VALUES (1104, '医患沟通中，信息的发出者和接收者都是______，沟通是双向的过程。', '3', 4, 5, '2025-04-09 16:53:57', '2025-04-09 16:53:57', 1011);
INSERT INTO `sm_item_bank` VALUES (1105, '良好的医患沟通能够增强患者对医生的______，提高治疗依从性。', '3', 3, 5, '2025-04-09 16:54:48', '2025-04-09 16:54:48', 1011);
INSERT INTO `sm_item_bank` VALUES (1106, '简述医患沟通中语言沟通的注意事项。', '4', 5, 5, '2025-04-09 17:02:15', '2025-04-09 17:02:15', 1011);
INSERT INTO `sm_item_bank` VALUES (1107, '当医疗纠纷发生后，医生应如何应对？', '4', 5, 5, '2025-04-09 17:02:29', '2025-04-09 17:02:29', 1011);
INSERT INTO `sm_item_bank` VALUES (1108, '请列举两种医疗纠纷的防范策略。', '4', 5, 5, '2025-04-09 17:02:44', '2025-04-09 17:02:44', 1011);
INSERT INTO `sm_item_bank` VALUES (1109, '规范的病历书写对防范医疗纠纷有重要作用。（  ）', '2', 2, 5, '2025-04-09 17:03:12', '2025-04-09 17:03:12', 1011);
INSERT INTO `sm_item_bank` VALUES (1110, '下列哪种行为有助于预防呼吸道传染病？（  ）', '0', 2, 5, '2025-04-09 17:06:45', '2025-04-09 17:06:45', 1012);
INSERT INTO `sm_item_bank` VALUES (1111, '健康的生活方式不包括以下哪一项？（  ）', '0', 2, 5, '2025-04-09 17:07:10', '2025-04-09 17:07:10', 1012);
INSERT INTO `sm_item_bank` VALUES (1112, '儿童预防接种的主要目的是（  ）', '0', 2, 5, '2025-04-09 17:07:36', '2025-04-09 17:07:36', 1012);
INSERT INTO `sm_item_bank` VALUES (1113, '预防食物中毒的措施包括（  ）', '1', 3, 5, '2025-04-09 17:08:00', '2025-04-09 17:08:00', 1012);
INSERT INTO `sm_item_bank` VALUES (1114, '运动对健康的益处有（  ）', '1', 3, 5, '2025-04-09 17:08:38', '2025-04-09 17:08:38', 1012);
INSERT INTO `sm_item_bank` VALUES (1115, '合理饮食的原则有（  ）', '1', 3, 5, '2025-04-09 17:09:50', '2025-04-09 17:09:50', 1012);
INSERT INTO `sm_item_bank` VALUES (1116, '下列属于心理健康标准的有（  ）', '1', 3, 5, '2025-04-09 17:16:21', '2025-04-09 17:16:21', 1012);
INSERT INTO `sm_item_bank` VALUES (1117, '预防近视应做到 “三个一”，即眼睛与书本距离约______、胸前与桌沿距离约一拳、握笔的手指与笔尖距离约一寸。', '3', 2, 5, '2025-04-09 17:16:53', '2025-04-09 17:16:53', 1012);
INSERT INTO `sm_item_bank` VALUES (1118, '成年人每天应保证______小时的睡眠时间。', '3', 2, 5, '2025-04-09 17:17:17', '2025-04-09 17:17:17', 1012);
INSERT INTO `sm_item_bank` VALUES (1119, '传染病流行的三个基本环节是传染源、传播途径和______。', '3', 3, 5, '2025-04-09 17:18:17', '2025-04-09 17:18:17', 1012);
INSERT INTO `sm_item_bank` VALUES (1120, '只要吃保健品，就可以不用注意饮食健康。（  ）', '2', 3, 5, '2025-04-09 17:18:44', '2025-04-09 17:18:44', 1012);
INSERT INTO `sm_item_bank` VALUES (1121, '坚持体育锻炼可以降低患心血管疾病的风险。（  ）', '2', 3, 5, '2025-04-09 17:18:54', '2025-04-09 17:18:54', 1012);
INSERT INTO `sm_item_bank` VALUES (1122, '吸烟只对吸烟者本人健康有害，对他人没有影响。（  ）', '2', 3, 5, '2025-04-09 17:19:02', '2025-04-09 17:19:02', 1012);
INSERT INTO `sm_item_bank` VALUES (1123, '心理健康问题不需要治疗，自己调节就可以。（  ）', '2', 3, 5, '2025-04-09 17:19:16', '2025-04-09 17:19:16', 1012);
INSERT INTO `sm_item_bank` VALUES (1124, '经常开窗通风不能预防传染病。（  ）', '2', 3, 5, '2025-04-09 17:19:23', '2025-04-09 17:19:23', 1012);
INSERT INTO `sm_item_bank` VALUES (1125, '简述预防传染病的主要措施。', '4', 5, 5, '2025-04-09 17:19:35', '2025-04-09 17:19:35', 1012);
INSERT INTO `sm_item_bank` VALUES (1126, '简述合理饮食对健康的重要性。', '4', 5, 5, '2025-04-09 17:19:45', '2025-04-09 17:19:45', 1012);
INSERT INTO `sm_item_bank` VALUES (1127, '请列举三种健康的减压方式。', '4', 5, 5, '2025-04-09 17:19:54', '2025-04-09 17:19:54', 1012);
INSERT INTO `sm_item_bank` VALUES (1128, '患者出现转移性右下腹痛，最可能患的疾病是（  ）', '0', 3, 5, '2025-04-09 17:28:11', '2025-04-09 17:28:11', 1);
INSERT INTO `sm_item_bank` VALUES (1129, '女性患者，月经周期紊乱，经量增多，妇科检查子宫增大，质硬，表面不规则，最可能的疾病是（  ）', '0', 4, 5, '2025-04-09 17:28:45', '2025-04-09 17:28:45', 1);
INSERT INTO `sm_item_bank` VALUES (1130, '小儿肺炎的治疗原则包括（  ）', '1', 4, 5, '2025-04-09 17:29:25', '2025-04-09 17:29:25', 1);
INSERT INTO `sm_item_bank` VALUES (1131, '下列哪些情况提示可能患有胃溃疡？（  ）', '1', 3, 5, '2025-04-09 17:29:56', '2025-04-09 17:29:56', 1);
INSERT INTO `sm_item_bank` VALUES (1132, '以下关于急性心肌梗死的描述，正确的有（  ）', '1', 3, 5, '2025-04-09 17:30:26', '2025-04-09 17:30:26', 1);
INSERT INTO `sm_item_bank` VALUES (1133, '诊断急性阑尾炎时，若患者出现______试验阳性，提示阑尾位置较深。', '3', 3, 5, '2025-04-09 17:30:47', '2025-04-09 17:30:47', 1);
INSERT INTO `sm_item_bank` VALUES (1134, '愈合过程一般分为______期、原始骨痂形成期和骨痂改造塑形期。', '3', 3, 5, '2025-04-09 17:31:02', '2025-04-09 17:31:02', 1);
INSERT INTO `sm_item_bank` VALUES (1135, '诊断急性胰腺炎时，血清淀粉酶在发病后______小时开始升高，______小时达到高峰。', '3', 3, 5, '2025-04-09 17:31:13', '2025-04-09 17:31:13', 1);
INSERT INTO `sm_item_bank` VALUES (1137, '滴虫性阴道炎的典型白带特点是______。', '3', 3, 5, '2025-04-09 17:32:38', '2025-04-09 17:32:38', 1);
INSERT INTO `sm_item_bank` VALUES (1138, '所有头痛患者都需要进行头颅 CT 检查以明确诊断。（  ）', '2', 2, 5, '2025-04-09 17:32:52', '2025-04-09 17:32:52', 1);
INSERT INTO `sm_item_bank` VALUES (1139, '胃溃疡患者一定伴有幽门螺杆菌感染。', '2', 2, 5, '2025-04-09 17:33:37', '2025-04-09 17:33:37', 1);
INSERT INTO `sm_item_bank` VALUES (1140, '简述急性心肌梗死的急救处理措施。', '4', 5, 5, '2025-04-09 17:33:53', '2025-04-09 17:33:59', 1);
INSERT INTO `sm_item_bank` VALUES (1141, '请列举三种常见的降压药物类型及其代表药物。', '4', 4, 5, '2025-04-09 17:34:24', '2025-04-09 17:34:24', 1);
INSERT INTO `sm_item_bank` VALUES (1142, '简述小儿高热惊厥的处理方法。', '4', 5, 5, '2025-04-09 17:34:37', '2025-04-09 17:34:37', 1);
INSERT INTO `sm_item_bank` VALUES (1143, '判断心脏骤停最迅速、有效的指标是（  ）', '0', 1, 5, '2025-04-09 17:36:54', '2025-04-09 17:36:54', 2);
INSERT INTO `sm_item_bank` VALUES (1144, '进行胸外心脏按压时，按压的部位是（  ）', '0', 1, 5, '2025-04-09 17:37:22', '2025-04-09 17:37:22', 2);
INSERT INTO `sm_item_bank` VALUES (1145, '现场处理开放性骨折时，下列做法正确的是（  ）', '0', 2, 5, '2025-04-09 17:40:04', '2025-04-09 17:40:04', 2);
INSERT INTO `sm_item_bank` VALUES (1146, '患者发生气道异物梗阻，海姆立克急救法的操作部位在（  ）', '0', 2, 5, '2025-04-09 17:40:30', '2025-04-09 17:40:30', 2);
INSERT INTO `sm_item_bank` VALUES (1147, '心肺复苏的有效指标包括（  ）', '1', 3, 5, '2025-04-09 17:41:22', '2025-04-09 17:41:22', 2);
INSERT INTO `sm_item_bank` VALUES (1148, '处理烧伤患者时，以下做法正确的有（  ）', '1', 2, 5, '2025-04-09 17:41:59', '2025-04-09 17:41:59', 2);
INSERT INTO `sm_item_bank` VALUES (1149, '现场急救时，判断患者有无呼吸的方法有（  ）', '1', 2, 5, '2025-04-09 17:42:32', '2025-04-09 17:42:32', 2);
INSERT INTO `sm_item_bank` VALUES (1150, '下列哪些情况需要进行紧急止血处理？（  ）', '1', 2, 5, '2025-04-09 17:43:11', '2025-04-09 17:43:11', 2);
INSERT INTO `sm_item_bank` VALUES (1151, '心肺复苏的顺序为胸外按压、______、人工呼吸。', '3', 2, 5, '2025-04-09 17:43:35', '2025-04-09 17:43:35', 2);
INSERT INTO `sm_item_bank` VALUES (1152, '创伤止血的方法有指压止血法、______、止血带止血法等。', '3', 2, 5, '2025-04-09 17:43:47', '2025-04-09 17:43:47', 2);
INSERT INTO `sm_item_bank` VALUES (1153, '骨折固定的目的是避免骨折断端移动，减少______，便于搬运。', '3', 2, 5, '2025-04-09 17:44:01', '2025-04-09 17:44:01', 2);
INSERT INTO `sm_item_bank` VALUES (1154, '对于中暑患者，应将其转移至______、通风良好的地方。', '3', 2, 5, '2025-04-09 17:44:10', '2025-04-09 17:44:10', 2);
INSERT INTO `sm_item_bank` VALUES (1155, '触电急救的首要措施是______。', '3', 3, 5, '2025-04-09 17:44:19', '2025-04-09 17:44:19', 2);
INSERT INTO `sm_item_bank` VALUES (1156, '进行人工呼吸时，每次吹气时间应持续 2 秒以上。（  ）', '2', 3, 5, '2025-04-09 17:44:34', '2025-04-09 17:44:34', 2);
INSERT INTO `sm_item_bank` VALUES (1157, '创伤伤口有异物刺入时，应立即将异物拔出。（  ）', '2', 2, 5, '2025-04-09 17:44:45', '2025-04-09 17:44:45', 2);
INSERT INTO `sm_item_bank` VALUES (1158, '患者发生呕吐时，应将其头偏向一侧，防止呕吐物误吸。（  ）', '2', 2, 5, '2025-04-09 17:44:52', '2025-04-09 17:44:52', 2);
INSERT INTO `sm_item_bank` VALUES (1159, '简述海姆立克急救法救治成人气道异物梗阻的操作方法。', '4', 4, 5, '2025-04-09 17:45:07', '2025-04-09 17:45:07', 2);
INSERT INTO `sm_item_bank` VALUES (1160, '简述心肺复苏过程中胸外按压的注意事项。', '4', 5, 5, '2025-04-09 17:45:29', '2025-04-09 17:45:29', 2);
INSERT INTO `sm_item_bank` VALUES (1161, '请列举三种常见的创伤止血方法及其适用情况。', '4', 5, 5, '2025-04-09 17:45:49', '2025-04-09 17:45:49', 2);
INSERT INTO `sm_item_bank` VALUES (1162, '小孩眼睛在（ ）岁以前可以有生理性远视。', '3', 1, 5, '2025-04-09 18:01:58', '2025-04-09 18:01:58', 1005);
INSERT INTO `sm_item_bank` VALUES (1163, '测试题目', '0', 1, 5, '2025-04-09 22:37:04', '2025-04-09 22:37:04', 1);
INSERT INTO `sm_item_bank` VALUES (1167, 'test', '0', 1, 5, '2025-04-10 15:51:04', '2025-04-10 15:51:04', 1);

-- ----------------------------
-- Table structure for sm_item_options
-- ----------------------------
DROP TABLE IF EXISTS `sm_item_options`;
CREATE TABLE `sm_item_options`  (
  `option_id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `option_content` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL COMMENT '选项内容\r\n选择性题目：为选项\r\n填空题/客观题：null\r\n文件题：为文件类型\r\n代码题：为语言类型\r\n',
  `option_answer` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL COMMENT '选项答案：\r\n选择性题目：非null就是正确答案\r\n填空题/客观题：为正确答案\r\n文件题：为文件答案\r\n代码题：为代码执行结果',
  `item_id` int UNSIGNED NOT NULL COMMENT '题目id',
  `time_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `time_modify` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`option_id`) USING BTREE,
  INDEX `sm_item_options_ibfk_1`(`item_id`) USING BTREE,
  CONSTRAINT `sm_item_options_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `sm_item_bank` (`item_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3669 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci COMMENT = '题目选择表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sm_item_options
-- ----------------------------
INSERT INTO `sm_item_options` VALUES (3152, '收缩压≥140mmHg和/或舒张压≥90mmHg', '1', 101, '2025-04-10 11:01:55', '2025-04-10 11:01:55');
INSERT INTO `sm_item_options` VALUES (3153, '收缩压<140mmHg和舒张压<90mmHg', NULL, 101, '2025-04-10 11:01:55', '2025-04-10 11:01:55');
INSERT INTO `sm_item_options` VALUES (3154, '收缩压≥160mmHg和/或舒张压≥100mmHg', NULL, 101, '2025-04-10 11:01:55', '2025-04-10 11:01:55');
INSERT INTO `sm_item_options` VALUES (3155, '胸痛、胸闷', '1', 102, '2025-06-01 10:00:00', '2025-06-01 10:00:00');
INSERT INTO `sm_item_options` VALUES (3156, '咳嗽、咳痰', NULL, 102, '2025-06-01 10:00:00', '2025-06-01 10:00:00');
INSERT INTO `sm_item_options` VALUES (3157, '发热、寒战', NULL, 102, '2025-06-01 10:00:00', '2025-06-01 10:00:00');
INSERT INTO `sm_item_options` VALUES (3158, '正确', '1', 105, '2025-06-01 10:00:00', '2025-06-01 10:00:00');
INSERT INTO `sm_item_options` VALUES (3159, '错误', NULL, 105, '2025-06-01 10:00:00', '2025-06-01 10:00:00');
INSERT INTO `sm_item_options` VALUES (3160, '首先检查患者意识', '1', 106, '2025-04-20 09:00:00', '2025-04-20 09:00:00');
INSERT INTO `sm_item_options` VALUES (3161, '立即进行心肺复苏', NULL, 106, '2025-04-20 09:00:00', '2025-04-20 09:00:00');
INSERT INTO `sm_item_options` VALUES (3162, '呼叫急救电话', NULL, 106, '2025-04-20 09:00:00', '2025-04-20 09:00:00');
INSERT INTO `sm_item_options` VALUES (3163, '止血、包扎、固定', '1', 107, '2025-06-05 10:00:00', '2025-06-05 10:00:00');
INSERT INTO `sm_item_options` VALUES (3164, '观察、等待', NULL, 107, '2025-06-05 10:00:00', '2025-06-05 10:00:00');
INSERT INTO `sm_item_options` VALUES (3165, '正确', '1', 109, '2025-04-20 09:00:00', '2025-04-20 09:00:00');
INSERT INTO `sm_item_options` VALUES (3166, '错误', NULL, 109, '2025-04-20 09:00:00', '2025-04-20 09:00:00');
INSERT INTO `sm_item_options` VALUES (3167, '生活方式干预', '1', 111, '2025-04-25 09:00:00', '2025-04-25 09:00:00');
INSERT INTO `sm_item_options` VALUES (3168, '药物治疗', '1', 111, '2025-04-25 09:00:00', '2025-04-25 09:00:00');
INSERT INTO `sm_item_options` VALUES (3169, '手术治疗', NULL, 111, '2025-04-25 09:00:00', '2025-04-25 09:00:00');
INSERT INTO `sm_item_options` VALUES (3170, '正确', '1', 114, '2025-04-25 09:00:00', '2025-04-05 11:01:07');
INSERT INTO `sm_item_options` VALUES (3171, '错误', NULL, 114, '2025-04-25 09:00:00', '2025-04-05 11:01:15');
INSERT INTO `sm_item_options` VALUES (3172, '空气传播', '1', 116, '2025-04-30 09:00:00', '2025-04-30 09:00:00');
INSERT INTO `sm_item_options` VALUES (3173, '食物传播', NULL, 116, '2025-04-30 09:00:00', '2025-04-30 09:00:00');
INSERT INTO `sm_item_options` VALUES (3174, '接触传播', '1', 116, '2025-04-30 09:00:00', '2025-04-30 09:00:00');
INSERT INTO `sm_item_options` VALUES (3175, '正确', '1', 119, '2025-04-30 09:00:00', '2025-04-30 09:00:00');
INSERT INTO `sm_item_options` VALUES (3176, '错误', NULL, 119, '2025-04-30 09:00:00', '2025-04-30 09:00:00');
INSERT INTO `sm_item_options` VALUES (3177, '吸烟史', '1', 103, '2025-04-25 09:00:00', '2025-04-25 09:00:00');
INSERT INTO `sm_item_options` VALUES (3178, '家族史', NULL, 103, '2025-04-25 09:00:00', '2025-04-25 09:00:00');
INSERT INTO `sm_item_options` VALUES (3179, '肺功能检查', '1', 103, '2025-04-25 09:00:00', '2025-04-25 09:00:00');
INSERT INTO `sm_item_options` VALUES (3180, '胸部X光', NULL, 103, '2025-04-25 09:00:00', '2025-04-25 09:00:00');
INSERT INTO `sm_item_options` VALUES (3181, '空腹血糖≥7.0mmol/L', NULL, 104, '2025-04-25 09:00:00', '2025-04-25 09:00:00');
INSERT INTO `sm_item_options` VALUES (3182, '随机血糖≥11.1mmol/L', NULL, 104, '2025-04-30 09:00:00', '2025-04-30 09:00:00');
INSERT INTO `sm_item_options` VALUES (3183, '糖化血红蛋白≥6.5%', NULL, 104, '2025-04-30 09:00:00', '2025-04-30 09:00:00');
INSERT INTO `sm_item_options` VALUES (3184, '以上都是', '1', 104, '2025-04-30 09:00:00', '2025-04-30 09:00:00');
INSERT INTO `sm_item_options` VALUES (3185, '立即停止接触毒物', '1', 108, '2025-06-05 10:00:00', '2025-06-05 10:00:00');
INSERT INTO `sm_item_options` VALUES (3186, '尽快就医', '1', 108, '2025-06-05 10:00:00', '2025-06-05 10:00:00');
INSERT INTO `sm_item_options` VALUES (3187, '自行服用解毒剂', NULL, 108, '2025-06-05 10:00:00', '2025-06-05 10:00:00');
INSERT INTO `sm_item_options` VALUES (3188, '观察等待', NULL, 108, '2025-06-05 10:00:00', '2025-06-05 10:00:00');
INSERT INTO `sm_item_options` VALUES (3189, NULL, '打开电源', 110, '2025-06-05 10:00:00', '2025-06-05 10:00:00');
INSERT INTO `sm_item_options` VALUES (3190, NULL, '贴上电极片', 110, '2025-06-05 10:00:00', '2025-06-05 10:00:00');
INSERT INTO `sm_item_options` VALUES (3191, NULL, '分析心率', 110, '2025-06-05 10:00:00', '2025-06-05 10:00:00');
INSERT INTO `sm_item_options` VALUES (3192, NULL, '电击', 110, '2025-06-05 10:00:00', '2025-06-05 10:00:00');
INSERT INTO `sm_item_options` VALUES (3193, '心慌、气短', '1', 102, '2025-06-04 10:00:00', '2024-06-04 11:00:00');
INSERT INTO `sm_item_options` VALUES (3194, '保持体温稳定', '1', 107, '2025-06-04 10:00:00', '2024-06-04 11:00:00');
INSERT INTO `sm_item_options` VALUES (3195, '控制血糖水平', NULL, 112, '2025-04-25 09:00:00', '2025-04-25 09:00:00');
INSERT INTO `sm_item_options` VALUES (3196, '预防并发症', NULL, 112, '2025-04-30 09:00:00', '2025-04-30 09:00:00');
INSERT INTO `sm_item_options` VALUES (3197, '提高生活质量', NULL, 112, '2025-04-30 09:00:00', '2025-04-30 09:00:00');
INSERT INTO `sm_item_options` VALUES (3198, '以上都是', '1', 112, '2025-04-30 09:00:00', '2025-04-30 09:00:00');
INSERT INTO `sm_item_options` VALUES (3199, '戒烟', '1', 113, '2025-06-05 10:00:00', '2025-06-05 10:00:00');
INSERT INTO `sm_item_options` VALUES (3200, '勤洗手、漱口', '1', 113, '2025-06-05 10:00:00', '2025-06-05 10:00:00');
INSERT INTO `sm_item_options` VALUES (3201, '利用吸烟麻痹', NULL, 113, '2025-06-05 10:00:00', '2025-06-05 10:00:00');
INSERT INTO `sm_item_options` VALUES (3202, '吸入二手烟', NULL, 113, '2025-06-05 10:00:00', '2025-06-05 10:00:00');
INSERT INTO `sm_item_options` VALUES (3203, NULL, '早期干预，预防并发症;个性化治疗，提高疗效;增强患者自我管理能力;减轻负担;提高全球健康水平', 115, '2025-04-25 09:00:00', '2025-04-25 09:00:00');
INSERT INTO `sm_item_options` VALUES (3204, '避免生病', '0', 117, '2025-04-25 09:00:00', '2025-04-25 09:00:00');
INSERT INTO `sm_item_options` VALUES (3205, '保护个体免受传染病侵害', '1', 117, '2025-04-25 09:00:00', '2025-04-25 09:00:00');
INSERT INTO `sm_item_options` VALUES (3206, '增强体质', '0', 117, '2025-04-25 09:00:00', '2025-04-25 09:00:00');
INSERT INTO `sm_item_options` VALUES (3207, '减少疼痛', '0', 117, '2025-04-25 09:00:00', '2025-04-25 09:00:00');
INSERT INTO `sm_item_options` VALUES (3208, '新冠肺炎', '1', 118, '2025-04-25 09:00:00', '2025-04-25 09:00:00');
INSERT INTO `sm_item_options` VALUES (3209, '伤寒', '1', 118, '2025-04-25 09:00:00', '2025-04-25 09:00:00');
INSERT INTO `sm_item_options` VALUES (3210, '艾滋病', '1', 118, '2025-04-25 09:00:00', '2025-04-25 09:00:00');
INSERT INTO `sm_item_options` VALUES (3211, '霍乱', '1', 118, '2025-04-25 09:00:00', '2025-04-25 09:00:00');
INSERT INTO `sm_item_options` VALUES (3212, NULL, '科学佩戴口罩，积极接种疫苗，保持良好的个人卫生习惯', 120, '2025-04-25 09:00:00', '2025-04-25 09:00:00');
INSERT INTO `sm_item_options` VALUES (3227, '碳水化合物', '1', 1005, '2025-04-09 15:01:36', '2025-04-09 15:01:36');
INSERT INTO `sm_item_options` VALUES (3228, '蛋白质', NULL, 1005, '2025-04-09 15:01:36', '2025-04-09 15:01:36');
INSERT INTO `sm_item_options` VALUES (3229, '脂肪', NULL, 1005, '2025-04-09 15:01:36', '2025-04-09 15:01:36');
INSERT INTO `sm_item_options` VALUES (3230, '维生素', NULL, 1005, '2025-04-09 15:01:36', '2025-04-09 15:01:36');
INSERT INTO `sm_item_options` VALUES (3231, '多', NULL, 1006, '2025-04-09 15:02:46', '2025-04-09 15:02:46');
INSERT INTO `sm_item_options` VALUES (3232, '少', '1', 1006, '2025-04-09 15:02:47', '2025-04-09 15:02:47');
INSERT INTO `sm_item_options` VALUES (3233, '快', NULL, 1006, '2025-04-09 15:02:47', '2025-04-09 15:02:47');
INSERT INTO `sm_item_options` VALUES (3234, '慢', NULL, 1006, '2025-04-09 15:02:47', '2025-04-09 15:02:47');
INSERT INTO `sm_item_options` VALUES (3235, '脑下垂体', NULL, 1007, '2025-04-09 15:03:17', '2025-04-09 15:03:17');
INSERT INTO `sm_item_options` VALUES (3236, '肾上腺', NULL, 1007, '2025-04-09 15:03:17', '2025-04-09 15:03:17');
INSERT INTO `sm_item_options` VALUES (3237, '甲状旁腺', NULL, 1007, '2025-04-09 15:03:17', '2025-04-09 15:03:17');
INSERT INTO `sm_item_options` VALUES (3238, '甲状腺', '1', 1007, '2025-04-09 15:03:17', '2025-04-09 15:03:17');
INSERT INTO `sm_item_options` VALUES (3239, '膳食搭配合理，比例适当，营养均衡；提供充足的热量和优质蛋白质；食物的色香味形俱全且少糖、少盐、不腻；一日多餐，定时定量；科学合理地选择零食。', '1', 1008, '2025-04-09 15:07:35', '2025-04-09 15:07:35');
INSERT INTO `sm_item_options` VALUES (3240, '身高', '1', 1009, '2025-04-09 15:10:14', '2025-04-09 15:10:14');
INSERT INTO `sm_item_options` VALUES (3241, '体重', '1', 1009, '2025-04-09 15:10:14', '2025-04-09 15:10:14');
INSERT INTO `sm_item_options` VALUES (3242, '头围', NULL, 1009, '2025-04-09 15:10:14', '2025-04-09 15:10:14');
INSERT INTO `sm_item_options` VALUES (3243, '胸围', NULL, 1009, '2025-04-09 15:10:14', '2025-04-09 15:10:14');
INSERT INTO `sm_item_options` VALUES (3244, '正确', '1', 1010, '2025-04-09 15:10:59', '2025-04-09 15:10:59');
INSERT INTO `sm_item_options` VALUES (3245, '错误', NULL, 1010, '2025-04-09 15:10:59', '2025-04-09 15:10:59');
INSERT INTO `sm_item_options` VALUES (3246, '正确', NULL, 1011, '2025-04-09 15:13:16', '2025-04-09 15:13:16');
INSERT INTO `sm_item_options` VALUES (3247, '错误', '1', 1011, '2025-04-09 15:13:16', '2025-04-09 15:13:16');
INSERT INTO `sm_item_options` VALUES (3248, '儿童湿疹', '1', 1012, '2025-04-09 15:15:07', '2025-04-09 15:15:07');
INSERT INTO `sm_item_options` VALUES (3249, '痱子', '1', 1012, '2025-04-09 15:15:07', '2025-04-09 15:15:07');
INSERT INTO `sm_item_options` VALUES (3250, '细菌性痢疾', NULL, 1012, '2025-04-09 15:15:07', '2025-04-09 15:15:07');
INSERT INTO `sm_item_options` VALUES (3251, '龋齿', '1', 1012, '2025-04-09 15:15:07', '2025-04-09 15:15:07');
INSERT INTO `sm_item_options` VALUES (3252, '个体性原因明确', NULL, 1013, '2025-04-09 15:20:28', '2025-04-09 15:20:28');
INSERT INTO `sm_item_options` VALUES (3253, '群体性可以预测', NULL, 1013, '2025-04-09 15:20:28', '2025-04-09 15:20:28');
INSERT INTO `sm_item_options` VALUES (3254, '群体性不明原因', '1', 1013, '2025-04-09 15:20:28', '2025-04-09 15:20:28');
INSERT INTO `sm_item_options` VALUES (3255, '个体性不明原因', NULL, 1013, '2025-04-09 15:20:28', '2025-04-09 15:20:28');
INSERT INTO `sm_item_options` VALUES (3256, '自然灾害', NULL, 1014, '2025-04-09 15:21:27', '2025-04-09 15:21:27');
INSERT INTO `sm_item_options` VALUES (3257, '事故灾难', NULL, 1014, '2025-04-09 15:21:27', '2025-04-09 15:21:27');
INSERT INTO `sm_item_options` VALUES (3258, '公共卫生事件', NULL, 1014, '2025-04-09 15:21:27', '2025-04-09 15:21:27');
INSERT INTO `sm_item_options` VALUES (3259, '社会安全事件', NULL, 1014, '2025-04-09 15:21:27', '2025-04-09 15:21:27');
INSERT INTO `sm_item_options` VALUES (3260, '危机', '1', 1014, '2025-04-09 15:21:27', '2025-04-09 15:21:27');
INSERT INTO `sm_item_options` VALUES (3261, '发生烈性传染病病原体（菌、毒）株、毒素丢失事件', '1', 1015, '2025-04-09 15:22:06', '2025-04-09 15:22:06');
INSERT INTO `sm_item_options` VALUES (3262, '5 天发生肝炎 20 例', NULL, 1015, '2025-04-09 15:22:06', '2025-04-09 15:22:06');
INSERT INTO `sm_item_options` VALUES (3263, '发现出血热 2 例', NULL, 1015, '2025-04-09 15:22:06', '2025-04-09 15:22:06');
INSERT INTO `sm_item_options` VALUES (3264, '社会安全事件', NULL, 1015, '2025-04-09 15:22:06', '2025-04-09 15:22:06');
INSERT INTO `sm_item_options` VALUES (3265, '无损失', NULL, 1016, '2025-04-09 15:22:50', '2025-04-09 15:22:50');
INSERT INTO `sm_item_options` VALUES (3266, '损失减至最小', '1', 1016, '2025-04-09 15:22:50', '2025-04-09 15:22:50');
INSERT INTO `sm_item_options` VALUES (3267, '损失最大', NULL, 1016, '2025-04-09 15:22:50', '2025-04-09 15:22:50');
INSERT INTO `sm_item_options` VALUES (3268, ' 损失逐步增大', NULL, 1016, '2025-04-09 15:22:50', '2025-04-09 15:22:50');
INSERT INTO `sm_item_options` VALUES (3269, ' 2003 年非典', '1', 1017, '2025-04-09 15:23:17', '2025-04-09 15:23:17');
INSERT INTO `sm_item_options` VALUES (3270, '2020 年新冠病毒肺炎', NULL, 1017, '2025-04-09 15:23:17', '2025-04-09 15:23:17');
INSERT INTO `sm_item_options` VALUES (3271, '2020 年新冠病毒肺炎', NULL, 1017, '2025-04-09 15:23:17', '2025-04-09 15:23:17');
INSERT INTO `sm_item_options` VALUES (3272, '突发性', '1', 1018, '2025-04-09 15:24:03', '2025-04-09 15:24:03');
INSERT INTO `sm_item_options` VALUES (3273, '公共性', '1', 1018, '2025-04-09 15:24:03', '2025-04-09 15:24:03');
INSERT INTO `sm_item_options` VALUES (3274, '严重性', '1', 1018, '2025-04-09 15:24:03', '2025-04-09 15:24:03');
INSERT INTO `sm_item_options` VALUES (3275, '紧迫性', '1', 1018, '2025-04-09 15:24:03', '2025-04-09 15:24:03');
INSERT INTO `sm_item_options` VALUES (3276, '复杂性', '1', 1018, '2025-04-09 15:24:03', '2025-04-09 15:24:03');
INSERT INTO `sm_item_options` VALUES (3277, '易变性', '1', 1018, '2025-04-09 15:24:03', '2025-04-09 15:24:03');
INSERT INTO `sm_item_options` VALUES (3278, '特别重大', '1', 1019, '2025-04-09 15:24:30', '2025-04-09 15:24:30');
INSERT INTO `sm_item_options` VALUES (3279, '较大', '1', 1019, '2025-04-09 15:24:30', '2025-04-09 15:24:30');
INSERT INTO `sm_item_options` VALUES (3280, '一般', '1', 1019, '2025-04-09 15:24:31', '2025-04-09 15:24:31');
INSERT INTO `sm_item_options` VALUES (3281, '重大', '1', 1019, '2025-04-09 15:24:31', '2025-04-09 15:24:31');
INSERT INTO `sm_item_options` VALUES (3282, '坚持依法行政', '1', 1020, '2025-04-09 15:24:57', '2025-04-09 15:24:57');
INSERT INTO `sm_item_options` VALUES (3283, '保障物资供应', '1', 1020, '2025-04-09 15:24:57', '2025-04-09 15:24:57');
INSERT INTO `sm_item_options` VALUES (3284, '规范信息传播', '1', 1020, '2025-04-09 15:24:57', '2025-04-09 15:24:57');
INSERT INTO `sm_item_options` VALUES (3285, '健全决策机制', '1', 1020, '2025-04-09 15:24:57', '2025-04-09 15:24:57');
INSERT INTO `sm_item_options` VALUES (3286, '建立预警系统', '1', 1020, '2025-04-09 15:24:58', '2025-04-09 15:24:58');
INSERT INTO `sm_item_options` VALUES (3287, '预防为主，关口前移', '1', 1021, '2025-04-09 15:25:36', '2025-04-09 15:25:36');
INSERT INTO `sm_item_options` VALUES (3288, '信息先行，快速反应', '1', 1021, '2025-04-09 15:25:36', '2025-04-09 15:25:36');
INSERT INTO `sm_item_options` VALUES (3289, '社会参与，协同合作', '1', 1021, '2025-04-09 15:25:36', '2025-04-09 15:25:36');
INSERT INTO `sm_item_options` VALUES (3290, '分类管理，分级负责', '1', 1021, '2025-04-09 15:25:36', '2025-04-09 15:25:36');
INSERT INTO `sm_item_options` VALUES (3291, '依靠科学，依法处置', '1', 1021, '2025-04-09 15:25:36', '2025-04-09 15:25:36');
INSERT INTO `sm_item_options` VALUES (3292, '应急预案', '1', 1022, '2025-04-09 15:30:20', '2025-04-09 15:30:20');
INSERT INTO `sm_item_options` VALUES (3293, '法制建设', '1', 1022, '2025-04-09 15:30:20', '2025-04-09 15:30:20');
INSERT INTO `sm_item_options` VALUES (3294, '体制建设', '1', 1022, '2025-04-09 15:30:20', '2025-04-09 15:30:20');
INSERT INTO `sm_item_options` VALUES (3295, '机制建设', '1', 1022, '2025-04-09 15:30:20', '2025-04-09 15:30:20');
INSERT INTO `sm_item_options` VALUES (3296, '正确', '1', 1023, '2025-04-09 15:30:38', '2025-04-09 15:30:38');
INSERT INTO `sm_item_options` VALUES (3297, '错误', NULL, 1023, '2025-04-09 15:30:38', '2025-04-09 15:30:38');
INSERT INTO `sm_item_options` VALUES (3298, '正确', '1', 1024, '2025-04-09 15:31:16', '2025-04-09 15:31:16');
INSERT INTO `sm_item_options` VALUES (3299, '错误', NULL, 1024, '2025-04-09 15:31:16', '2025-04-09 15:31:16');
INSERT INTO `sm_item_options` VALUES (3300, '正确', NULL, 1025, '2025-04-09 15:31:28', '2025-04-09 15:31:28');
INSERT INTO `sm_item_options` VALUES (3301, '错误', '1', 1025, '2025-04-09 15:31:28', '2025-04-09 15:31:28');
INSERT INTO `sm_item_options` VALUES (3302, '正确', '1', 1026, '2025-04-09 15:31:40', '2025-04-09 15:31:40');
INSERT INTO `sm_item_options` VALUES (3303, '错误', NULL, 1026, '2025-04-09 15:31:40', '2025-04-09 15:31:40');
INSERT INTO `sm_item_options` VALUES (3304, '百日咳', '1', 1027, '2025-04-09 15:39:26', '2025-04-09 15:39:26');
INSERT INTO `sm_item_options` VALUES (3305, '肺炎', NULL, 1027, '2025-04-09 15:39:26', '2025-04-09 15:39:26');
INSERT INTO `sm_item_options` VALUES (3306, '支气管炎', NULL, 1027, '2025-04-09 15:39:26', '2025-04-09 15:39:26');
INSERT INTO `sm_item_options` VALUES (3307, '支气管哮喘', NULL, 1027, '2025-04-09 15:39:26', '2025-04-09 15:39:26');
INSERT INTO `sm_item_options` VALUES (3308, '胃溃疡', NULL, 1028, '2025-04-09 15:40:45', '2025-04-09 15:40:45');
INSERT INTO `sm_item_options` VALUES (3309, '十二指肠溃疡', '1', 1028, '2025-04-09 15:40:45', '2025-04-09 15:40:45');
INSERT INTO `sm_item_options` VALUES (3310, '慢性胃炎', NULL, 1028, '2025-04-09 15:40:45', '2025-04-09 15:40:45');
INSERT INTO `sm_item_options` VALUES (3311, '胃癌', NULL, 1028, '2025-04-09 15:40:45', '2025-04-09 15:40:45');
INSERT INTO `sm_item_options` VALUES (3312, '多饮、多食、多尿、体重减轻症状', NULL, 1029, '2025-04-09 15:41:10', '2025-04-09 15:41:10');
INSERT INTO `sm_item_options` VALUES (3313, '尿糖阳性', NULL, 1029, '2025-04-09 15:41:10', '2025-04-09 15:41:10');
INSERT INTO `sm_item_options` VALUES (3314, '空腹血糖≥7.0mmol/L 或随机血糖≥11.1mmol/L', '1', 1029, '2025-04-09 15:41:10', '2025-04-09 15:41:10');
INSERT INTO `sm_item_options` VALUES (3315, '糖化血红蛋白升高', NULL, 1029, '2025-04-09 15:41:10', '2025-04-09 15:41:10');
INSERT INTO `sm_item_options` VALUES (3316, '发热', '1', 1030, '2025-04-09 15:41:51', '2025-04-09 15:41:51');
INSERT INTO `sm_item_options` VALUES (3317, '咳嗽', '1', 1030, '2025-04-09 15:41:51', '2025-04-09 15:41:51');
INSERT INTO `sm_item_options` VALUES (3318, '咳痰', '1', 1030, '2025-04-09 15:41:51', '2025-04-09 15:41:51');
INSERT INTO `sm_item_options` VALUES (3319, '胸痛', '1', 1030, '2025-04-09 15:41:51', '2025-04-09 15:41:51');
INSERT INTO `sm_item_options` VALUES (3320, '呼吸困难', '1', 1030, '2025-04-09 15:41:51', '2025-04-09 15:41:51');
INSERT INTO `sm_item_options` VALUES (3321, '心电图', '1', 1031, '2025-04-09 15:42:20', '2025-04-09 15:42:20');
INSERT INTO `sm_item_options` VALUES (3322, '动态心电图（Holter）', '1', 1031, '2025-04-09 15:42:20', '2025-04-09 15:42:20');
INSERT INTO `sm_item_options` VALUES (3323, '心脏超声', NULL, 1031, '2025-04-09 15:42:20', '2025-04-09 15:42:20');
INSERT INTO `sm_item_options` VALUES (3324, '运动平板试验', '1', 1031, '2025-04-09 15:42:20', '2025-04-09 15:42:20');
INSERT INTO `sm_item_options` VALUES (3325, '食管心电图', '1', 1031, '2025-04-09 15:42:20', '2025-04-09 15:42:20');
INSERT INTO `sm_item_options` VALUES (3326, '胸骨体之后，可波及心前区', '1', 1032, '2025-04-09 15:42:39', '2025-04-09 15:42:39');
INSERT INTO `sm_item_options` VALUES (3327, '大肠埃希菌', '1', 1033, '2025-04-09 15:42:55', '2025-04-09 15:42:55');
INSERT INTO `sm_item_options` VALUES (3328, '发作性伴有哮鸣音的呼气性呼吸困难', '1', 1034, '2025-04-09 15:43:10', '2025-04-09 15:43:10');
INSERT INTO `sm_item_options` VALUES (3329, '正确', NULL, 1035, '2025-04-09 15:43:33', '2025-04-09 15:43:33');
INSERT INTO `sm_item_options` VALUES (3330, '错误', '1', 1035, '2025-04-09 15:43:33', '2025-04-09 15:43:33');
INSERT INTO `sm_item_options` VALUES (3331, '正确', '1', 1036, '2025-04-09 15:43:47', '2025-04-09 15:43:47');
INSERT INTO `sm_item_options` VALUES (3332, '错误', NULL, 1036, '2025-04-09 15:43:47', '2025-04-09 15:43:47');
INSERT INTO `sm_item_options` VALUES (3333, '症状：典型症状为胸痛，疼痛部位多在胸骨后或心前区，可放射至左肩、左臂内侧等部位，疼痛性质多为压榨性、闷痛或紧缩感，程度较剧烈，持续时间常超过 30 分钟，休息或含服硝酸甘油不能缓解。部分患者可伴有出汗、恶心、呕吐、心悸、呼吸困难等症状。少数患者症状不典型，如表现为牙痛、腹痛等。\n心电图改变：出现特征性动态演变。起病数小时内可出现超急性期 T 波改变，数小时后 ST 段明显抬高，呈弓背向上型，与直立的 T 波连接形成单相曲线，数小时 - 2 天内出现病理性 Q 波，同时 ST 段逐渐回到基线水平，T 波倒置。\n心肌损伤标志物：肌钙蛋白（cTnI、cTnT）在心肌梗死后 3 - 4 小时升高，11 - 24 小时达高峰，7 - 10 天恢复正常，是诊断心肌梗死最特异和敏感的标志物。肌酸激酶同工酶（CK - MB）在起病后 4 小时内增高，16 - 24 小时达高峰，3 - 4 天恢复正常。肌红蛋白升高出现最早，但特异性不如肌钙蛋白。\n心脏超声等影像学检查：可发现心肌节段性运动异常，有助于明确心肌梗死部位和范围，评估心脏功能等。结合患者症状、心电图动态改变及心肌损伤标志物升高，一般可明确诊断急性心肌梗死。', '1', 1037, '2025-04-09 17:52:37', '2025-04-09 17:52:37');
INSERT INTO `sm_item_options` VALUES (3334, '胸骨上半段', NULL, 1038, '2025-04-09 15:46:15', '2025-04-09 15:46:15');
INSERT INTO `sm_item_options` VALUES (3335, '胸骨下半段，两乳头连线中点', '1', 1038, '2025-04-09 15:46:15', '2025-04-09 15:46:15');
INSERT INTO `sm_item_options` VALUES (3336, '剑突下', NULL, 1038, '2025-04-09 15:46:15', '2025-04-09 15:46:15');
INSERT INTO `sm_item_options` VALUES (3337, '心前区', NULL, 1038, '2025-04-09 15:46:15', '2025-04-09 15:46:15');
INSERT INTO `sm_item_options` VALUES (3338, '60 - 80 次 / 分钟', NULL, 1039, '2025-04-09 15:46:40', '2025-04-09 15:46:40');
INSERT INTO `sm_item_options` VALUES (3339, '80 - 100 次 / 分钟', NULL, 1039, '2025-04-09 15:46:40', '2025-04-09 15:46:40');
INSERT INTO `sm_item_options` VALUES (3340, '100 - 120 次 / 分钟', '1', 1039, '2025-04-09 15:46:40', '2025-04-09 15:46:40');
INSERT INTO `sm_item_options` VALUES (3341, '120 - 140 次 / 分钟', NULL, 1039, '2025-04-09 15:46:40', '2025-04-09 15:46:40');
INSERT INTO `sm_item_options` VALUES (3342, '心脏骤停', NULL, 1040, '2025-04-09 15:47:00', '2025-04-09 15:47:00');
INSERT INTO `sm_item_options` VALUES (3343, '溺水', NULL, 1040, '2025-04-09 15:47:00', '2025-04-09 15:47:00');
INSERT INTO `sm_item_options` VALUES (3344, '呼吸道异物梗阻', '1', 1040, '2025-04-09 15:47:00', '2025-04-09 15:47:00');
INSERT INTO `sm_item_options` VALUES (3345, '创伤出血', NULL, 1040, '2025-04-09 15:47:01', '2025-04-09 15:47:01');
INSERT INTO `sm_item_options` VALUES (3346, '先救命后治伤', '1', 1041, '2025-04-09 15:47:45', '2025-04-09 15:47:45');
INSERT INTO `sm_item_options` VALUES (3347, '争分夺秒', '1', 1041, '2025-04-09 15:47:45', '2025-04-09 15:47:45');
INSERT INTO `sm_item_options` VALUES (3348, '就地取材', '1', 1041, '2025-04-09 15:47:45', '2025-04-09 15:47:45');
INSERT INTO `sm_item_options` VALUES (3349, '及时转运', '1', 1041, '2025-04-09 15:47:45', '2025-04-09 15:47:45');
INSERT INTO `sm_item_options` VALUES (3350, '止血', '1', 1042, '2025-04-09 15:48:13', '2025-04-09 15:48:13');
INSERT INTO `sm_item_options` VALUES (3351, '包扎', '1', 1042, '2025-04-09 15:48:13', '2025-04-09 15:48:13');
INSERT INTO `sm_item_options` VALUES (3352, '固定', '1', 1042, '2025-04-09 15:48:13', '2025-04-09 15:48:13');
INSERT INTO `sm_item_options` VALUES (3353, '搬运', '1', 1042, '2025-04-09 15:48:13', '2025-04-09 15:48:13');
INSERT INTO `sm_item_options` VALUES (3354, '迅速将患者救离水面', '1', 1043, '2025-04-09 15:48:36', '2025-04-09 15:48:36');
INSERT INTO `sm_item_options` VALUES (3355, '清除口鼻异物，保持呼吸道通畅', '1', 1043, '2025-04-09 15:48:36', '2025-04-09 15:48:36');
INSERT INTO `sm_item_options` VALUES (3356, '进行心肺复苏（如有需要）', '1', 1043, '2025-04-09 15:48:36', '2025-04-09 15:48:36');
INSERT INTO `sm_item_options` VALUES (3357, '保暖', '1', 1043, '2025-04-09 15:48:36', '2025-04-09 15:48:36');
INSERT INTO `sm_item_options` VALUES (3358, 'CPR', '1', 1044, '2025-04-09 15:49:02', '2025-04-09 15:49:02');
INSERT INTO `sm_item_options` VALUES (3359, '肥皂水和流动清水', '1', 1045, '2025-04-09 15:49:18', '2025-04-09 15:49:18');
INSERT INTO `sm_item_options` VALUES (3360, '海姆立克', '1', 1046, '2025-04-09 15:49:30', '2025-04-09 15:49:30');
INSERT INTO `sm_item_options` VALUES (3361, '近心', '1', 1047, '2025-04-09 15:49:44', '2025-04-09 15:49:44');
INSERT INTO `sm_item_options` VALUES (3362, '正确', NULL, 1048, '2025-04-09 15:49:57', '2025-04-09 15:49:57');
INSERT INTO `sm_item_options` VALUES (3363, '错误', '1', 1048, '2025-04-09 15:49:57', '2025-04-09 15:49:57');
INSERT INTO `sm_item_options` VALUES (3364, '正确', NULL, 1049, '2025-04-09 15:50:08', '2025-04-09 15:50:08');
INSERT INTO `sm_item_options` VALUES (3365, '错误', '1', 1049, '2025-04-09 15:50:09', '2025-04-09 15:50:09');
INSERT INTO `sm_item_options` VALUES (3366, '正确', NULL, 1050, '2025-04-09 15:50:30', '2025-04-09 15:50:30');
INSERT INTO `sm_item_options` VALUES (3367, '错误', '1', 1050, '2025-04-09 15:50:30', '2025-04-09 15:50:30');
INSERT INTO `sm_item_options` VALUES (3368, '①评估现场安全，在确保自身和患者安全前提下施救；②判断患者意识，轻拍双肩并呼喊，观察有无反应；③检查呼吸，看胸廓有无起伏，听呼吸声，感觉呼吸气流，判断时间不超 10 秒；④若患者无反应且无呼吸或仅有濒死叹息样呼吸，立即呼救并请人拨打急救电话、取 AED；⑤进行胸外按压，位置在胸骨下半段、两乳头连线中点，双手掌根重叠，手指翘起，垂直按压，频率 100 - 120 次 / 分钟，深度 5 - 6 厘米；⑥开放气道，清除口鼻异物，采用仰头抬颌法打开气道；⑦进行人工呼吸，捏住患者鼻子，口对口吹气，每次吹气持续 1 秒以上，观察到胸廓起伏，按压与呼吸比为 30:2 ；⑧持续进行心肺复苏，直到患者恢复呼吸心跳、急救人员到达或出现复苏终止指征。', '1', 1051, '2025-04-09 15:51:04', '2025-04-09 15:51:04');
INSERT INTO `sm_item_options` VALUES (3369, '①按压止血法：用纱布、手帕等干净布料直接按压伤口，适用于较小伤口出血；②加压包扎止血法：在伤口处覆盖多层纱布等敷料，用绷带等适度加压包扎，用于一般伤口出血；③指压止血法：在出血部位近心端相应动脉压迫点，用手指压迫动脉阻断血流，如头顶出血压迫颞浅动脉；④止血带止血法：用于四肢大动脉出血，在近心端适当部位绑扎止血带，注意记录时间，每隔 1 小时放松 1 - 2 分钟。', NULL, 1052, '2025-04-09 15:51:15', '2025-04-09 15:51:15');
INSERT INTO `sm_item_options` VALUES (3382, '流感', NULL, 1056, '2025-04-09 15:53:05', '2025-04-09 15:53:05');
INSERT INTO `sm_item_options` VALUES (3383, '肺炎', NULL, 1056, '2025-04-09 15:53:05', '2025-04-09 15:53:05');
INSERT INTO `sm_item_options` VALUES (3384, '高血压', '1', 1056, '2025-04-09 15:53:05', '2025-04-09 15:53:05');
INSERT INTO `sm_item_options` VALUES (3389, '急性肠胃炎', NULL, 1056, '2025-04-09 15:53:05', '2025-04-09 15:53:05');
INSERT INTO `sm_item_options` VALUES (3398, '≥6.1mmol/L', NULL, 1060, '2025-04-09 15:54:14', '2025-04-09 15:54:14');
INSERT INTO `sm_item_options` VALUES (3399, '≥7.0mmol/L', '1', 1060, '2025-04-09 15:54:14', '2025-04-09 15:54:14');
INSERT INTO `sm_item_options` VALUES (3400, '≥7.8mmol/L', NULL, 1060, '2025-04-09 15:54:14', '2025-04-09 15:54:14');
INSERT INTO `sm_item_options` VALUES (3401, '≥11.1mmol/L', NULL, 1060, '2025-04-09 15:54:14', '2025-04-09 15:54:14');
INSERT INTO `sm_item_options` VALUES (3402, '病因复杂', NULL, 1061, '2025-04-09 15:54:53', '2025-04-09 15:54:53');
INSERT INTO `sm_item_options` VALUES (3403, '病程长', NULL, 1061, '2025-04-09 15:54:53', '2025-04-09 15:54:53');
INSERT INTO `sm_item_options` VALUES (3404, '起病急', '1', 1061, '2025-04-09 15:54:53', '2025-04-09 15:54:53');
INSERT INTO `sm_item_options` VALUES (3405, '致残率高', NULL, 1061, '2025-04-09 15:54:54', '2025-04-09 15:54:54');
INSERT INTO `sm_item_options` VALUES (3410, '疾病监测', '1', 1063, '2025-04-09 15:55:57', '2025-04-09 15:55:57');
INSERT INTO `sm_item_options` VALUES (3411, '药物治疗管理', '1', 1063, '2025-04-09 15:55:57', '2025-04-09 15:55:57');
INSERT INTO `sm_item_options` VALUES (3412, '生活方式干预', '1', 1063, '2025-04-09 15:55:57', '2025-04-09 15:55:57');
INSERT INTO `sm_item_options` VALUES (3413, '心理支持', '1', 1063, '2025-04-09 15:55:58', '2025-04-09 15:55:58');
INSERT INTO `sm_item_options` VALUES (3414, '5', '1', 1064, '2025-04-09 15:56:30', '2025-04-09 15:56:30');
INSERT INTO `sm_item_options` VALUES (3415, '每天检查足部有无破损、水疱、红肿等；保持足部清洁，用温水洗脚，避免烫伤；选择合适的鞋袜，鞋子宽松舒适、透气性好，袜子柔软吸汗；修剪指甲时避免损伤皮肤；避免赤脚行走；如足部出现问题及时就医。', '1', 1065, '2025-04-09 17:53:19', '2025-04-09 17:53:19');
INSERT INTO `sm_item_options` VALUES (3416, '两乳头之间为 8 寸', '1', 1066, '2025-04-09 16:02:41', '2025-04-09 16:02:41');
INSERT INTO `sm_item_options` VALUES (3417, '握拳，中指尖下为劳宫穴', NULL, 1066, '2025-04-09 16:02:41', '2025-04-09 16:02:41');
INSERT INTO `sm_item_options` VALUES (3418, '以患者手指宽度为标准测量穴位', NULL, 1066, '2025-04-09 16:02:41', '2025-04-09 16:02:41');
INSERT INTO `sm_item_options` VALUES (3419, '鼻尖正中央为素髎穴', NULL, 1066, '2025-04-09 16:02:41', '2025-04-09 16:02:41');
INSERT INTO `sm_item_options` VALUES (3420, '直刺', NULL, 1067, '2025-04-09 16:03:20', '2025-04-09 16:03:20');
INSERT INTO `sm_item_options` VALUES (3421, '斜刺', '1', 1067, '2025-04-09 16:03:20', '2025-04-09 16:03:20');
INSERT INTO `sm_item_options` VALUES (3422, '平刺', NULL, 1067, '2025-04-09 16:03:20', '2025-04-09 16:03:20');
INSERT INTO `sm_item_options` VALUES (3423, '透刺', NULL, 1067, '2025-04-09 16:03:20', '2025-04-09 16:03:20');
INSERT INTO `sm_item_options` VALUES (3424, '揉法', NULL, 1068, '2025-04-09 16:17:11', '2025-04-09 16:17:11');
INSERT INTO `sm_item_options` VALUES (3425, '摩法', NULL, 1068, '2025-04-09 16:17:11', '2025-04-09 16:17:11');
INSERT INTO `sm_item_options` VALUES (3426, '一指禅推法', '1', 1068, '2025-04-09 16:17:11', '2025-04-09 16:17:11');
INSERT INTO `sm_item_options` VALUES (3427, '擦法', NULL, 1068, '2025-04-09 16:17:11', '2025-04-09 16:17:11');
INSERT INTO `sm_item_options` VALUES (3428, '针灸', '1', 1069, '2025-04-09 16:17:47', '2025-04-09 16:17:47');
INSERT INTO `sm_item_options` VALUES (3429, '推拿', '1', 1069, '2025-04-09 16:17:47', '2025-04-09 16:17:47');
INSERT INTO `sm_item_options` VALUES (3430, '拔罐', '1', 1069, '2025-04-09 16:17:47', '2025-04-09 16:17:47');
INSERT INTO `sm_item_options` VALUES (3431, '中药熏蒸', '1', 1069, '2025-04-09 16:17:47', '2025-04-09 16:17:47');
INSERT INTO `sm_item_options` VALUES (3432, '患者在饥饿、疲劳、精神高度紧张时不宜针刺', '1', 1070, '2025-04-09 16:18:27', '2025-04-09 16:18:27');
INSERT INTO `sm_item_options` VALUES (3433, '皮肤有感染、溃疡、瘢痕或肿瘤的部位不宜针刺', '1', 1070, '2025-04-09 16:18:27', '2025-04-09 16:18:27');
INSERT INTO `sm_item_options` VALUES (3434, '孕妇的腹部、腰骶部及合谷、三阴交等穴位不宜针刺', '1', 1070, '2025-04-09 16:18:27', '2025-04-09 16:18:27');
INSERT INTO `sm_item_options` VALUES (3435, '针刺时要注意进针角度、深度', '1', 1070, '2025-04-09 16:18:27', '2025-04-09 16:18:27');
INSERT INTO `sm_item_options` VALUES (3436, '疏通经络', '1', 1071, '2025-04-09 16:19:15', '2025-04-09 16:19:15');
INSERT INTO `sm_item_options` VALUES (3437, '调和气血', '1', 1071, '2025-04-09 16:19:15', '2025-04-09 16:19:15');
INSERT INTO `sm_item_options` VALUES (3438, '调整脏腑功能', '1', 1071, '2025-04-09 16:19:15', '2025-04-09 16:19:15');
INSERT INTO `sm_item_options` VALUES (3439, '理筋整复', '1', 1071, '2025-04-09 16:19:15', '2025-04-09 16:19:15');
INSERT INTO `sm_item_options` VALUES (3440, '温通经络', '1', 1072, '2025-04-09 16:19:50', '2025-04-09 16:19:50');
INSERT INTO `sm_item_options` VALUES (3441, '祛风散寒', '1', 1072, '2025-04-09 16:19:50', '2025-04-09 16:19:50');
INSERT INTO `sm_item_options` VALUES (3442, '消肿止痛', '1', 1072, '2025-04-09 16:19:50', '2025-04-09 16:19:50');
INSERT INTO `sm_item_options` VALUES (3443, '吸毒排脓', '1', 1072, '2025-04-09 16:19:50', '2025-04-09 16:19:50');
INSERT INTO `sm_item_options` VALUES (3444, '温经散寒', '1', 1073, '2025-04-09 16:20:17', '2025-04-09 16:20:17');
INSERT INTO `sm_item_options` VALUES (3445, '扶阳固脱', '1', 1073, '2025-04-09 16:20:17', '2025-04-09 16:20:17');
INSERT INTO `sm_item_options` VALUES (3446, '消瘀散结', '1', 1073, '2025-04-09 16:20:17', '2025-04-09 16:20:17');
INSERT INTO `sm_item_options` VALUES (3447, '防病保健', '1', 1073, '2025-04-09 16:20:18', '2025-04-09 16:20:18');
INSERT INTO `sm_item_options` VALUES (3448, '艾叶', '1', 1074, '2025-04-09 16:20:35', '2025-04-09 16:20:35');
INSERT INTO `sm_item_options` VALUES (3449, '正确', NULL, 1075, '2025-04-09 16:20:50', '2025-04-09 16:20:50');
INSERT INTO `sm_item_options` VALUES (3450, '错误', '1', 1075, '2025-04-09 16:20:50', '2025-04-09 16:20:50');
INSERT INTO `sm_item_options` VALUES (3451, '正确', NULL, 1076, '2025-04-09 16:21:11', '2025-04-09 16:21:11');
INSERT INTO `sm_item_options` VALUES (3452, '错误', '1', 1076, '2025-04-09 16:21:11', '2025-04-09 16:21:11');
INSERT INTO `sm_item_options` VALUES (3453, '①近部选穴，在病变局部或临近部位选取穴位，如眼病取睛明穴；②远部选穴，在病变部位所属和相关经络上，距病位较远的部位选穴，如胃痛选足三里；③辨证选穴，根据疾病的证候特点，分析病因病机而辨证选取穴位，如失眠属心脾两虚选心俞、脾俞；④对症选穴，针对疾病的个别突出症状而选取穴位，如发热选大椎。', '1', 1077, '2025-04-09 16:21:35', '2025-04-09 16:21:35');
INSERT INTO `sm_item_options` VALUES (3454, '洗手', '1', 1078, '2025-04-09 16:40:07', '2025-04-09 16:40:07');
INSERT INTO `sm_item_options` VALUES (3455, '卫生手消毒', NULL, 1078, '2025-04-09 16:40:07', '2025-04-09 16:40:07');
INSERT INTO `sm_item_options` VALUES (3456, '外科手消毒', NULL, 1078, '2025-04-09 16:40:07', '2025-04-09 16:40:07');
INSERT INTO `sm_item_options` VALUES (3457, '戴手套', NULL, 1078, '2025-04-09 16:40:07', '2025-04-09 16:40:07');
INSERT INTO `sm_item_options` VALUES (3458, '250mg/L', NULL, 1079, '2025-04-09 16:40:36', '2025-04-09 16:40:36');
INSERT INTO `sm_item_options` VALUES (3459, '500mg/L', '1', 1079, '2025-04-09 16:40:37', '2025-04-09 16:40:37');
INSERT INTO `sm_item_options` VALUES (3460, '1000mg/L', NULL, 1079, '2025-04-09 16:40:37', '2025-04-09 16:40:37');
INSERT INTO `sm_item_options` VALUES (3461, '2000mg/L', NULL, 1079, '2025-04-09 16:40:37', '2025-04-09 16:40:37');
INSERT INTO `sm_item_options` VALUES (3462, '感染性废物', '1', 1080, '2025-04-09 16:41:10', '2025-04-09 16:41:10');
INSERT INTO `sm_item_options` VALUES (3463, '损伤性废物', NULL, 1080, '2025-04-09 16:41:10', '2025-04-09 16:41:10');
INSERT INTO `sm_item_options` VALUES (3464, '病理性废物', NULL, 1080, '2025-04-09 16:41:10', '2025-04-09 16:41:10');
INSERT INTO `sm_item_options` VALUES (3465, '化学性废物', NULL, 1080, '2025-04-09 16:41:10', '2025-04-09 16:41:10');
INSERT INTO `sm_item_options` VALUES (3466, '紫外线照射消毒', NULL, 1081, '2025-04-09 16:41:38', '2025-04-09 16:41:38');
INSERT INTO `sm_item_options` VALUES (3467, '化学消毒剂喷雾消毒', NULL, 1081, '2025-04-09 16:41:38', '2025-04-09 16:41:38');
INSERT INTO `sm_item_options` VALUES (3468, '空气净化器消毒', NULL, 1081, '2025-04-09 16:41:39', '2025-04-09 16:41:39');
INSERT INTO `sm_item_options` VALUES (3469, '自然通风', '1', 1081, '2025-04-09 16:41:39', '2025-04-09 16:41:39');
INSERT INTO `sm_item_options` VALUES (3470, '患者出院', NULL, 1082, '2025-04-09 16:42:13', '2025-04-09 16:42:13');
INSERT INTO `sm_item_options` VALUES (3471, '患者转院', NULL, 1082, '2025-04-09 16:42:13', '2025-04-09 16:42:13');
INSERT INTO `sm_item_options` VALUES (3472, '患者死亡', NULL, 1082, '2025-04-09 16:42:13', '2025-04-09 16:42:13');
INSERT INTO `sm_item_options` VALUES (3473, '患者外出检查', '1', 1082, '2025-04-09 16:42:13', '2025-04-09 16:42:13');
INSERT INTO `sm_item_options` VALUES (3474, '接触患者前', '1', 1083, '2025-04-09 16:42:42', '2025-04-09 16:42:42');
INSERT INTO `sm_item_options` VALUES (3475, '清洁或无菌操作前', '1', 1083, '2025-04-09 16:42:42', '2025-04-09 16:42:42');
INSERT INTO `sm_item_options` VALUES (3476, '接触患者血液、体液后', '1', 1083, '2025-04-09 16:42:42', '2025-04-09 16:42:42');
INSERT INTO `sm_item_options` VALUES (3477, '接触患者周围环境后', '1', 1083, '2025-04-09 16:42:42', '2025-04-09 16:42:42');
INSERT INTO `sm_item_options` VALUES (3478, '合理划分清洁区、半污染区、污染区', '1', 1084, '2025-04-09 16:43:11', '2025-04-09 16:43:11');
INSERT INTO `sm_item_options` VALUES (3479, '正确使用个人防护用品', '1', 1084, '2025-04-09 16:43:11', '2025-04-09 16:43:11');
INSERT INTO `sm_item_options` VALUES (3480, '严格执行消毒制度', '1', 1084, '2025-04-09 16:43:11', '2025-04-09 16:43:11');
INSERT INTO `sm_item_options` VALUES (3481, '加强通风换气', '1', 1084, '2025-04-09 16:43:11', '2025-04-09 16:43:11');
INSERT INTO `sm_item_options` VALUES (3482, '感染防控知识和技能', '1', 1085, '2025-04-09 16:44:17', '2025-04-09 16:44:17');
INSERT INTO `sm_item_options` VALUES (3483, '手卫生规范', '1', 1085, '2025-04-09 16:44:17', '2025-04-09 16:44:17');
INSERT INTO `sm_item_options` VALUES (3484, '消毒隔离制度', '1', 1085, '2025-04-09 16:44:17', '2025-04-09 16:44:17');
INSERT INTO `sm_item_options` VALUES (3485, '医疗废物管理', '1', 1085, '2025-04-09 16:44:17', '2025-04-09 16:44:17');
INSERT INTO `sm_item_options` VALUES (3490, '正确', NULL, 1087, '2025-04-09 16:44:41', '2025-04-09 16:44:41');
INSERT INTO `sm_item_options` VALUES (3491, '错误', '1', 1087, '2025-04-09 16:44:41', '2025-04-09 16:44:41');
INSERT INTO `sm_item_options` VALUES (3492, '正确', NULL, 1088, '2025-04-09 16:44:55', '2025-04-09 16:44:55');
INSERT INTO `sm_item_options` VALUES (3493, '错误', '1', 1088, '2025-04-09 16:44:55', '2025-04-09 16:44:55');
INSERT INTO `sm_item_options` VALUES (3494, '保持环境清洁，每日清洁消毒地面、物体表面；严格执行手卫生规范，操作前后洗手或手消毒；合理分区，区分清洁区与污染区；严格执行无菌技术操作，如注射、穿刺等；使用合格的消毒灭菌产品，定期监测消毒效果；医疗废物分类收集，日产日清。', '1', 1089, '2025-04-09 17:50:51', '2025-04-09 17:50:51');
INSERT INTO `sm_item_options` VALUES (3495, '①含氯消毒剂消毒，适用于物体表面、地面、排泄物等消毒；②紫外线照射消毒，用于空气、物体表面消毒；③75% 乙醇消毒，多用于皮肤、小型医疗器械消毒。', '1', 1090, '2025-04-09 17:50:47', '2025-04-09 17:50:47');
INSERT INTO `sm_item_options` VALUES (3496, '立即进行局部处理，如用肥皂液和流动水冲洗污染皮肤，用生理盐水冲洗黏膜；如有伤口，在伤口旁端轻轻挤压，尽可能挤出损伤处的血液，再用肥皂液和流动水冲洗，然后用碘伏等消毒剂消毒并包扎伤口；及时报告医院感染管理部门，评估暴露风险，必要时进行相应的预防用药和追踪监测。', '1', 1091, '2025-04-09 17:50:45', '2025-04-09 17:50:45');
INSERT INTO `sm_item_options` VALUES (3497, '以人为本', NULL, 1092, '2025-04-09 16:47:43', '2025-04-09 16:47:43');
INSERT INTO `sm_item_options` VALUES (3498, '诚信原则', NULL, 1092, '2025-04-09 16:47:43', '2025-04-09 16:47:43');
INSERT INTO `sm_item_options` VALUES (3499, '沟通信息不对称原则', '1', 1092, '2025-04-09 16:47:43', '2025-04-09 16:47:43');
INSERT INTO `sm_item_options` VALUES (3500, '同情原则', NULL, 1092, '2025-04-09 16:47:43', '2025-04-09 16:47:43');
INSERT INTO `sm_item_options` VALUES (3501, '听清楚患者说的每一个字', NULL, 1093, '2025-04-09 16:48:24', '2025-04-09 16:48:24');
INSERT INTO `sm_item_options` VALUES (3502, '理解患者话语背后的情感和需求', '1', 1093, '2025-04-09 16:48:24', '2025-04-09 16:48:24');
INSERT INTO `sm_item_options` VALUES (3503, '快速给出回应', NULL, 1093, '2025-04-09 16:48:24', '2025-04-09 16:48:24');
INSERT INTO `sm_item_options` VALUES (3504, '记录患者的所有信息', NULL, 1093, '2025-04-09 16:48:24', '2025-04-09 16:48:24');
INSERT INTO `sm_item_options` VALUES (3505, '医疗技术水平不足', NULL, 1094, '2025-04-09 16:49:04', '2025-04-09 16:49:04');
INSERT INTO `sm_item_options` VALUES (3506, '患者及家属期望过高', NULL, 1094, '2025-04-09 16:49:04', '2025-04-09 16:49:04');
INSERT INTO `sm_item_options` VALUES (3507, '医患沟通不畅', '1', 1094, '2025-04-09 16:49:04', '2025-04-09 16:49:04');
INSERT INTO `sm_item_options` VALUES (3508, '医疗费用过高', NULL, 1094, '2025-04-09 16:49:04', '2025-04-09 16:49:04');
INSERT INTO `sm_item_options` VALUES (3509, ' 坚持自己的方案，不予解释', NULL, 1095, '2025-04-09 16:49:46', '2025-04-09 16:49:46');
INSERT INTO `sm_item_options` VALUES (3510, '简单敷衍回答', NULL, 1095, '2025-04-09 16:49:46', '2025-04-09 16:49:46');
INSERT INTO `sm_item_options` VALUES (3511, '详细解释方案的依据、利弊及其他可选择方案', '1', 1095, '2025-04-09 16:49:46', '2025-04-09 16:49:46');
INSERT INTO `sm_item_options` VALUES (3512, '让患者自己决定', NULL, 1095, '2025-04-09 16:49:46', '2025-04-09 16:49:46');
INSERT INTO `sm_item_options` VALUES (3513, '病历书写潦草、不规范', NULL, 1096, '2025-04-09 16:50:28', '2025-04-09 16:50:28');
INSERT INTO `sm_item_options` VALUES (3514, '随意承诺治疗效果', NULL, 1096, '2025-04-09 16:50:28', '2025-04-09 16:50:28');
INSERT INTO `sm_item_options` VALUES (3515, '严格遵守医疗操作规程', '1', 1096, '2025-04-09 16:50:29', '2025-04-09 16:50:29');
INSERT INTO `sm_item_options` VALUES (3516, '对患者态度冷漠', NULL, 1096, '2025-04-09 16:50:29', '2025-04-09 16:50:29');
INSERT INTO `sm_item_options` VALUES (3517, '语言沟通技巧，如使用通俗易懂语言', '1', 1097, '2025-04-09 16:51:12', '2025-04-09 16:51:12');
INSERT INTO `sm_item_options` VALUES (3518, '非语言沟通技巧，如眼神交流、微笑', '1', 1097, '2025-04-09 16:51:12', '2025-04-09 16:51:12');
INSERT INTO `sm_item_options` VALUES (3519, '倾听技巧，专注耐心倾听', '1', 1097, '2025-04-09 16:51:13', '2025-04-09 16:51:13');
INSERT INTO `sm_item_options` VALUES (3520, '反馈技巧，及时回应患者', '1', 1097, '2025-04-09 16:51:13', '2025-04-09 16:51:13');
INSERT INTO `sm_item_options` VALUES (3521, '及时与患者及家属沟通，了解诉求', '1', 1098, '2025-04-09 16:51:42', '2025-04-09 16:51:42');
INSERT INTO `sm_item_options` VALUES (3522, '组织专家对医疗行为进行评估', '1', 1098, '2025-04-09 16:51:42', '2025-04-09 16:51:42');
INSERT INTO `sm_item_options` VALUES (3523, '隐瞒可能对医院不利的信息', NULL, 1098, '2025-04-09 16:51:42', '2025-04-09 16:51:42');
INSERT INTO `sm_item_options` VALUES (3524, '积极协商解决方案', '1', 1098, '2025-04-09 16:51:42', '2025-04-09 16:51:42');
INSERT INTO `sm_item_options` VALUES (3525, '患者的文化程度', '1', 1099, '2025-04-09 16:52:11', '2025-04-09 16:52:11');
INSERT INTO `sm_item_options` VALUES (3526, '医生的职业道德', '1', 1099, '2025-04-09 16:52:11', '2025-04-09 16:52:11');
INSERT INTO `sm_item_options` VALUES (3527, '医院的管理水平', '1', 1099, '2025-04-09 16:52:11', '2025-04-09 16:52:11');
INSERT INTO `sm_item_options` VALUES (3528, '社会舆论导向', '1', 1099, '2025-04-09 16:52:11', '2025-04-09 16:52:11');
INSERT INTO `sm_item_options` VALUES (3529, '对患者的痛苦表示理解', '1', 1100, '2025-04-09 16:52:46', '2025-04-09 16:52:46');
INSERT INTO `sm_item_options` VALUES (3530, '讲述自己类似经历', '1', 1100, '2025-04-09 16:52:46', '2025-04-09 16:52:46');
INSERT INTO `sm_item_options` VALUES (3531, '用语言安慰患者', '1', 1100, '2025-04-09 16:52:46', '2025-04-09 16:52:46');
INSERT INTO `sm_item_options` VALUES (3532, '轻轻拍拍患者肩膀（在合适情境下）', '1', 1100, '2025-04-09 16:52:46', '2025-04-09 16:52:46');
INSERT INTO `sm_item_options` VALUES (3533, '术语', '1', 1101, '2025-04-09 16:53:08', '2025-04-09 16:53:08');
INSERT INTO `sm_item_options` VALUES (3534, '提高医疗质量', '1', 1102, '2025-04-09 16:53:26', '2025-04-09 16:53:26');
INSERT INTO `sm_item_options` VALUES (3535, '调解', '1', 1103, '2025-04-09 16:53:40', '2025-04-09 16:53:40');
INSERT INTO `sm_item_options` VALUES (3536, '医患双方', '1', 1104, '2025-04-09 16:53:57', '2025-04-09 16:53:57');
INSERT INTO `sm_item_options` VALUES (3537, '信任', '1', 1105, '2025-04-09 16:54:48', '2025-04-09 16:54:48');
INSERT INTO `sm_item_options` VALUES (3538, '使用通俗易懂语言，避免医学术语；语言表达清晰准确，避免模糊不清；注意语气语调，温和友善；多使用鼓励性、安慰性语言；尊重患者隐私，避免不当谈论。', '1', 1106, '2025-04-09 17:02:15', '2025-04-09 17:02:15');
INSERT INTO `sm_item_options` VALUES (3539, '保持冷静，避免与患者及家属冲突；积极配合医院相关部门，提供医疗资料；参与医疗行为评估；真诚与患者及家属沟通，解释病情和治疗过程，共同协商解决方案。', '1', 1107, '2025-04-09 17:02:29', '2025-04-09 17:02:29');
INSERT INTO `sm_item_options` VALUES (3540, '加强医务人员培训，提高医疗技术与沟通能力；完善医院管理制度，规范医疗行为流程；建立患者投诉渠道，及时处理患者意见（任选两种即可）。', '1', 1108, '2025-04-09 17:02:44', '2025-04-09 17:02:44');
INSERT INTO `sm_item_options` VALUES (3541, '正确', '1', 1109, '2025-04-09 17:03:12', '2025-04-09 17:03:12');
INSERT INTO `sm_item_options` VALUES (3542, '错误', NULL, 1109, '2025-04-09 17:03:12', '2025-04-09 17:03:12');
INSERT INTO `sm_item_options` VALUES (3543, '随地吐痰', NULL, 1110, '2025-04-09 17:06:45', '2025-04-09 17:06:45');
INSERT INTO `sm_item_options` VALUES (3544, '不戴口罩', NULL, 1110, '2025-04-09 17:06:45', '2025-04-09 17:06:45');
INSERT INTO `sm_item_options` VALUES (3545, '勤洗手、多通风', '1', 1110, '2025-04-09 17:06:45', '2025-04-09 17:06:45');
INSERT INTO `sm_item_options` VALUES (3546, '与患者密切接触', NULL, 1110, '2025-04-09 17:06:45', '2025-04-09 17:06:45');
INSERT INTO `sm_item_options` VALUES (3547, '合理饮食', NULL, 1111, '2025-04-09 17:07:10', '2025-04-09 17:07:10');
INSERT INTO `sm_item_options` VALUES (3548, '适量运动', NULL, 1111, '2025-04-09 17:07:10', '2025-04-09 17:07:10');
INSERT INTO `sm_item_options` VALUES (3549, '长期熬夜', '1', 1111, '2025-04-09 17:07:10', '2025-04-09 17:07:10');
INSERT INTO `sm_item_options` VALUES (3550, '戒烟限酒', NULL, 1111, '2025-04-09 17:07:10', '2025-04-09 17:07:10');
INSERT INTO `sm_item_options` VALUES (3551, '治疗疾病', NULL, 1112, '2025-04-09 17:07:36', '2025-04-09 17:07:36');
INSERT INTO `sm_item_options` VALUES (3552, '预防传染病', '1', 1112, '2025-04-09 17:07:36', '2025-04-09 17:07:36');
INSERT INTO `sm_item_options` VALUES (3553, '增强体质', NULL, 1112, '2025-04-09 17:07:36', '2025-04-09 17:07:36');
INSERT INTO `sm_item_options` VALUES (3554, '促进生长发育', NULL, 1112, '2025-04-09 17:07:36', '2025-04-09 17:07:36');
INSERT INTO `sm_item_options` VALUES (3555, '不吃变质、过期食物', '1', 1113, '2025-04-09 17:08:00', '2025-04-09 17:08:00');
INSERT INTO `sm_item_options` VALUES (3556, '食物要烧熟煮透', '1', 1113, '2025-04-09 17:08:00', '2025-04-09 17:08:00');
INSERT INTO `sm_item_options` VALUES (3557, '生熟食品分开存放', '1', 1113, '2025-04-09 17:08:00', '2025-04-09 17:08:00');
INSERT INTO `sm_item_options` VALUES (3558, '保持厨房清洁卫生', '1', 1113, '2025-04-09 17:08:00', '2025-04-09 17:08:00');
INSERT INTO `sm_item_options` VALUES (3559, '增强心肺功能', '1', 1114, '2025-04-09 17:08:38', '2025-04-09 17:08:38');
INSERT INTO `sm_item_options` VALUES (3560, '提高免疫力', '1', 1114, '2025-04-09 17:08:38', '2025-04-09 17:08:38');
INSERT INTO `sm_item_options` VALUES (3561, '促进骨骼发育', '1', 1114, '2025-04-09 17:08:38', '2025-04-09 17:08:38');
INSERT INTO `sm_item_options` VALUES (3562, '缓解压力', '1', 1114, '2025-04-09 17:08:38', '2025-04-09 17:08:38');
INSERT INTO `sm_item_options` VALUES (3563, ' 食物多样，谷类为主', '1', 1115, '2025-04-09 17:09:50', '2025-04-09 17:09:50');
INSERT INTO `sm_item_options` VALUES (3564, '多吃蔬菜水果和薯类', '1', 1115, '2025-04-09 17:09:50', '2025-04-09 17:09:50');
INSERT INTO `sm_item_options` VALUES (3565, '适量吃鱼、禽、蛋、瘦肉', '1', 1115, '2025-04-09 17:09:50', '2025-04-09 17:09:50');
INSERT INTO `sm_item_options` VALUES (3566, '少盐少油，控糖限酒', '1', 1115, '2025-04-09 17:09:50', '2025-04-09 17:09:50');
INSERT INTO `sm_item_options` VALUES (3567, '情绪稳定、积极乐观', '1', 1116, '2025-04-09 17:16:21', '2025-04-09 17:16:21');
INSERT INTO `sm_item_options` VALUES (3568, '能适应环境变化', '1', 1116, '2025-04-09 17:16:21', '2025-04-09 17:16:21');
INSERT INTO `sm_item_options` VALUES (3569, '有良好的人际关系', '1', 1116, '2025-04-09 17:16:21', '2025-04-09 17:16:21');
INSERT INTO `sm_item_options` VALUES (3570, '有一定的学习和工作能力', '1', 1116, '2025-04-09 17:16:21', '2025-04-09 17:16:21');
INSERT INTO `sm_item_options` VALUES (3571, '一尺（33 厘米左右）', '1', 1117, '2025-04-09 17:16:53', '2025-04-09 17:16:53');
INSERT INTO `sm_item_options` VALUES (3572, '7 - 8', '1', 1118, '2025-04-09 17:17:17', '2025-04-09 17:17:17');
INSERT INTO `sm_item_options` VALUES (3573, '易感人群', '1', 1119, '2025-04-09 17:18:17', '2025-04-09 17:18:17');
INSERT INTO `sm_item_options` VALUES (3574, '正确', NULL, 1120, '2025-04-09 17:18:44', '2025-04-09 17:18:44');
INSERT INTO `sm_item_options` VALUES (3575, '错误', '1', 1120, '2025-04-09 17:18:44', '2025-04-09 17:18:44');
INSERT INTO `sm_item_options` VALUES (3576, '正确', '1', 1121, '2025-04-09 17:18:54', '2025-04-09 17:18:54');
INSERT INTO `sm_item_options` VALUES (3577, '错误', NULL, 1121, '2025-04-09 17:18:54', '2025-04-09 17:18:54');
INSERT INTO `sm_item_options` VALUES (3578, '正确', NULL, 1122, '2025-04-09 17:19:02', '2025-04-09 17:19:02');
INSERT INTO `sm_item_options` VALUES (3579, '错误', '1', 1122, '2025-04-09 17:19:02', '2025-04-09 17:19:02');
INSERT INTO `sm_item_options` VALUES (3580, '正确', NULL, 1123, '2025-04-09 17:19:16', '2025-04-09 17:19:16');
INSERT INTO `sm_item_options` VALUES (3581, '错误', '1', 1123, '2025-04-09 17:19:16', '2025-04-09 17:19:16');
INSERT INTO `sm_item_options` VALUES (3582, '正确', NULL, 1124, '2025-04-09 17:19:23', '2025-04-09 17:19:23');
INSERT INTO `sm_item_options` VALUES (3583, '错误', '1', 1124, '2025-04-09 17:19:23', '2025-04-09 17:19:23');
INSERT INTO `sm_item_options` VALUES (3584, '控制传染源，如对传染病患者早发现、早诊断、早隔离、早治疗，对病原携带者进行管理；切断传播途径，根据不同传染病传播方式采取相应措施，如空气传播疾病加强通风、消化道传播疾病注意饮食卫生等；保护易感人群，通过接种疫苗、加强锻炼、合理营养等提高人群免疫力。', '1', 1125, '2025-04-09 17:52:59', '2025-04-09 17:52:59');
INSERT INTO `sm_item_options` VALUES (3585, '合理饮食提供身体所需能量和营养素，维持正常生理功能；有助于预防营养不良、肥胖、糖尿病、心血管疾病等；促进生长发育，提高免疫力，保持良好身体状态。', '1', 1126, '2025-04-09 17:52:56', '2025-04-09 17:52:56');
INSERT INTO `sm_item_options` VALUES (3586, '运动减压，如跑步、瑜伽；放松训练，如深呼吸、冥想；兴趣爱好减压，如绘画、听音乐（答案不唯一）。', '1', 1127, '2025-04-09 17:52:54', '2025-04-09 17:52:54');
INSERT INTO `sm_item_options` VALUES (3587, '急性胆囊炎', NULL, 1128, '2025-04-09 17:28:11', '2025-04-09 17:28:11');
INSERT INTO `sm_item_options` VALUES (3588, '急性胰腺炎', NULL, 1128, '2025-04-09 17:28:11', '2025-04-09 17:28:11');
INSERT INTO `sm_item_options` VALUES (3589, '急性阑尾炎', '1', 1128, '2025-04-09 17:28:11', '2025-04-09 17:28:11');
INSERT INTO `sm_item_options` VALUES (3590, '急性胃炎', NULL, 1128, '2025-04-09 17:28:11', '2025-04-09 17:28:11');
INSERT INTO `sm_item_options` VALUES (3591, '子宫肌瘤', '1', 1129, '2025-04-09 17:28:45', '2025-04-09 17:28:45');
INSERT INTO `sm_item_options` VALUES (3592, '子宫内膜癌', NULL, 1129, '2025-04-09 17:28:45', '2025-04-09 17:28:45');
INSERT INTO `sm_item_options` VALUES (3593, '子宫腺肌病', NULL, 1129, '2025-04-09 17:28:45', '2025-04-09 17:28:45');
INSERT INTO `sm_item_options` VALUES (3594, '卵巢囊肿', NULL, 1129, '2025-04-09 17:28:45', '2025-04-09 17:28:45');
INSERT INTO `sm_item_options` VALUES (3595, '抗感染治疗', '1', 1130, '2025-04-09 17:29:25', '2025-04-09 17:29:25');
INSERT INTO `sm_item_options` VALUES (3596, '对症治疗，如止咳、化痰、平喘', '1', 1130, '2025-04-09 17:29:25', '2025-04-09 17:29:25');
INSERT INTO `sm_item_options` VALUES (3597, '保持呼吸道通畅', '1', 1130, '2025-04-09 17:29:25', '2025-04-09 17:29:25');
INSERT INTO `sm_item_options` VALUES (3598, '营养支持', '1', 1130, '2025-04-09 17:29:25', '2025-04-09 17:29:25');
INSERT INTO `sm_item_options` VALUES (3599, '上腹部疼痛，多在进食后半小时至 1 小时出现', '1', 1131, '2025-04-09 17:29:56', '2025-04-09 17:29:56');
INSERT INTO `sm_item_options` VALUES (3600, '疼痛具有节律性，进食 - 疼痛 - 缓解', '1', 1131, '2025-04-09 17:29:56', '2025-04-09 17:29:56');
INSERT INTO `sm_item_options` VALUES (3601, '胃镜检查发现胃黏膜溃疡病灶', '1', 1131, '2025-04-09 17:29:56', '2025-04-09 17:29:56');
INSERT INTO `sm_item_options` VALUES (3602, '幽门螺杆菌检测阳性', NULL, 1131, '2025-04-09 17:29:56', '2025-04-09 17:29:56');
INSERT INTO `sm_item_options` VALUES (3603, '胸痛持续时间长，多超过 30 分钟', '1', 1132, '2025-04-09 17:30:26', '2025-04-09 17:30:26');
INSERT INTO `sm_item_options` VALUES (3604, '可伴有出汗、恶心、呕吐等症状', '1', 1132, '2025-04-09 17:30:26', '2025-04-09 17:30:26');
INSERT INTO `sm_item_options` VALUES (3605, '心电图有特征性改变', '1', 1132, '2025-04-09 17:30:26', '2025-04-09 17:30:26');
INSERT INTO `sm_item_options` VALUES (3606, '心肌损伤标志物升高', '1', 1132, '2025-04-09 17:30:26', '2025-04-09 17:30:26');
INSERT INTO `sm_item_options` VALUES (3607, '腰大肌', '1', 1133, '2025-04-09 17:30:47', '2025-04-09 17:30:47');
INSERT INTO `sm_item_options` VALUES (3608, '血肿炎症机化', '1', 1134, '2025-04-09 17:31:02', '2025-04-09 17:31:02');
INSERT INTO `sm_item_options` VALUES (3609, '2 - 12 ；24 - 48', '1', 1135, '2025-04-09 17:31:13', '2025-04-09 17:31:13');
INSERT INTO `sm_item_options` VALUES (3611, '稀薄脓性、黄绿色、泡沫状、有臭味', '1', 1137, '2025-04-09 17:32:38', '2025-04-09 17:32:38');
INSERT INTO `sm_item_options` VALUES (3612, '正确', NULL, 1138, '2025-04-09 17:32:52', '2025-04-09 17:32:52');
INSERT INTO `sm_item_options` VALUES (3613, '错误', '1', 1138, '2025-04-09 17:32:52', '2025-04-09 17:32:52');
INSERT INTO `sm_item_options` VALUES (3614, '正确', NULL, 1139, '2025-04-09 17:33:37', '2025-04-09 17:33:37');
INSERT INTO `sm_item_options` VALUES (3615, '错误', '1', 1139, '2025-04-09 17:33:37', '2025-04-09 17:33:37');
INSERT INTO `sm_item_options` VALUES (3616, '立即让患者卧床休息，保持安静；呼叫急救人员，等待期间可给予患者舌下含服硝酸甘油；若患者出现心跳呼吸骤停，立即进行心肺复苏；持续监测患者生命体征，如心率、血压、呼吸等；有条件可吸氧。', '1', 1140, '2025-04-09 17:51:02', '2025-04-09 17:51:02');
INSERT INTO `sm_item_options` VALUES (3617, '①血管紧张素转换酶抑制剂（ACEI），如卡托普利；②血管紧张素 Ⅱ 受体拮抗剂（ARB），如氯沙坦；③钙通道阻滞剂，如硝苯地平（答案不唯一，还可列举 β 受体阻滞剂、利尿剂等）。', '1', 1141, '2025-04-09 17:51:04', '2025-04-09 17:51:04');
INSERT INTO `sm_item_options` VALUES (3618, '将患儿平放，头偏向一侧，防止呕吐物误吸；解开衣领，保持呼吸道通畅；用温水擦拭患儿额头、腋窝、腹股沟等部位进行物理降温；避免强行按压患儿肢体，防止受伤；若惊厥持续不缓解，立即送往医院。', '1', 1142, '2025-04-09 17:51:07', '2025-04-09 17:51:07');
INSERT INTO `sm_item_options` VALUES (3619, '呼吸停止', NULL, 1143, '2025-04-09 17:36:54', '2025-04-09 17:36:54');
INSERT INTO `sm_item_options` VALUES (3620, '血压测不出', NULL, 1143, '2025-04-09 17:36:54', '2025-04-09 17:36:54');
INSERT INTO `sm_item_options` VALUES (3621, '意识消失且大动脉搏动消失', '1', 1143, '2025-04-09 17:36:54', '2025-04-09 17:36:54');
INSERT INTO `sm_item_options` VALUES (3622, '瞳孔散大', NULL, 1143, '2025-04-09 17:36:54', '2025-04-09 17:36:54');
INSERT INTO `sm_item_options` VALUES (3623, '胸骨上 1/3 段', NULL, 1144, '2025-04-09 17:37:22', '2025-04-09 17:37:22');
INSERT INTO `sm_item_options` VALUES (3624, '胸骨中、下 1/3 交界处', '1', 1144, '2025-04-09 17:37:22', '2025-04-09 17:37:22');
INSERT INTO `sm_item_options` VALUES (3625, '剑突下', NULL, 1144, '2025-04-09 17:37:22', '2025-04-09 17:37:22');
INSERT INTO `sm_item_options` VALUES (3626, '胸骨左旁第四肋间', NULL, 1144, '2025-04-09 17:37:22', '2025-04-09 17:37:22');
INSERT INTO `sm_item_options` VALUES (3627, '将骨折断端送回伤口内', NULL, 1145, '2025-04-09 17:40:04', '2025-04-09 17:40:04');
INSERT INTO `sm_item_options` VALUES (3628, '用干净纱布覆盖伤口', '1', 1145, '2025-04-09 17:40:04', '2025-04-09 17:40:04');
INSERT INTO `sm_item_options` VALUES (3629, '立即对骨折部位进行复位', NULL, 1145, '2025-04-09 17:40:04', '2025-04-09 17:40:04');
INSERT INTO `sm_item_options` VALUES (3630, '直接用绷带包扎骨折部位', NULL, 1145, '2025-04-09 17:40:04', '2025-04-09 17:40:04');
INSERT INTO `sm_item_options` VALUES (3631, '胸骨上窝', NULL, 1146, '2025-04-09 17:40:30', '2025-04-09 17:40:30');
INSERT INTO `sm_item_options` VALUES (3632, '脐上两横指处', '1', 1146, '2025-04-09 17:40:30', '2025-04-09 17:40:30');
INSERT INTO `sm_item_options` VALUES (3633, '剑突下', NULL, 1146, '2025-04-09 17:40:30', '2025-04-09 17:40:30');
INSERT INTO `sm_item_options` VALUES (3634, '锁骨上窝', NULL, 1146, '2025-04-09 17:40:30', '2025-04-09 17:40:30');
INSERT INTO `sm_item_options` VALUES (3635, '可触及大动脉搏动', '1', 1147, '2025-04-09 17:41:22', '2025-04-09 17:41:22');
INSERT INTO `sm_item_options` VALUES (3636, '恢复自主呼吸', '1', 1147, '2025-04-09 17:41:22', '2025-04-09 17:41:22');
INSERT INTO `sm_item_options` VALUES (3637, '瞳孔由大变小', '1', 1147, '2025-04-09 17:41:22', '2025-04-09 17:41:22');
INSERT INTO `sm_item_options` VALUES (3638, '面色、口唇、甲床等颜色转为红润', '1', 1147, '2025-04-09 17:41:22', '2025-04-09 17:41:22');
INSERT INTO `sm_item_options` VALUES (3639, '迅速脱离热源', '1', 1148, '2025-04-09 17:41:59', '2025-04-09 17:41:59');
INSERT INTO `sm_item_options` VALUES (3640, '用大量流动清水冲洗烧伤部位', '1', 1148, '2025-04-09 17:41:59', '2025-04-09 17:41:59');
INSERT INTO `sm_item_options` VALUES (3641, '剪开受伤部位的衣物', '1', 1148, '2025-04-09 17:41:59', '2025-04-09 17:41:59');
INSERT INTO `sm_item_options` VALUES (3642, '大面积烧伤患者尽快口服大量白开水补充水分', NULL, 1148, '2025-04-09 17:41:59', '2025-04-09 17:41:59');
INSERT INTO `sm_item_options` VALUES (3643, '看胸廓有无起伏', '1', 1149, '2025-04-09 17:42:38', '2025-04-09 17:42:38');
INSERT INTO `sm_item_options` VALUES (3644, '听有无呼吸音', '1', 1149, '2025-04-09 17:42:38', '2025-04-09 17:42:38');
INSERT INTO `sm_item_options` VALUES (3645, '感觉有无气流吹拂脸颊', '1', 1149, '2025-04-09 17:42:38', '2025-04-09 17:42:38');
INSERT INTO `sm_item_options` VALUES (3646, '观察患者口唇颜色', NULL, 1149, '2025-04-09 17:42:38', '2025-04-09 17:42:38');
INSERT INTO `sm_item_options` VALUES (3647, '动脉出血', '1', 1150, '2025-04-09 17:43:11', '2025-04-09 17:43:11');
INSERT INTO `sm_item_options` VALUES (3648, '静脉出血', '1', 1150, '2025-04-09 17:43:11', '2025-04-09 17:43:11');
INSERT INTO `sm_item_options` VALUES (3649, '毛细血管出血', NULL, 1150, '2025-04-09 17:43:11', '2025-04-09 17:43:11');
INSERT INTO `sm_item_options` VALUES (3650, '鼻出血', NULL, 1150, '2025-04-09 17:43:11', '2025-04-09 17:43:11');
INSERT INTO `sm_item_options` VALUES (3651, '开放气道', '1', 1151, '2025-04-09 17:43:35', '2025-04-09 17:43:35');
INSERT INTO `sm_item_options` VALUES (3652, '加压包扎止血法', NULL, 1152, '2025-04-09 17:43:47', '2025-04-09 17:43:47');
INSERT INTO `sm_item_options` VALUES (3653, '疼痛和周围组织损伤', '1', 1153, '2025-04-09 17:44:01', '2025-04-09 17:44:01');
INSERT INTO `sm_item_options` VALUES (3654, '阴凉', '1', 1154, '2025-04-09 17:44:10', '2025-04-09 17:44:10');
INSERT INTO `sm_item_options` VALUES (3655, '迅速切断电源', '1', 1155, '2025-04-09 17:44:19', '2025-04-09 17:44:19');
INSERT INTO `sm_item_options` VALUES (3656, '正确', NULL, 1156, '2025-04-09 17:44:34', '2025-04-09 17:44:34');
INSERT INTO `sm_item_options` VALUES (3657, '错误', '1', 1156, '2025-04-09 17:44:34', '2025-04-09 17:44:34');
INSERT INTO `sm_item_options` VALUES (3658, '正确', NULL, 1157, '2025-04-09 17:44:45', '2025-04-09 17:44:45');
INSERT INTO `sm_item_options` VALUES (3659, '错误', '1', 1157, '2025-04-09 17:44:45', '2025-04-09 17:44:45');
INSERT INTO `sm_item_options` VALUES (3660, '正确', '1', 1158, '2025-04-09 17:44:53', '2025-04-09 17:44:53');
INSERT INTO `sm_item_options` VALUES (3661, '错误', NULL, 1158, '2025-04-09 17:44:53', '2025-04-09 17:44:53');
INSERT INTO `sm_item_options` VALUES (3662, '施救者站在患者身后，双脚前后分开，前脚距离患者约一脚宽，后脚脚跟踮起。让患者坐在自己弓起的大腿上，保持患者身体前倾、头略低、嘴张开。双臂环绕患者腹部，一手握拳，拇指顶住患者脐上两横指处、剑突下方，另一手抓住握拳手，急速且有力地向内、向上冲击患者上腹部，约每秒 1 次，重复操作直至异物排出或患者恢复呼吸', '1', 1159, '2025-04-09 17:53:37', '2025-04-09 17:53:37');
INSERT INTO `sm_item_options` VALUES (3663, '按压位置要准确，在胸骨中、下 1/3 交界处；按压时双手掌根重叠，手指翘起不接触胸壁；按压频率保持 100 - 120 次 / 分钟；按压深度成人约 5 - 6 厘米，儿童约 5 厘米，婴儿约 4 厘米；按压应平稳、规律，避免冲击式按压；按压与放松时间大致相等，放松时手掌根部不离开胸壁；尽量减少按压中断，如需中断，时间不超过 10 秒。​', '1', 1160, '2025-04-09 17:53:34', '2025-04-09 17:53:34');
INSERT INTO `sm_item_options` VALUES (3664, '①指压止血法，适用于头部、四肢等部位的动脉出血，可通过按压出血动脉的近心端暂时止血；②加压包扎止血法，适用于各种伤口出血，尤其是静脉和毛细血管出血，通过在伤口覆盖多层纱布等敷料后加压包扎止血；③止血带止血法，适用于四肢大动脉出血，且其他止血方法难以控制时，但使用止血带时间不宜过长，以免肢体缺血坏死。', '1', 1161, '2025-04-09 17:53:31', '2025-04-09 17:53:31');
INSERT INTO `sm_item_options` VALUES (3665, '5', '1', 1162, '2025-04-09 18:01:58', '2025-04-09 18:01:58');
INSERT INTO `sm_item_options` VALUES (3666, '1', '1', 1163, '2025-04-09 22:37:04', '2025-04-09 22:37:04');
INSERT INTO `sm_item_options` VALUES (3667, '2', NULL, 1163, '2025-04-09 22:37:04', '2025-04-09 22:37:04');
INSERT INTO `sm_item_options` VALUES (3668, '3', NULL, 1163, '2025-04-09 22:37:04', '2025-04-09 22:37:04');
INSERT INTO `sm_item_options` VALUES (3669, '4', NULL, 1163, '2025-04-09 22:37:04', '2025-04-09 22:37:04');
INSERT INTO `sm_item_options` VALUES (3674, '以上都对', NULL, 101, '2025-04-10 11:01:55', '2025-04-10 11:01:55');
INSERT INTO `sm_item_options` VALUES (3681, '1', '1', 1167, '2025-04-10 15:51:04', '2025-04-10 15:51:04');
INSERT INTO `sm_item_options` VALUES (3682, '2', NULL, 1167, '2025-04-10 15:51:04', '2025-04-10 15:51:04');
INSERT INTO `sm_item_options` VALUES (3683, '3', NULL, 1167, '2025-04-10 15:51:04', '2025-04-10 15:51:04');
INSERT INTO `sm_item_options` VALUES (3684, '4', NULL, 1167, '2025-04-10 15:51:04', '2025-04-10 15:51:04');

-- ----------------------------
-- Table structure for sm_note
-- ----------------------------
DROP TABLE IF EXISTS `sm_note`;
CREATE TABLE `sm_note`  (
  `note_id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `course_id` int UNSIGNED NULL DEFAULT NULL,
  `chapter_id` int UNSIGNED NULL DEFAULT NULL,
  `note_content` varchar(3000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `note_time` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `time_create` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `time_modify` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`note_id`) USING BTREE,
  INDEX `course_id`(`course_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `chapter_id`(`chapter_id`) USING BTREE,
  CONSTRAINT `sm_note_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `sm_courses` (`course_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sm_note_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `sm_users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sm_note_ibfk_3` FOREIGN KEY (`chapter_id`) REFERENCES `sm_chapters` (`chapter_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1133 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sm_note
-- ----------------------------
INSERT INTO `sm_note` VALUES (1122, '7bdc4b7c11524a42851dfd2283cbf9c1', 1000, 1000, '按照国家免疫规划程序按时接种疫苗，这是预防传染病最有效、最经济的措施。', '0:04', '2025-04-09 14:36:50', '2025-04-09 14:36:50');
INSERT INTO `sm_note` VALUES (1123, '7bdc4b7c11524a42851dfd2283cbf9c1', 1000, 1000, '学前儿童免疫系统发育尚未完善，免疫力相对较低，易患各种感染性疾病。但随着年龄增长，通过接触各种病原体，免疫系统逐渐得到锻炼和完善。', '0:15', '2025-04-09 14:37:08', '2025-04-09 14:37:08');
INSERT INTO `sm_note` VALUES (1126, '7d9030e8cb5841c288c7d8b2412b97cc', 1003, 1007, '如何预防心血管疾病', '0:07', '2025-04-09 17:18:43', '2025-04-09 17:18:43');
INSERT INTO `sm_note` VALUES (1128, '3726d7f8325b4fe6ad281755bb61fa16', 1000, 1005, '学前儿童每餐都要摄入一定量的碳水化合物', '0:12', '2025-04-09 23:52:20', '2025-04-09 23:52:20');
INSERT INTO `sm_note` VALUES (1129, '3726d7f8325b4fe6ad281755bb61fa16', 1000, 1005, '婴幼儿要多喝白开水，可减少泌尿道感染', '0:23', '2025-04-09 23:53:06', '2025-04-09 23:53:06');
INSERT INTO `sm_note` VALUES (1130, '7d9030e8cb5841c288c7d8b2412b97cc', 1000, 1000, '神经系统发育特点：脑发育迅速、神经细胞分化在胎儿期完成、高级神经活动抑制过程不完善。', '0:05', '2025-04-10 10:46:54', '2025-04-10 10:46:54');
INSERT INTO `sm_note` VALUES (1131, '7d9030e8cb5841c288c7d8b2412b97cc', 1000, 1000, '消化系统有关保健措施：注意口腔卫生、合理安排饮食、培养良好饮食习惯、预防消化系统疾病', '0:08', '2025-04-10 09:35:29', '2025-04-10 09:35:29');
INSERT INTO `sm_note` VALUES (1132, '7d9030e8cb5841c288c7d8b2412b97cc', 1000, 1000, '要加强体育锻炼', '0:16', '2025-04-10 09:36:09', '2025-04-10 09:36:09');
INSERT INTO `sm_note` VALUES (1133, '7d9030e8cb5841c288c7d8b2412b97cc', 1000, 1000, '重点：关节和韧带：关节窝较浅，关节囊和韧带较松弛，关节的牢固性较差，易发生脱臼。', '0:20', '2025-04-10 10:46:01', '2025-04-10 10:46:01');
INSERT INTO `sm_note` VALUES (1134, '7d9030e8cb5841c288c7d8b2412b97cc', 1000, 1000, '免疫系统功能不完善：故对病原体的抵抗力较低，易患各种感染性疾病。', '0:22', '2025-04-10 09:38:44', '2025-04-10 09:38:44');
INSERT INTO `sm_note` VALUES (1135, '7d9030e8cb5841c288c7d8b2412b97cc', 1000, 1005, '宏量营养素：蛋白质、碳水化合物、脂肪', '0:06', '2025-04-10 09:53:53', '2025-04-10 09:53:53');
INSERT INTO `sm_note` VALUES (1136, '7d9030e8cb5841c288c7d8b2412b97cc', 1000, 1005, '微量营养素​包括矿物质和维生素', '0:20', '2025-04-10 09:54:36', '2025-04-10 09:54:36');
INSERT INTO `sm_note` VALUES (1137, '7d9030e8cb5841c288c7d8b2412b97cc', 1000, 1005, '矿物质：钙：选牛奶、豆制品、绿叶菜。', '0:29', '2025-04-10 09:55:04', '2025-04-10 09:55:04');
INSERT INTO `sm_note` VALUES (1138, '7d9030e8cb5841c288c7d8b2412b97cc', 1000, 1005, '矿物质：锌：选海鲜、肉类、豆类。', '0:33', '2025-04-10 09:55:18', '2025-04-10 09:55:18');
INSERT INTO `sm_note` VALUES (1139, '7d9030e8cb5841c288c7d8b2412b97cc', 1000, 1091, 'ok', '0:19', '2025-04-10 09:55:38', '2025-04-10 09:55:38');
INSERT INTO `sm_note` VALUES (1140, '7d9030e8cb5841c288c7d8b2412b97cc', 1000, 1005, '矿物质：铁：选动物肝脏、红肉、豆类。', '0:39', '2025-04-10 09:55:45', '2025-04-10 09:55:45');
INSERT INTO `sm_note` VALUES (1141, '7d9030e8cb5841c288c7d8b2412b97cc', 1000, 1005, '维生素：A、C、D', '0:48', '2025-04-10 09:56:09', '2025-04-10 09:56:09');
INSERT INTO `sm_note` VALUES (1142, '7d9030e8cb5841c288c7d8b2412b97cc', 1000, 1000, '不嘻嘻', '0:18', '2025-04-10 13:28:30', '2025-04-10 13:28:30');
INSERT INTO `sm_note` VALUES (1143, '7d9030e8cb5841c288c7d8b2412b97cc', 1000, 1091, 'ok', '0:00', '2025-04-10 15:44:44', '2025-04-10 15:44:44');

-- ----------------------------
-- Table structure for sm_papers
-- ----------------------------
DROP TABLE IF EXISTS `sm_papers`;
CREATE TABLE `sm_papers`  (
  `paper_id` int UNSIGNED NOT NULL,
  `item_id` int UNSIGNED NOT NULL,
  `time_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `time_modify` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`paper_id`, `item_id`) USING BTREE,
  INDEX `item_id`(`item_id`) USING BTREE,
  CONSTRAINT `sm_papers_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `sm_item_bank` (`item_id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `sm_papers_ibfk_2` FOREIGN KEY (`paper_id`) REFERENCES `sm_papers_info` (`paper_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sm_papers
-- ----------------------------
INSERT INTO `sm_papers` VALUES (27, 112, '2025-04-10 13:59:46', '2025-04-10 13:59:46');
INSERT INTO `sm_papers` VALUES (27, 1005, '2025-04-10 13:59:46', '2025-04-10 13:59:46');
INSERT INTO `sm_papers` VALUES (27, 1008, '2025-04-10 13:59:46', '2025-04-10 13:59:46');
INSERT INTO `sm_papers` VALUES (27, 1009, '2025-04-10 13:59:46', '2025-04-10 13:59:46');
INSERT INTO `sm_papers` VALUES (27, 1010, '2025-04-10 13:59:46', '2025-04-10 13:59:46');
INSERT INTO `sm_papers` VALUES (27, 1162, '2025-04-10 13:59:46', '2025-04-10 13:59:46');
INSERT INTO `sm_papers` VALUES (28, 1013, '2025-04-09 18:00:04', '2025-04-09 18:00:04');
INSERT INTO `sm_papers` VALUES (28, 1014, '2025-04-09 18:00:04', '2025-04-09 18:00:04');
INSERT INTO `sm_papers` VALUES (28, 1015, '2025-04-09 18:00:04', '2025-04-09 18:00:04');
INSERT INTO `sm_papers` VALUES (28, 1016, '2025-04-09 18:00:04', '2025-04-09 18:00:04');
INSERT INTO `sm_papers` VALUES (28, 1017, '2025-04-09 18:00:04', '2025-04-09 18:00:04');
INSERT INTO `sm_papers` VALUES (28, 1018, '2025-04-09 18:00:04', '2025-04-09 18:00:04');
INSERT INTO `sm_papers` VALUES (28, 1019, '2025-04-09 18:00:04', '2025-04-09 18:00:04');
INSERT INTO `sm_papers` VALUES (28, 1020, '2025-04-09 18:00:04', '2025-04-09 18:00:04');
INSERT INTO `sm_papers` VALUES (28, 1021, '2025-04-09 18:00:04', '2025-04-09 18:00:04');
INSERT INTO `sm_papers` VALUES (28, 1022, '2025-04-09 18:00:04', '2025-04-09 18:00:04');
INSERT INTO `sm_papers` VALUES (28, 1023, '2025-04-09 18:00:04', '2025-04-09 18:00:04');
INSERT INTO `sm_papers` VALUES (28, 1024, '2025-04-09 18:00:04', '2025-04-09 18:00:04');
INSERT INTO `sm_papers` VALUES (28, 1025, '2025-04-09 18:00:04', '2025-04-09 18:00:04');
INSERT INTO `sm_papers` VALUES (28, 1026, '2025-04-09 18:00:04', '2025-04-09 18:00:04');
INSERT INTO `sm_papers` VALUES (29, 1028, '2025-04-09 17:50:15', '2025-04-09 17:50:15');
INSERT INTO `sm_papers` VALUES (29, 1029, '2025-04-09 17:50:15', '2025-04-09 17:50:15');
INSERT INTO `sm_papers` VALUES (29, 1030, '2025-04-09 17:50:15', '2025-04-09 17:50:15');
INSERT INTO `sm_papers` VALUES (29, 1034, '2025-04-09 17:50:15', '2025-04-09 17:50:15');
INSERT INTO `sm_papers` VALUES (29, 1035, '2025-04-09 17:50:15', '2025-04-09 17:50:15');
INSERT INTO `sm_papers` VALUES (29, 1036, '2025-04-09 17:50:15', '2025-04-09 17:50:15');
INSERT INTO `sm_papers` VALUES (29, 1129, '2025-04-09 17:50:15', '2025-04-09 17:50:15');
INSERT INTO `sm_papers` VALUES (29, 1132, '2025-04-09 17:50:15', '2025-04-09 17:50:15');
INSERT INTO `sm_papers` VALUES (29, 1133, '2025-04-09 17:50:15', '2025-04-09 17:50:15');
INSERT INTO `sm_papers` VALUES (29, 1140, '2025-04-09 17:50:15', '2025-04-09 17:50:15');
INSERT INTO `sm_papers` VALUES (31, 106, '2025-04-09 18:04:13', '2025-04-09 18:04:13');
INSERT INTO `sm_papers` VALUES (31, 107, '2025-04-09 18:04:13', '2025-04-09 18:04:13');
INSERT INTO `sm_papers` VALUES (31, 109, '2025-04-09 18:04:13', '2025-04-09 18:04:13');
INSERT INTO `sm_papers` VALUES (31, 1143, '2025-04-09 18:04:13', '2025-04-09 18:04:13');
INSERT INTO `sm_papers` VALUES (31, 1144, '2025-04-09 18:04:13', '2025-04-09 18:04:13');
INSERT INTO `sm_papers` VALUES (31, 1147, '2025-04-09 18:04:13', '2025-04-09 18:04:13');
INSERT INTO `sm_papers` VALUES (31, 1148, '2025-04-09 18:04:13', '2025-04-09 18:04:13');
INSERT INTO `sm_papers` VALUES (31, 1151, '2025-04-09 18:04:13', '2025-04-09 18:04:13');
INSERT INTO `sm_papers` VALUES (31, 1152, '2025-04-09 18:04:13', '2025-04-09 18:04:13');
INSERT INTO `sm_papers` VALUES (31, 1156, '2025-04-09 18:04:13', '2025-04-09 18:04:13');
INSERT INTO `sm_papers` VALUES (31, 1157, '2025-04-09 18:04:13', '2025-04-09 18:04:13');
INSERT INTO `sm_papers` VALUES (31, 1160, '2025-04-09 18:04:13', '2025-04-09 18:04:13');
INSERT INTO `sm_papers` VALUES (31, 1161, '2025-04-09 18:04:13', '2025-04-09 18:04:13');
INSERT INTO `sm_papers` VALUES (32, 111, '2025-04-09 17:54:23', '2025-04-09 17:54:23');
INSERT INTO `sm_papers` VALUES (32, 112, '2025-04-09 17:54:23', '2025-04-09 17:54:23');
INSERT INTO `sm_papers` VALUES (32, 113, '2025-04-09 17:54:23', '2025-04-09 17:54:23');
INSERT INTO `sm_papers` VALUES (32, 114, '2025-04-09 17:54:23', '2025-04-09 17:54:23');
INSERT INTO `sm_papers` VALUES (32, 115, '2025-04-09 17:54:23', '2025-04-09 17:54:23');
INSERT INTO `sm_papers` VALUES (32, 1056, '2025-04-09 17:54:23', '2025-04-09 17:54:23');
INSERT INTO `sm_papers` VALUES (32, 1060, '2025-04-09 17:54:23', '2025-04-09 17:54:23');
INSERT INTO `sm_papers` VALUES (32, 1061, '2025-04-09 17:54:23', '2025-04-09 17:54:23');
INSERT INTO `sm_papers` VALUES (32, 1063, '2025-04-09 17:54:23', '2025-04-09 17:54:23');
INSERT INTO `sm_papers` VALUES (32, 1064, '2025-04-09 17:54:23', '2025-04-09 17:54:23');
INSERT INTO `sm_papers` VALUES (32, 1065, '2025-04-09 17:54:23', '2025-04-09 17:54:23');
INSERT INTO `sm_papers` VALUES (33, 116, '2025-04-09 17:55:03', '2025-04-09 17:55:03');
INSERT INTO `sm_papers` VALUES (33, 117, '2025-04-09 17:55:03', '2025-04-09 17:55:03');
INSERT INTO `sm_papers` VALUES (33, 118, '2025-04-09 17:55:03', '2025-04-09 17:55:03');
INSERT INTO `sm_papers` VALUES (33, 119, '2025-04-09 17:55:03', '2025-04-09 17:55:03');
INSERT INTO `sm_papers` VALUES (33, 120, '2025-04-09 17:55:03', '2025-04-09 17:55:03');
INSERT INTO `sm_papers` VALUES (34, 1066, '2025-04-09 17:55:24', '2025-04-09 17:55:24');
INSERT INTO `sm_papers` VALUES (34, 1067, '2025-04-09 17:55:24', '2025-04-09 17:55:24');
INSERT INTO `sm_papers` VALUES (34, 1068, '2025-04-09 17:55:24', '2025-04-09 17:55:24');
INSERT INTO `sm_papers` VALUES (34, 1069, '2025-04-09 17:55:24', '2025-04-09 17:55:24');
INSERT INTO `sm_papers` VALUES (34, 1070, '2025-04-09 17:55:24', '2025-04-09 17:55:24');
INSERT INTO `sm_papers` VALUES (34, 1071, '2025-04-09 17:55:24', '2025-04-09 17:55:24');
INSERT INTO `sm_papers` VALUES (34, 1072, '2025-04-09 17:55:24', '2025-04-09 17:55:24');
INSERT INTO `sm_papers` VALUES (34, 1073, '2025-04-09 17:55:24', '2025-04-09 17:55:24');
INSERT INTO `sm_papers` VALUES (34, 1074, '2025-04-09 17:55:24', '2025-04-09 17:55:24');
INSERT INTO `sm_papers` VALUES (34, 1075, '2025-04-09 17:55:24', '2025-04-09 17:55:24');
INSERT INTO `sm_papers` VALUES (34, 1076, '2025-04-09 17:55:24', '2025-04-09 17:55:24');
INSERT INTO `sm_papers` VALUES (34, 1077, '2025-04-09 17:55:24', '2025-04-09 17:55:24');
INSERT INTO `sm_papers` VALUES (35, 118, '2025-04-09 17:56:07', '2025-04-09 17:56:07');
INSERT INTO `sm_papers` VALUES (35, 1031, '2025-04-09 17:56:07', '2025-04-09 17:56:07');
INSERT INTO `sm_papers` VALUES (35, 1036, '2025-04-09 17:56:07', '2025-04-09 17:56:07');
INSERT INTO `sm_papers` VALUES (36, 1027, '2025-04-09 17:56:43', '2025-04-09 17:56:43');
INSERT INTO `sm_papers` VALUES (36, 1029, '2025-04-09 17:56:43', '2025-04-09 17:56:43');
INSERT INTO `sm_papers` VALUES (36, 1030, '2025-04-09 17:56:43', '2025-04-09 17:56:43');
INSERT INTO `sm_papers` VALUES (36, 1031, '2025-04-09 17:56:43', '2025-04-09 17:56:43');
INSERT INTO `sm_papers` VALUES (36, 1032, '2025-04-09 17:56:43', '2025-04-09 17:56:43');
INSERT INTO `sm_papers` VALUES (36, 1033, '2025-04-09 17:56:43', '2025-04-09 17:56:43');
INSERT INTO `sm_papers` VALUES (36, 1035, '2025-04-09 17:56:43', '2025-04-09 17:56:43');
INSERT INTO `sm_papers` VALUES (36, 1036, '2025-04-09 17:56:43', '2025-04-09 17:56:43');
INSERT INTO `sm_papers` VALUES (36, 1037, '2025-04-09 17:56:43', '2025-04-09 17:56:43');
INSERT INTO `sm_papers` VALUES (37, 1110, '2025-04-09 17:57:29', '2025-04-09 17:57:29');
INSERT INTO `sm_papers` VALUES (37, 1111, '2025-04-09 17:57:29', '2025-04-09 17:57:29');
INSERT INTO `sm_papers` VALUES (37, 1112, '2025-04-09 17:57:29', '2025-04-09 17:57:29');
INSERT INTO `sm_papers` VALUES (37, 1113, '2025-04-09 17:57:29', '2025-04-09 17:57:29');
INSERT INTO `sm_papers` VALUES (37, 1114, '2025-04-09 17:57:29', '2025-04-09 17:57:29');
INSERT INTO `sm_papers` VALUES (37, 1115, '2025-04-09 17:57:29', '2025-04-09 17:57:29');
INSERT INTO `sm_papers` VALUES (37, 1116, '2025-04-09 17:57:29', '2025-04-09 17:57:29');
INSERT INTO `sm_papers` VALUES (37, 1117, '2025-04-09 17:57:29', '2025-04-09 17:57:29');
INSERT INTO `sm_papers` VALUES (37, 1118, '2025-04-09 17:57:29', '2025-04-09 17:57:29');
INSERT INTO `sm_papers` VALUES (37, 1119, '2025-04-09 17:57:29', '2025-04-09 17:57:29');
INSERT INTO `sm_papers` VALUES (37, 1120, '2025-04-09 17:57:29', '2025-04-09 17:57:29');
INSERT INTO `sm_papers` VALUES (37, 1121, '2025-04-09 17:57:29', '2025-04-09 17:57:29');
INSERT INTO `sm_papers` VALUES (37, 1122, '2025-04-09 17:57:29', '2025-04-09 17:57:29');
INSERT INTO `sm_papers` VALUES (37, 1123, '2025-04-09 17:57:29', '2025-04-09 17:57:29');
INSERT INTO `sm_papers` VALUES (37, 1124, '2025-04-09 17:57:29', '2025-04-09 17:57:29');
INSERT INTO `sm_papers` VALUES (37, 1125, '2025-04-09 17:57:29', '2025-04-09 17:57:29');
INSERT INTO `sm_papers` VALUES (37, 1126, '2025-04-09 17:57:29', '2025-04-09 17:57:29');
INSERT INTO `sm_papers` VALUES (37, 1127, '2025-04-09 17:57:29', '2025-04-09 17:57:29');
INSERT INTO `sm_papers` VALUES (38, 1013, '2025-04-09 17:58:54', '2025-04-09 17:58:54');
INSERT INTO `sm_papers` VALUES (38, 1014, '2025-04-09 17:58:54', '2025-04-09 17:58:54');
INSERT INTO `sm_papers` VALUES (38, 1015, '2025-04-09 17:58:54', '2025-04-09 17:58:54');
INSERT INTO `sm_papers` VALUES (38, 1016, '2025-04-09 17:58:54', '2025-04-09 17:58:54');
INSERT INTO `sm_papers` VALUES (38, 1017, '2025-04-09 17:58:54', '2025-04-09 17:58:54');
INSERT INTO `sm_papers` VALUES (38, 1018, '2025-04-09 17:58:54', '2025-04-09 17:58:54');
INSERT INTO `sm_papers` VALUES (38, 1019, '2025-04-09 17:58:54', '2025-04-09 17:58:54');
INSERT INTO `sm_papers` VALUES (38, 1020, '2025-04-09 17:58:54', '2025-04-09 17:58:54');
INSERT INTO `sm_papers` VALUES (38, 1021, '2025-04-09 17:58:54', '2025-04-09 17:58:54');
INSERT INTO `sm_papers` VALUES (38, 1022, '2025-04-09 17:58:54', '2025-04-09 17:58:54');
INSERT INTO `sm_papers` VALUES (38, 1023, '2025-04-09 17:58:54', '2025-04-09 17:58:54');
INSERT INTO `sm_papers` VALUES (38, 1024, '2025-04-09 17:58:54', '2025-04-09 17:58:54');
INSERT INTO `sm_papers` VALUES (38, 1025, '2025-04-09 17:58:54', '2025-04-09 17:58:54');
INSERT INTO `sm_papers` VALUES (38, 1026, '2025-04-09 17:58:54', '2025-04-09 17:58:54');
INSERT INTO `sm_papers` VALUES (39, 1038, '2025-04-09 18:05:14', '2025-04-09 18:05:14');
INSERT INTO `sm_papers` VALUES (39, 1039, '2025-04-09 18:05:14', '2025-04-09 18:05:14');
INSERT INTO `sm_papers` VALUES (39, 1040, '2025-04-09 18:05:14', '2025-04-09 18:05:14');
INSERT INTO `sm_papers` VALUES (39, 1041, '2025-04-09 18:05:14', '2025-04-09 18:05:14');
INSERT INTO `sm_papers` VALUES (39, 1042, '2025-04-09 18:05:14', '2025-04-09 18:05:14');
INSERT INTO `sm_papers` VALUES (39, 1043, '2025-04-09 18:05:14', '2025-04-09 18:05:14');
INSERT INTO `sm_papers` VALUES (39, 1044, '2025-04-09 18:05:14', '2025-04-09 18:05:14');
INSERT INTO `sm_papers` VALUES (39, 1045, '2025-04-09 18:05:15', '2025-04-09 18:05:15');
INSERT INTO `sm_papers` VALUES (39, 1046, '2025-04-09 18:05:15', '2025-04-09 18:05:15');
INSERT INTO `sm_papers` VALUES (39, 1047, '2025-04-09 18:05:15', '2025-04-09 18:05:15');
INSERT INTO `sm_papers` VALUES (39, 1048, '2025-04-09 18:05:15', '2025-04-09 18:05:15');
INSERT INTO `sm_papers` VALUES (39, 1049, '2025-04-09 18:05:15', '2025-04-09 18:05:15');
INSERT INTO `sm_papers` VALUES (39, 1050, '2025-04-09 18:05:15', '2025-04-09 18:05:15');
INSERT INTO `sm_papers` VALUES (39, 1051, '2025-04-09 18:05:15', '2025-04-09 18:05:15');
INSERT INTO `sm_papers` VALUES (39, 1052, '2025-04-09 18:05:15', '2025-04-09 18:05:15');
INSERT INTO `sm_papers` VALUES (40, 1066, '2025-04-09 18:05:51', '2025-04-09 18:05:51');
INSERT INTO `sm_papers` VALUES (40, 1068, '2025-04-09 18:05:51', '2025-04-09 18:05:51');
INSERT INTO `sm_papers` VALUES (40, 1069, '2025-04-09 18:05:51', '2025-04-09 18:05:51');
INSERT INTO `sm_papers` VALUES (40, 1070, '2025-04-09 18:05:51', '2025-04-09 18:05:51');
INSERT INTO `sm_papers` VALUES (40, 1072, '2025-04-09 18:05:51', '2025-04-09 18:05:51');
INSERT INTO `sm_papers` VALUES (40, 1074, '2025-04-09 18:05:51', '2025-04-09 18:05:51');
INSERT INTO `sm_papers` VALUES (40, 1075, '2025-04-09 18:05:51', '2025-04-09 18:05:51');
INSERT INTO `sm_papers` VALUES (40, 1076, '2025-04-09 18:05:51', '2025-04-09 18:05:51');
INSERT INTO `sm_papers` VALUES (40, 1077, '2025-04-09 18:05:51', '2025-04-09 18:05:51');
INSERT INTO `sm_papers` VALUES (41, 1078, '2025-04-09 18:06:21', '2025-04-09 18:06:21');
INSERT INTO `sm_papers` VALUES (41, 1079, '2025-04-09 18:06:21', '2025-04-09 18:06:21');
INSERT INTO `sm_papers` VALUES (41, 1080, '2025-04-09 18:06:21', '2025-04-09 18:06:21');
INSERT INTO `sm_papers` VALUES (41, 1081, '2025-04-09 18:06:21', '2025-04-09 18:06:21');
INSERT INTO `sm_papers` VALUES (41, 1082, '2025-04-09 18:06:21', '2025-04-09 18:06:21');
INSERT INTO `sm_papers` VALUES (41, 1083, '2025-04-09 18:06:21', '2025-04-09 18:06:21');
INSERT INTO `sm_papers` VALUES (41, 1084, '2025-04-09 18:06:21', '2025-04-09 18:06:21');
INSERT INTO `sm_papers` VALUES (41, 1085, '2025-04-09 18:06:21', '2025-04-09 18:06:21');
INSERT INTO `sm_papers` VALUES (41, 1087, '2025-04-09 18:06:21', '2025-04-09 18:06:21');
INSERT INTO `sm_papers` VALUES (41, 1088, '2025-04-09 18:06:21', '2025-04-09 18:06:21');
INSERT INTO `sm_papers` VALUES (41, 1089, '2025-04-09 18:06:21', '2025-04-09 18:06:21');
INSERT INTO `sm_papers` VALUES (41, 1090, '2025-04-09 18:06:21', '2025-04-09 18:06:21');
INSERT INTO `sm_papers` VALUES (41, 1091, '2025-04-09 18:06:21', '2025-04-09 18:06:21');
INSERT INTO `sm_papers` VALUES (42, 1092, '2025-04-09 18:06:42', '2025-04-09 18:06:42');
INSERT INTO `sm_papers` VALUES (42, 1093, '2025-04-09 18:06:42', '2025-04-09 18:06:42');
INSERT INTO `sm_papers` VALUES (42, 1094, '2025-04-09 18:06:42', '2025-04-09 18:06:42');
INSERT INTO `sm_papers` VALUES (42, 1095, '2025-04-09 18:06:42', '2025-04-09 18:06:42');
INSERT INTO `sm_papers` VALUES (42, 1096, '2025-04-09 18:06:42', '2025-04-09 18:06:42');
INSERT INTO `sm_papers` VALUES (42, 1097, '2025-04-09 18:06:42', '2025-04-09 18:06:42');
INSERT INTO `sm_papers` VALUES (42, 1098, '2025-04-09 18:06:42', '2025-04-09 18:06:42');
INSERT INTO `sm_papers` VALUES (42, 1099, '2025-04-09 18:06:42', '2025-04-09 18:06:42');
INSERT INTO `sm_papers` VALUES (42, 1100, '2025-04-09 18:06:42', '2025-04-09 18:06:42');
INSERT INTO `sm_papers` VALUES (42, 1101, '2025-04-09 18:06:42', '2025-04-09 18:06:42');
INSERT INTO `sm_papers` VALUES (42, 1102, '2025-04-09 18:06:42', '2025-04-09 18:06:42');
INSERT INTO `sm_papers` VALUES (42, 1103, '2025-04-09 18:06:42', '2025-04-09 18:06:42');
INSERT INTO `sm_papers` VALUES (42, 1104, '2025-04-09 18:06:42', '2025-04-09 18:06:42');
INSERT INTO `sm_papers` VALUES (42, 1105, '2025-04-09 18:06:42', '2025-04-09 18:06:42');
INSERT INTO `sm_papers` VALUES (42, 1106, '2025-04-09 18:06:42', '2025-04-09 18:06:42');
INSERT INTO `sm_papers` VALUES (42, 1107, '2025-04-09 18:06:42', '2025-04-09 18:06:42');
INSERT INTO `sm_papers` VALUES (42, 1108, '2025-04-09 18:06:42', '2025-04-09 18:06:42');
INSERT INTO `sm_papers` VALUES (42, 1109, '2025-04-09 18:06:42', '2025-04-09 18:06:42');
INSERT INTO `sm_papers` VALUES (45, 1005, '2025-04-10 10:41:01', '2025-04-10 10:41:01');
INSERT INTO `sm_papers` VALUES (45, 1006, '2025-04-10 10:41:01', '2025-04-10 10:41:01');
INSERT INTO `sm_papers` VALUES (45, 1007, '2025-04-10 10:41:01', '2025-04-10 10:41:01');
INSERT INTO `sm_papers` VALUES (45, 1008, '2025-04-10 10:41:01', '2025-04-10 10:41:01');
INSERT INTO `sm_papers` VALUES (45, 1009, '2025-04-10 10:41:01', '2025-04-10 10:41:01');
INSERT INTO `sm_papers` VALUES (45, 1010, '2025-04-10 10:41:01', '2025-04-10 10:41:01');
INSERT INTO `sm_papers` VALUES (45, 1012, '2025-04-10 10:41:01', '2025-04-10 10:41:01');
INSERT INTO `sm_papers` VALUES (45, 1162, '2025-04-10 10:41:01', '2025-04-10 10:41:01');
INSERT INTO `sm_papers` VALUES (46, 1006, '2025-04-10 10:43:50', '2025-04-10 10:43:50');
INSERT INTO `sm_papers` VALUES (46, 1009, '2025-04-10 10:43:50', '2025-04-10 10:43:50');
INSERT INTO `sm_papers` VALUES (46, 1011, '2025-04-10 10:43:50', '2025-04-10 10:43:50');
INSERT INTO `sm_papers` VALUES (46, 1162, '2025-04-10 10:43:50', '2025-04-10 10:43:50');
INSERT INTO `sm_papers` VALUES (47, 106, '2025-04-10 10:55:36', '2025-04-10 10:55:36');
INSERT INTO `sm_papers` VALUES (47, 107, '2025-04-10 10:55:36', '2025-04-10 10:55:36');
INSERT INTO `sm_papers` VALUES (47, 108, '2025-04-10 10:55:36', '2025-04-10 10:55:36');
INSERT INTO `sm_papers` VALUES (48, 1006, '2025-04-10 15:49:47', '2025-04-10 15:49:47');
INSERT INTO `sm_papers` VALUES (48, 1007, '2025-04-10 15:49:47', '2025-04-10 15:49:47');
INSERT INTO `sm_papers` VALUES (48, 1009, '2025-04-10 15:49:47', '2025-04-10 15:49:47');
INSERT INTO `sm_papers` VALUES (48, 1011, '2025-04-10 15:49:47', '2025-04-10 15:49:47');
INSERT INTO `sm_papers` VALUES (48, 1012, '2025-04-10 15:49:47', '2025-04-10 15:49:47');
INSERT INTO `sm_papers` VALUES (49, 101, '2025-04-10 15:50:10', '2025-04-10 15:50:10');
INSERT INTO `sm_papers` VALUES (49, 1006, '2025-04-10 15:50:10', '2025-04-10 15:50:10');
INSERT INTO `sm_papers` VALUES (49, 1007, '2025-04-10 15:50:10', '2025-04-10 15:50:10');
INSERT INTO `sm_papers` VALUES (49, 1009, '2025-04-10 15:50:10', '2025-04-10 15:50:10');
INSERT INTO `sm_papers` VALUES (49, 1011, '2025-04-10 15:50:10', '2025-04-10 15:50:10');
INSERT INTO `sm_papers` VALUES (49, 1012, '2025-04-10 15:50:10', '2025-04-10 15:50:10');

-- ----------------------------
-- Table structure for sm_papers_info
-- ----------------------------
DROP TABLE IF EXISTS `sm_papers_info`;
CREATE TABLE `sm_papers_info`  (
  `paper_id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `paper_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `course_id` int UNSIGNED NOT NULL,
  `total_score` float NULL DEFAULT NULL,
  `time_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `time_modify` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `item_count` int UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`paper_id`) USING BTREE,
  INDEX `course_id`(`course_id`) USING BTREE,
  CONSTRAINT `sm_papers_info_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `sm_courses` (`course_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 44 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sm_papers_info
-- ----------------------------
INSERT INTO `sm_papers_info` VALUES (27, '学前儿童卫生与保健', 1000, 40, '2025-04-09 17:47:18', '2025-04-10 13:59:46', 6);
INSERT INTO `sm_papers_info` VALUES (28, '突发公共卫生事件应急管理', 1002, 70, '2025-04-09 17:49:45', '2025-04-09 18:00:04', 14);
INSERT INTO `sm_papers_info` VALUES (29, '常见疾病诊断与处理', 1003, 50, '2025-04-09 17:50:15', '2025-04-09 17:50:15', 10);
INSERT INTO `sm_papers_info` VALUES (31, '基层急救技能', 1004, 80, '2025-04-09 17:52:26', '2025-04-09 18:04:13', 13);
INSERT INTO `sm_papers_info` VALUES (32, '慢性病管理', 1005, 90, '2025-04-09 17:54:23', '2025-04-09 17:54:23', 11);
INSERT INTO `sm_papers_info` VALUES (33, '传染病防控', 1006, 60, '2025-04-09 17:54:37', '2025-04-09 17:55:03', 5);
INSERT INTO `sm_papers_info` VALUES (34, '中医适宜技术', 1007, 60, '2025-04-09 17:55:24', '2025-04-09 17:55:24', 12);
INSERT INTO `sm_papers_info` VALUES (35, '健康导航与科学用药', 1008, 20, '2025-04-09 17:56:07', '2025-04-09 17:56:07', 3);
INSERT INTO `sm_papers_info` VALUES (36, '基层常见病', 1009, 45, '2025-04-09 17:56:43', '2025-04-09 17:56:43', 9);
INSERT INTO `sm_papers_info` VALUES (37, '卫生与健康', 1010, 90, '2025-04-09 17:57:29', '2025-04-09 17:57:29', 18);
INSERT INTO `sm_papers_info` VALUES (38, '基本公共卫生服务项目解读与实施', 1011, 70, '2025-04-09 17:58:54', '2025-04-09 17:58:54', 14);
INSERT INTO `sm_papers_info` VALUES (39, '基层急救技能培训', 1012, 75, '2025-04-09 18:05:14', '2025-04-09 18:05:15', 15);
INSERT INTO `sm_papers_info` VALUES (40, '中医药适宜技术在基层的应用', 1013, 45, '2025-04-09 18:05:51', '2025-04-09 18:05:51', 9);
INSERT INTO `sm_papers_info` VALUES (41, '基层医疗机构感染防控实务', 1014, 65, '2025-04-09 18:06:21', '2025-04-09 18:06:21', 13);
INSERT INTO `sm_papers_info` VALUES (42, '医患沟通技巧与医疗纠纷防范', 1015, 90, '2025-04-09 18:06:42', '2025-04-09 18:06:42', 18);
INSERT INTO `sm_papers_info` VALUES (45, '试卷1', 1000, 40, '2025-04-10 10:41:01', '2025-04-10 10:41:01', 8);
INSERT INTO `sm_papers_info` VALUES (46, '测试2', 1000, 20, '2025-04-10 10:43:50', '2025-04-10 10:43:50', 4);
INSERT INTO `sm_papers_info` VALUES (47, '测试1', 1004, 40, '2025-04-10 10:55:36', '2025-04-10 10:55:36', 3);
INSERT INTO `sm_papers_info` VALUES (48, 'test', 1000, 25, '2025-04-10 15:49:47', '2025-04-10 15:49:47', 5);
INSERT INTO `sm_papers_info` VALUES (49, 'test', 1000, 35, '2025-04-10 15:50:10', '2025-04-10 15:50:10', 6);

-- ----------------------------
-- Table structure for sm_progress
-- ----------------------------
DROP TABLE IF EXISTS `sm_progress`;
CREATE TABLE `sm_progress`  (
  `progress_id` int NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `course_id` int UNSIGNED NOT NULL,
  `chapter_id` int UNSIGNED NOT NULL,
  `is_finished` int NULL DEFAULT NULL,
  `time_create` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `time_modify` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`progress_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `course_id`(`course_id`) USING BTREE,
  INDEX `chapter_id`(`chapter_id`) USING BTREE,
  CONSTRAINT `sm_progress_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `sm_users` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `sm_progress_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `sm_courses` (`course_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `sm_progress_ibfk_3` FOREIGN KEY (`chapter_id`) REFERENCES `sm_chapters` (`chapter_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 53 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sm_progress
-- ----------------------------
INSERT INTO `sm_progress` VALUES (1, '7d9030e8cb5841c288c7d8b2412b97cc', 1000, 1000, 1, '2025-04-07 10:29:56', '2025-04-09 15:22:24');
INSERT INTO `sm_progress` VALUES (2, '7d9030e8cb5841c288c7d8b2412b97cc', 1000, 1001, 0, '2025-04-09 10:30:17', '2025-04-10 09:50:11');
INSERT INTO `sm_progress` VALUES (3, '7d9030e8cb5841c288c7d8b2412b97cc', 1000, 1005, 0, '2025-04-08 18:30:26', '2025-04-10 11:39:57');
INSERT INTO `sm_progress` VALUES (4, '7d9030e8cb5841c288c7d8b2412b97cc', 1002, 1002, 1, '2025-04-09 12:57:52', '2025-04-10 09:22:21');
INSERT INTO `sm_progress` VALUES (5, '7d9030e8cb5841c288c7d8b2412b97cc', 1002, 1003, 0, '2025-04-09 12:58:17', '2025-04-09 12:58:24');
INSERT INTO `sm_progress` VALUES (6, '7d9030e8cb5841c288c7d8b2412b97cc', 1002, 1004, 0, '2025-04-09 14:01:27', '2025-04-09 14:01:27');
INSERT INTO `sm_progress` VALUES (12, '7d9030e8cb5841c288c7d8b2412b97cc', 1003, 1006, 1, '2025-04-09 14:18:56', '2025-04-09 14:23:35');
INSERT INTO `sm_progress` VALUES (13, '7d9030e8cb5841c288c7d8b2412b97cc', 1003, 1007, 1, '2025-04-09 14:18:56', '2025-04-09 15:14:31');
INSERT INTO `sm_progress` VALUES (14, '7d9030e8cb5841c288c7d8b2412b97cc', 1003, 1008, 1, '2025-04-09 14:18:56', '2025-04-09 14:18:56');
INSERT INTO `sm_progress` VALUES (15, '7d9030e8cb5841c288c7d8b2412b97cc', 1003, 1009, 1, '2025-04-09 14:18:56', '2025-04-09 14:18:56');
INSERT INTO `sm_progress` VALUES (16, '7d9030e8cb5841c288c7d8b2412b97cc', 1003, 1010, 0, '2025-04-09 14:18:56', '2025-04-09 14:18:56');
INSERT INTO `sm_progress` VALUES (17, '7d9030e8cb5841c288c7d8b2412b97cc', 1003, 1011, 0, '2025-04-09 14:18:56', '2025-04-09 14:18:56');
INSERT INTO `sm_progress` VALUES (18, '7d9030e8cb5841c288c7d8b2412b97cc', 1004, 1012, 1, '2025-04-09 14:20:04', '2025-04-09 14:20:04');
INSERT INTO `sm_progress` VALUES (19, '7d9030e8cb5841c288c7d8b2412b97cc', 1004, 1013, 0, '2025-04-09 14:20:04', '2025-04-09 14:20:04');
INSERT INTO `sm_progress` VALUES (20, '7d9030e8cb5841c288c7d8b2412b97cc', 1004, 1014, 0, '2025-04-09 14:20:04', '2025-04-09 14:20:04');
INSERT INTO `sm_progress` VALUES (21, '7d9030e8cb5841c288c7d8b2412b97cc', 1004, 1015, 0, '2025-04-09 14:20:04', '2025-04-09 14:20:04');
INSERT INTO `sm_progress` VALUES (22, '7d9030e8cb5841c288c7d8b2412b97cc', 1004, 1016, 0, '2025-04-09 14:20:04', '2025-04-09 14:20:04');
INSERT INTO `sm_progress` VALUES (23, '7d9030e8cb5841c288c7d8b2412b97cc', 1004, 1017, 0, '2025-04-09 14:20:04', '2025-04-09 14:20:04');
INSERT INTO `sm_progress` VALUES (24, '3726d7f8325b4fe6ad281755bb61fa16', 1005, 1018, 1, '2025-04-09 23:47:31', '2025-04-09 23:55:12');
INSERT INTO `sm_progress` VALUES (25, '3726d7f8325b4fe6ad281755bb61fa16', 1005, 1112, 1, '2025-04-09 23:47:31', '2025-04-09 23:55:15');
INSERT INTO `sm_progress` VALUES (26, '3726d7f8325b4fe6ad281755bb61fa16', 1005, 1113, 1, '2025-04-09 23:47:31', '2025-04-09 23:55:17');
INSERT INTO `sm_progress` VALUES (27, '3726d7f8325b4fe6ad281755bb61fa16', 1005, 1019, 0, '2025-04-09 23:47:31', '2025-04-09 23:47:31');
INSERT INTO `sm_progress` VALUES (28, '3726d7f8325b4fe6ad281755bb61fa16', 1005, 1020, 0, '2025-04-09 23:47:31', '2025-04-09 23:47:31');
INSERT INTO `sm_progress` VALUES (29, '3726d7f8325b4fe6ad281755bb61fa16', 1005, 1021, 0, '2025-04-06 23:47:31', '2025-04-10 11:35:32');
INSERT INTO `sm_progress` VALUES (30, '4b1081937a8e4f67a7115bbdaeb2cf17', 1002, 1002, 1, '2025-04-06 23:57:06', '2025-04-06 23:58:44');
INSERT INTO `sm_progress` VALUES (31, '4b1081937a8e4f67a7115bbdaeb2cf17', 1002, 1102, 1, '2025-04-08 23:57:06', '2025-04-08 23:58:47');
INSERT INTO `sm_progress` VALUES (32, '4b1081937a8e4f67a7115bbdaeb2cf17', 1002, 1104, 1, '2025-04-08 23:57:06', '2025-04-08 23:58:50');
INSERT INTO `sm_progress` VALUES (33, '4b1081937a8e4f67a7115bbdaeb2cf17', 1002, 1105, 1, '2025-04-09 23:57:06', '2025-04-09 23:58:51');
INSERT INTO `sm_progress` VALUES (34, '4b1081937a8e4f67a7115bbdaeb2cf17', 1002, 1106, 0, '2025-04-08 23:57:06', '2025-04-08 23:57:06');
INSERT INTO `sm_progress` VALUES (35, '4b1081937a8e4f67a7115bbdaeb2cf17', 1002, 1107, 0, '2025-04-09 23:57:06', '2025-04-09 23:57:06');
INSERT INTO `sm_progress` VALUES (36, '4b1081937a8e4f67a7115bbdaeb2cf17', 1002, 1108, 0, '2025-04-09 23:57:06', '2025-04-09 23:57:06');
INSERT INTO `sm_progress` VALUES (37, '4b1081937a8e4f67a7115bbdaeb2cf17', 1002, 1110, 0, '2025-04-09 23:57:06', '2025-04-09 23:57:06');
INSERT INTO `sm_progress` VALUES (38, '4b1081937a8e4f67a7115bbdaeb2cf17', 1002, 1111, 0, '2025-04-09 23:57:06', '2025-04-09 23:57:06');
INSERT INTO `sm_progress` VALUES (39, '4b1081937a8e4f67a7115bbdaeb2cf17', 1002, 1004, 0, '2025-04-09 23:57:06', '2025-04-09 23:57:06');
INSERT INTO `sm_progress` VALUES (40, '4b1081937a8e4f67a7115bbdaeb2cf17', 1002, 1103, 0, '2025-04-09 23:57:06', '2025-04-09 23:57:06');
INSERT INTO `sm_progress` VALUES (41, '4b1081937a8e4f67a7115bbdaeb2cf17', 1002, 1109, 0, '2025-04-09 23:57:06', '2025-04-09 23:57:06');
INSERT INTO `sm_progress` VALUES (42, '4b1081937a8e4f67a7115bbdaeb2cf17', 1002, 1003, 0, '2025-04-09 23:57:06', '2025-04-09 23:57:06');
INSERT INTO `sm_progress` VALUES (43, '4b1081937a8e4f67a7115bbdaeb2cf17', 1000, 1000, 0, '2025-04-09 23:57:11', '2025-04-09 23:57:11');
INSERT INTO `sm_progress` VALUES (44, '4b1081937a8e4f67a7115bbdaeb2cf17', 1000, 1001, 0, '2025-04-09 23:57:11', '2025-04-09 23:57:11');
INSERT INTO `sm_progress` VALUES (45, '4b1081937a8e4f67a7115bbdaeb2cf17', 1000, 1005, 0, '2025-04-09 23:57:11', '2025-04-09 23:57:11');
INSERT INTO `sm_progress` VALUES (46, '4b1081937a8e4f67a7115bbdaeb2cf17', 1000, 1091, 0, '2025-04-09 23:57:11', '2025-04-09 23:57:11');
INSERT INTO `sm_progress` VALUES (47, '4b1081937a8e4f67a7115bbdaeb2cf17', 1000, 1092, 0, '2025-04-09 23:57:11', '2025-04-09 23:57:11');
INSERT INTO `sm_progress` VALUES (48, '4b1081937a8e4f67a7115bbdaeb2cf17', 1000, 1094, 0, '2025-04-09 23:57:11', '2025-04-09 23:57:11');
INSERT INTO `sm_progress` VALUES (49, '4b1081937a8e4f67a7115bbdaeb2cf17', 1000, 1089, 0, '2025-04-09 23:57:11', '2025-04-09 23:57:11');
INSERT INTO `sm_progress` VALUES (50, '4b1081937a8e4f67a7115bbdaeb2cf17', 1000, 1090, 0, '2025-04-09 23:57:11', '2025-04-09 23:57:11');
INSERT INTO `sm_progress` VALUES (51, '4b1081937a8e4f67a7115bbdaeb2cf17', 1000, 1093, 0, '2025-04-09 23:57:11', '2025-04-09 23:57:11');
INSERT INTO `sm_progress` VALUES (52, '4b1081937a8e4f67a7115bbdaeb2cf17', 1000, 1095, 0, '2025-04-09 23:57:11', '2025-04-09 23:57:11');
INSERT INTO `sm_progress` VALUES (53, '7d9030e8cb5841c288c7d8b2412b97cc', 1000, 1090, 1, '2025-04-10 09:41:22', '2025-04-10 09:41:27');
INSERT INTO `sm_progress` VALUES (54, '7d9030e8cb5841c288c7d8b2412b97cc', 1000, 1089, 0, '2025-04-10 09:41:51', '2025-04-10 09:41:51');
INSERT INTO `sm_progress` VALUES (55, '7bdc4b7c11524a42851dfd2283cbf9c1', 1000, 1000, 0, '2025-04-10 10:23:57', '2025-04-10 10:23:57');
INSERT INTO `sm_progress` VALUES (56, '7bdc4b7c11524a42851dfd2283cbf9c1', 1000, 1001, 0, '2025-04-10 10:23:57', '2025-04-10 10:23:57');
INSERT INTO `sm_progress` VALUES (57, '7bdc4b7c11524a42851dfd2283cbf9c1', 1000, 1005, 0, '2025-04-10 10:23:57', '2025-04-10 10:23:57');
INSERT INTO `sm_progress` VALUES (58, '7bdc4b7c11524a42851dfd2283cbf9c1', 1000, 1091, 0, '2025-04-10 10:23:57', '2025-04-10 10:23:57');
INSERT INTO `sm_progress` VALUES (59, '7bdc4b7c11524a42851dfd2283cbf9c1', 1000, 1092, 0, '2025-04-10 10:23:57', '2025-04-10 10:23:57');
INSERT INTO `sm_progress` VALUES (60, '7bdc4b7c11524a42851dfd2283cbf9c1', 1000, 1094, 0, '2025-04-10 10:23:57', '2025-04-10 10:23:57');
INSERT INTO `sm_progress` VALUES (61, '7bdc4b7c11524a42851dfd2283cbf9c1', 1000, 1089, 0, '2025-04-10 10:23:57', '2025-04-10 10:23:57');
INSERT INTO `sm_progress` VALUES (62, '7bdc4b7c11524a42851dfd2283cbf9c1', 1000, 1090, 0, '2025-04-10 10:23:57', '2025-04-10 10:23:57');
INSERT INTO `sm_progress` VALUES (63, '7bdc4b7c11524a42851dfd2283cbf9c1', 1000, 1093, 0, '2025-04-10 10:23:57', '2025-04-10 10:23:57');
INSERT INTO `sm_progress` VALUES (64, '7bdc4b7c11524a42851dfd2283cbf9c1', 1000, 1095, 0, '2025-04-10 10:23:57', '2025-04-10 10:23:57');
INSERT INTO `sm_progress` VALUES (65, '7bdc4b7c11524a42851dfd2283cbf9c1', 1000, 1114, 0, '2025-04-10 10:23:57', '2025-04-10 10:23:57');

-- ----------------------------
-- Table structure for sm_question
-- ----------------------------
DROP TABLE IF EXISTS `sm_question`;
CREATE TABLE `sm_question`  (
  `question_id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `course_id` int UNSIGNED NULL DEFAULT NULL,
  `question_content` varchar(3000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `question_answer` varchar(3000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `is_solve` tinyint(1) NULL DEFAULT NULL,
  `ask_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `answer_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `time_create` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `time_modify` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`question_id`) USING BTREE,
  INDEX `course_id`(`course_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `sm_question_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `sm_courses` (`course_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sm_question_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `sm_users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1126 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sm_question
-- ----------------------------
INSERT INTO `sm_question` VALUES (1111, '7d9030e8cb5841c288c7d8b2412b97cc', 1000, '维生素D缺乏会导致什么', '佝偻病、骨质疏松症、手足抽搐等', 1, '2025-04-10 11:51:07', '2025-04-10 11:51:07', '2025-04-10 11:51:07', '2025-04-10 11:51:07');
INSERT INTO `sm_question` VALUES (1113, '7d9030e8cb5841c288c7d8b2412b97cc', 1000, '皮肤属于结缔组织吗', '属于，上课讲过', 1, '2025-04-09 23:41:44', '2025-04-09 23:41:44', '2025-04-09 23:41:44', '2025-04-09 23:41:44');
INSERT INTO `sm_question` VALUES (1115, '7d9030e8cb5841c288c7d8b2412b97cc', 1000, '人体生命活动最基本的特征是什么', '新陈代谢', 1, '2025-04-09 23:42:12', '2025-04-09 23:42:12', '2025-04-09 23:42:12', '2025-04-09 23:42:12');
INSERT INTO `sm_question` VALUES (1116, '7d9030e8cb5841c288c7d8b2412b97cc', 1000, '老师，请问细胞是人体的什么单位', '细胞是人体结构和机能的最基本单位', 1, '2025-04-09 23:42:59', '2025-04-09 23:42:59', '2025-04-09 23:42:59', '2025-04-09 23:42:59');
INSERT INTO `sm_question` VALUES (1122, '3726d7f8325b4fe6ad281755bb61fa16', 1002, '您认为应如何构建更高效、科学的跨地区医疗资源协调机制，以确保资源快速、精准地分配到最需要的地方？', NULL, 0, '2025-04-09 23:45:16', '2025-04-09 23:45:16', '2025-04-09 23:45:16', '2025-04-09 23:45:16');
INSERT INTO `sm_question` VALUES (1123, '3726d7f8325b4fe6ad281755bb61fa16', 1002, '在应急管理体系里，怎样强化基层社区的信息收集与上报能力，保障信息渠道的畅通无阻，使上级部门能第一时间掌握真实、全面的基层情况？', NULL, 0, '2025-04-09 23:45:21', '2025-04-09 23:45:21', '2025-04-09 23:45:21', '2025-04-09 23:45:21');
INSERT INTO `sm_question` VALUES (1124, '7d9030e8cb5841c288c7d8b2412b97cc', 1000, '哪个阶段是新生儿出生后发育最为迅速的时期', '第', 1, '2025-04-10 15:51:21', '2025-04-10 15:51:21', '2025-04-10 15:51:21', '2025-04-10 15:51:21');
INSERT INTO `sm_question` VALUES (1125, '7d9030e8cb5841c288c7d8b2412b97cc', 1000, '新生儿时期具体指什么时候', NULL, 0, '2025-04-09 23:44:08', '2025-04-09 23:44:08', '2025-04-09 23:44:08', '2025-04-09 23:44:08');
INSERT INTO `sm_question` VALUES (1129, '7d9030e8cb5841c288c7d8b2412b97cc', 1000, '看不懂', NULL, 0, '2025-04-10 10:02:47', NULL, NULL, NULL);
INSERT INTO `sm_question` VALUES (1131, '7d9030e8cb5841c288c7d8b2412b97cc', 1000, 'test', NULL, 0, '2025-04-10 15:45:13', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for sm_score
-- ----------------------------
DROP TABLE IF EXISTS `sm_score`;
CREATE TABLE `sm_score`  (
  `score_id` int NOT NULL AUTO_INCREMENT,
  `user_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '学生id',
  `exam_id` int UNSIGNED NOT NULL COMMENT '考试id',
  `object_score` float NOT NULL COMMENT '客观得分',
  `subject_score` float NOT NULL COMMENT '主观得分',
  `user_score` float NOT NULL COMMENT '总得分',
  `retake` int NULL DEFAULT NULL,
  `time_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `time_modify` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`score_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `exam_id`(`exam_id`) USING BTREE,
  CONSTRAINT `sm_score_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `sm_users` (`user_id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `sm_score_ibfk_2` FOREIGN KEY (`exam_id`) REFERENCES `sm_exams` (`exam_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 207 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sm_score
-- ----------------------------
INSERT INTO `sm_score` VALUES (207, '7bdc4b7c11524a42851dfd2283cbf9c1', 37, 30, 0, 30, 1, '2025-04-10 10:24:36', '2025-04-10 10:24:36');
INSERT INTO `sm_score` VALUES (208, '7bdc4b7c11524a42851dfd2283cbf9c1', 38, 60, 0, 60, 1, '2025-04-10 10:26:30', '2025-04-10 10:26:30');
INSERT INTO `sm_score` VALUES (209, '4b1081937a8e4f67a7115bbdaeb2cf17', 37, 30, 0, 30, 1, '2025-04-10 10:27:30', '2025-04-10 10:27:30');
INSERT INTO `sm_score` VALUES (210, '4b1081937a8e4f67a7115bbdaeb2cf17', 38, 65, 0, 65, 1, '2025-04-10 10:28:32', '2025-04-10 10:28:32');
INSERT INTO `sm_score` VALUES (211, '44964845a7db45b4b6b1d7ed98761ee9', 37, 30, 0, 30, 1, '2025-04-10 10:29:24', '2025-04-10 10:29:24');
INSERT INTO `sm_score` VALUES (212, '7d9030e8cb5841c288c7d8b2412b97cc', 55, 0, 0, 0, 1, '2025-04-10 13:36:35', '2025-04-10 13:36:35');
INSERT INTO `sm_score` VALUES (213, '7d9030e8cb5841c288c7d8b2412b97cc', 45, 25, 0, 25, 1, '2025-04-10 13:38:17', '2025-04-10 13:38:17');
INSERT INTO `sm_score` VALUES (214, '7d9030e8cb5841c288c7d8b2412b97cc', 44, 20, 0, 20, 1, '2025-04-10 13:39:25', '2025-04-10 13:39:25');
INSERT INTO `sm_score` VALUES (215, '7d9030e8cb5841c288c7d8b2412b97cc', 37, 5, 0, 5, 1, '2025-04-10 15:46:16', '2025-04-10 15:46:16');
INSERT INTO `sm_score` VALUES (216, '7d9030e8cb5841c288c7d8b2412b97cc', 37, 15, 0, 15, 2, '2025-04-10 15:52:44', '2025-04-10 15:52:44');

-- ----------------------------
-- Table structure for sm_user_courses
-- ----------------------------
DROP TABLE IF EXISTS `sm_user_courses`;
CREATE TABLE `sm_user_courses`  (
  `user_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `course_id` int UNSIGNED NOT NULL,
  `time_create` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `time_modify` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`, `course_id`) USING BTREE,
  INDEX `course_id`(`course_id`) USING BTREE,
  CONSTRAINT `sm_user_courses_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `sm_courses` (`course_id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `sm_user_courses_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `sm_users` (`user_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sm_user_courses
-- ----------------------------
INSERT INTO `sm_user_courses` VALUES ('3726d7f8325b4fe6ad281755bb61fa16', 1000, '2025-04-09 12:04:16', '2025-04-09 12:04:16');
INSERT INTO `sm_user_courses` VALUES ('3726d7f8325b4fe6ad281755bb61fa16', 1002, '2025-04-09 12:03:39', '2025-04-09 12:03:39');
INSERT INTO `sm_user_courses` VALUES ('3726d7f8325b4fe6ad281755bb61fa16', 1005, '2025-04-09 23:47:31', '2025-04-09 23:47:31');
INSERT INTO `sm_user_courses` VALUES ('3726d7f8325b4fe6ad281755bb61fa16', 1008, '2025-04-09 12:03:59', '2025-04-09 12:03:59');
INSERT INTO `sm_user_courses` VALUES ('3726d7f8325b4fe6ad281755bb61fa16', 1011, '2025-04-09 12:04:09', '2025-04-09 12:04:09');
INSERT INTO `sm_user_courses` VALUES ('3726d7f8325b4fe6ad281755bb61fa16', 1015, '2025-04-09 12:04:03', '2025-04-09 12:04:03');
INSERT INTO `sm_user_courses` VALUES ('44964845a7db45b4b6b1d7ed98761ee9', 1000, '2025-04-01 10:31:43', '2025-04-01 10:31:46');
INSERT INTO `sm_user_courses` VALUES ('44964845a7db45b4b6b1d7ed98761ee9', 1002, '2025-04-07 10:27:44', '2025-04-07 10:27:55');
INSERT INTO `sm_user_courses` VALUES ('4b1081937a8e4f67a7115bbdaeb2cf17', 1000, '2025-04-09 23:57:11', '2025-04-09 23:57:11');
INSERT INTO `sm_user_courses` VALUES ('4b1081937a8e4f67a7115bbdaeb2cf17', 1002, '2025-04-09 23:57:06', '2025-04-09 23:57:06');
INSERT INTO `sm_user_courses` VALUES ('4b1081937a8e4f67a7115bbdaeb2cf17', 1008, '2025-04-09 23:57:25', '2025-04-09 23:57:25');
INSERT INTO `sm_user_courses` VALUES ('7bdc4b7c11524a42851dfd2283cbf9c1', 1000, '2025-04-10 10:23:56', '2025-04-10 10:23:56');
INSERT INTO `sm_user_courses` VALUES ('7bdc4b7c11524a42851dfd2283cbf9c1', 1002, '2025-04-09 14:32:54', '2025-04-09 14:32:54');
INSERT INTO `sm_user_courses` VALUES ('7bdc4b7c11524a42851dfd2283cbf9c1', 1004, '2025-04-09 14:38:47', '2025-04-09 14:38:47');
INSERT INTO `sm_user_courses` VALUES ('7d9030e8cb5841c288c7d8b2412b97cc', 1000, '2025-03-30 15:02:32', '2025-03-30 15:02:32');
INSERT INTO `sm_user_courses` VALUES ('7d9030e8cb5841c288c7d8b2412b97cc', 1002, '2025-04-04 18:10:13', '2025-04-04 18:10:13');
INSERT INTO `sm_user_courses` VALUES ('7d9030e8cb5841c288c7d8b2412b97cc', 1003, '2025-04-09 14:18:56', '2025-04-09 14:18:56');
INSERT INTO `sm_user_courses` VALUES ('7d9030e8cb5841c288c7d8b2412b97cc', 1004, '2025-04-09 14:20:04', '2025-04-09 14:20:04');
INSERT INTO `sm_user_courses` VALUES ('7d9030e8cb5841c288c7d8b2412b97cc', 1007, '2025-04-10 15:44:12', '2025-04-10 15:44:12');
INSERT INTO `sm_user_courses` VALUES ('7d9030e8cb5841c288c7d8b2412b97cc', 1008, '2025-04-10 13:27:27', '2025-04-10 13:27:27');
INSERT INTO `sm_user_courses` VALUES ('7d9030e8cb5841c288c7d8b2412b97cc', 1009, '2025-04-09 22:10:47', '2025-04-09 22:10:47');

-- ----------------------------
-- Table structure for sm_user_exams
-- ----------------------------
DROP TABLE IF EXISTS `sm_user_exams`;
CREATE TABLE `sm_user_exams`  (
  `uexam_id` int NOT NULL AUTO_INCREMENT,
  `user_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '学生id',
  `exam_id` int UNSIGNED NOT NULL COMMENT '考试id',
  `item_id` int UNSIGNED NOT NULL COMMENT '题目id',
  `option_id` int UNSIGNED NULL DEFAULT NULL COMMENT '选项id',
  `answer` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL COMMENT '答案：主观题使用',
  `time_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `time_modify` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `retake` int NULL DEFAULT NULL COMMENT '考试次数',
  PRIMARY KEY (`uexam_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `paper_id`(`exam_id`, `item_id`) USING BTREE,
  INDEX `option_id`(`option_id`) USING BTREE,
  CONSTRAINT `sm_user_exams_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `sm_users` (`user_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 106 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sm_user_exams
-- ----------------------------
INSERT INTO `sm_user_exams` VALUES (2, '7d9030e8cb5841c288c7d8b2412b97cc', 1, 102, 3155, NULL, '2025-04-06 22:51:28', '2025-04-06 22:51:28', 1);
INSERT INTO `sm_user_exams` VALUES (3, '7d9030e8cb5841c288c7d8b2412b97cc', 1, 103, 3179, NULL, '2025-04-06 22:51:28', '2025-04-06 22:51:28', 1);
INSERT INTO `sm_user_exams` VALUES (4, '7d9030e8cb5841c288c7d8b2412b97cc', 1, 1002, 7, NULL, '2025-04-06 22:51:28', '2025-04-06 22:51:28', 1);
INSERT INTO `sm_user_exams` VALUES (5, '7d9030e8cb5841c288c7d8b2412b97cc', 1, 111, 3168, NULL, '2025-04-06 22:51:28', '2025-04-06 22:51:28', 1);
INSERT INTO `sm_user_exams` VALUES (6, '7d9030e8cb5841c288c7d8b2412b97cc', 1, 101, 3152, NULL, '2025-04-06 22:51:28', '2025-04-06 22:51:28', 1);
INSERT INTO `sm_user_exams` VALUES (7, '7d9030e8cb5841c288c7d8b2412b97cc', 1, 104, 3184, NULL, '2025-04-06 22:51:28', '2025-04-06 22:51:28', 1);
INSERT INTO `sm_user_exams` VALUES (8, '7d9030e8cb5841c288c7d8b2412b97cc', 1, 114, 3170, NULL, '2025-04-06 22:51:28', '2025-04-06 22:51:28', 1);
INSERT INTO `sm_user_exams` VALUES (9, '7d9030e8cb5841c288c7d8b2412b97cc', 1, 109, 3166, NULL, '2025-04-06 22:51:28', '2025-04-06 22:51:28', 1);
INSERT INTO `sm_user_exams` VALUES (10, '7d9030e8cb5841c288c7d8b2412b97cc', 1, 1000, 0, 'CP', '2025-04-06 22:51:28', '2025-04-06 22:51:28', 1);
INSERT INTO `sm_user_exams` VALUES (11, '7d9030e8cb5841c288c7d8b2412b97cc', 1, 105, 3159, NULL, '2025-04-06 22:51:28', '2025-04-06 22:51:28', 1);
INSERT INTO `sm_user_exams` VALUES (12, '7d9030e8cb5841c288c7d8b2412b97cc', 1, 102, 3193, NULL, '2025-04-06 22:51:28', '2025-04-06 22:51:28', 1);
INSERT INTO `sm_user_exams` VALUES (13, '7d9030e8cb5841c288c7d8b2412b97cc', 1, 1000, 0, 'CPU', '2025-04-06 22:51:28', '2025-04-06 22:51:28', 1);
INSERT INTO `sm_user_exams` VALUES (14, '7d9030e8cb5841c288c7d8b2412b97cc', 1, 110, 0, '第一步：开机; \n第二步：用它；\n第三步：关机', '2025-04-06 22:51:28', '2025-04-06 22:51:28', 1);
INSERT INTO `sm_user_exams` VALUES (15, '7d9030e8cb5841c288c7d8b2412b97cc', 1, 1000, 0, 'U', '2025-04-06 22:51:28', '2025-04-06 22:51:28', 1);
INSERT INTO `sm_user_exams` VALUES (16, '7d9030e8cb5841c288c7d8b2412b97cc', 1, 115, 0, '很重要，能晚点死', '2025-04-06 22:51:28', '2025-04-06 22:51:28', 1);
INSERT INTO `sm_user_exams` VALUES (23, '7d9030e8cb5841c288c7d8b2412b97cc', 8, 107, 3163, NULL, '2025-04-08 09:17:46', '2025-04-08 09:17:46', 1);
INSERT INTO `sm_user_exams` VALUES (24, '7d9030e8cb5841c288c7d8b2412b97cc', 8, 107, 3164, NULL, '2025-04-08 09:17:46', '2025-04-08 09:17:46', 1);
INSERT INTO `sm_user_exams` VALUES (25, '7d9030e8cb5841c288c7d8b2412b97cc', 8, 106, 3160, NULL, '2025-04-08 09:17:46', '2025-04-08 09:17:46', 1);
INSERT INTO `sm_user_exams` VALUES (26, '7d9030e8cb5841c288c7d8b2412b97cc', 34, 106, 3160, NULL, '2025-04-08 10:05:22', '2025-04-08 10:05:22', 1);
INSERT INTO `sm_user_exams` VALUES (27, '7d9030e8cb5841c288c7d8b2412b97cc', 34, 108, 3186, NULL, '2025-04-08 10:05:22', '2025-04-08 10:05:22', 1);
INSERT INTO `sm_user_exams` VALUES (28, '7d9030e8cb5841c288c7d8b2412b97cc', 34, 107, 3163, NULL, '2025-04-08 10:05:22', '2025-04-08 10:05:22', 1);
INSERT INTO `sm_user_exams` VALUES (29, '7d9030e8cb5841c288c7d8b2412b97cc', 34, 107, 3164, NULL, '2025-04-08 10:05:22', '2025-04-08 10:05:22', 1);
INSERT INTO `sm_user_exams` VALUES (30, '7d9030e8cb5841c288c7d8b2412b97cc', 34, 109, 3165, NULL, '2025-04-08 10:05:22', '2025-04-08 10:05:22', 1);
INSERT INTO `sm_user_exams` VALUES (31, '7d9030e8cb5841c288c7d8b2412b97cc', 34, 107, 3194, NULL, '2025-04-08 10:05:22', '2025-04-08 10:05:22', 1);
INSERT INTO `sm_user_exams` VALUES (32, '7d9030e8cb5841c288c7d8b2412b97cc', 34, 110, 0, '不会', '2025-04-08 10:05:22', '2025-04-08 10:05:22', 1);
INSERT INTO `sm_user_exams` VALUES (33, '7d9030e8cb5841c288c7d8b2412b97cc', 34, 107, 3164, NULL, '2025-04-08 13:23:41', '2025-04-08 13:23:41', 1);
INSERT INTO `sm_user_exams` VALUES (34, '7d9030e8cb5841c288c7d8b2412b97cc', 34, 106, 3160, NULL, '2025-04-08 13:23:41', '2025-04-08 13:23:41', 1);
INSERT INTO `sm_user_exams` VALUES (35, '7d9030e8cb5841c288c7d8b2412b97cc', 34, 108, 3186, NULL, '2025-04-08 13:23:41', '2025-04-08 13:23:41', 1);
INSERT INTO `sm_user_exams` VALUES (36, '7d9030e8cb5841c288c7d8b2412b97cc', 34, 109, 3165, NULL, '2025-04-08 13:23:41', '2025-04-08 13:23:41', 1);
INSERT INTO `sm_user_exams` VALUES (37, '7d9030e8cb5841c288c7d8b2412b97cc', 34, 110, 0, 'ooo\n', '2025-04-08 13:23:41', '2025-04-08 13:23:41', 1);
INSERT INTO `sm_user_exams` VALUES (38, '7d9030e8cb5841c288c7d8b2412b97cc', 34, 106, 3160, NULL, '2025-04-08 13:42:23', '2025-04-08 13:42:23', 2);
INSERT INTO `sm_user_exams` VALUES (39, '7d9030e8cb5841c288c7d8b2412b97cc', 34, 108, 3186, NULL, '2025-04-08 13:42:23', '2025-04-08 13:42:23', 2);
INSERT INTO `sm_user_exams` VALUES (40, '7d9030e8cb5841c288c7d8b2412b97cc', 34, 107, 3194, NULL, '2025-04-08 13:42:23', '2025-04-08 13:42:23', 2);
INSERT INTO `sm_user_exams` VALUES (41, '7d9030e8cb5841c288c7d8b2412b97cc', 34, 110, 0, '就这么用', '2025-04-08 13:42:23', '2025-04-08 13:42:23', 2);
INSERT INTO `sm_user_exams` VALUES (42, '7d9030e8cb5841c288c7d8b2412b97cc', 34, 109, 3165, NULL, '2025-04-08 13:42:23', '2025-04-08 13:42:23', 2);
INSERT INTO `sm_user_exams` VALUES (50, '7d9030e8cb5841c288c7d8b2412b97cc', 34, 110, 0, '打开电源；使用；关闭电源', '2025-04-08 14:22:19', '2025-04-08 14:22:19', 3);
INSERT INTO `sm_user_exams` VALUES (51, '7d9030e8cb5841c288c7d8b2412b97cc', 34, 107, 3164, NULL, '2025-04-08 14:22:19', '2025-04-08 14:22:19', 3);
INSERT INTO `sm_user_exams` VALUES (52, '7d9030e8cb5841c288c7d8b2412b97cc', 34, 109, 3165, NULL, '2025-04-08 14:22:19', '2025-04-08 14:22:19', 3);
INSERT INTO `sm_user_exams` VALUES (53, '7d9030e8cb5841c288c7d8b2412b97cc', 34, 107, 3163, NULL, '2025-04-08 14:22:19', '2025-04-08 14:22:19', 3);
INSERT INTO `sm_user_exams` VALUES (54, '7d9030e8cb5841c288c7d8b2412b97cc', 34, 106, 3160, NULL, '2025-04-08 14:22:19', '2025-04-08 14:22:19', 3);
INSERT INTO `sm_user_exams` VALUES (55, '7d9030e8cb5841c288c7d8b2412b97cc', 34, 108, 3185, NULL, '2025-04-08 14:22:19', '2025-04-08 14:22:19', 3);
INSERT INTO `sm_user_exams` VALUES (70, '7d9030e8cb5841c288c7d8b2412b97cc', 7, 106, 3160, NULL, '2025-04-08 14:39:56', '2025-04-08 14:39:56', 1);
INSERT INTO `sm_user_exams` VALUES (71, '7d9030e8cb5841c288c7d8b2412b97cc', 7, 107, 3164, NULL, '2025-04-08 14:39:56', '2025-04-08 14:39:56', 1);
INSERT INTO `sm_user_exams` VALUES (72, '7d9030e8cb5841c288c7d8b2412b97cc', 1, 103, 3180, NULL, '2025-04-09 10:42:05', '2025-04-09 10:42:05', 3);
INSERT INTO `sm_user_exams` VALUES (73, '7d9030e8cb5841c288c7d8b2412b97cc', 1, 111, 3167, NULL, '2025-04-09 10:42:05', '2025-04-09 10:42:05', 3);
INSERT INTO `sm_user_exams` VALUES (74, '7d9030e8cb5841c288c7d8b2412b97cc', 1, 102, 3193, NULL, '2025-04-09 10:42:05', '2025-04-09 10:42:05', 3);
INSERT INTO `sm_user_exams` VALUES (75, '7d9030e8cb5841c288c7d8b2412b97cc', 1, 1002, 8, NULL, '2025-04-09 10:42:05', '2025-04-09 10:42:05', 3);
INSERT INTO `sm_user_exams` VALUES (76, '7d9030e8cb5841c288c7d8b2412b97cc', 1, 101, 3152, NULL, '2025-04-09 10:42:05', '2025-04-09 10:42:05', 3);
INSERT INTO `sm_user_exams` VALUES (77, '7d9030e8cb5841c288c7d8b2412b97cc', 1, 104, 3184, NULL, '2025-04-09 10:42:05', '2025-04-09 10:42:05', 3);
INSERT INTO `sm_user_exams` VALUES (78, '7d9030e8cb5841c288c7d8b2412b97cc', 1, 102, 3155, NULL, '2025-04-09 10:42:05', '2025-04-09 10:42:05', 3);
INSERT INTO `sm_user_exams` VALUES (79, '7d9030e8cb5841c288c7d8b2412b97cc', 1, 105, 3158, NULL, '2025-04-09 10:42:05', '2025-04-09 10:42:05', 3);
INSERT INTO `sm_user_exams` VALUES (80, '7d9030e8cb5841c288c7d8b2412b97cc', 1, 109, 3165, NULL, '2025-04-09 10:42:05', '2025-04-09 10:42:05', 3);
INSERT INTO `sm_user_exams` VALUES (81, '7d9030e8cb5841c288c7d8b2412b97cc', 1, 114, 3170, NULL, '2025-04-09 10:42:05', '2025-04-09 10:42:05', 3);
INSERT INTO `sm_user_exams` VALUES (82, '7d9030e8cb5841c288c7d8b2412b97cc', 1, 1000, 0, '1', '2025-04-09 10:42:05', '2025-04-09 10:42:05', 3);
INSERT INTO `sm_user_exams` VALUES (83, '7d9030e8cb5841c288c7d8b2412b97cc', 1, 1000, 0, '2', '2025-04-09 10:42:05', '2025-04-09 10:42:05', 3);
INSERT INTO `sm_user_exams` VALUES (84, '7d9030e8cb5841c288c7d8b2412b97cc', 1, 1000, 0, '3', '2025-04-09 10:42:05', '2025-04-09 10:42:05', 3);
INSERT INTO `sm_user_exams` VALUES (85, '7d9030e8cb5841c288c7d8b2412b97cc', 1, 115, 0, '很重要，very important', '2025-04-09 10:42:05', '2025-04-09 10:42:05', 3);
INSERT INTO `sm_user_exams` VALUES (86, '7d9030e8cb5841c288c7d8b2412b97cc', 1, 110, 0, '不会', '2025-04-09 10:42:05', '2025-04-09 10:42:05', 3);
INSERT INTO `sm_user_exams` VALUES (87, '3726d7f8325b4fe6ad281755bb61fa16', 1, 111, 3168, NULL, '2025-04-09 12:10:12', '2025-04-09 12:10:12', 1);
INSERT INTO `sm_user_exams` VALUES (88, '3726d7f8325b4fe6ad281755bb61fa16', 1, 110, 0, '请问', '2025-04-09 12:10:12', '2025-04-09 12:10:12', 1);
INSERT INTO `sm_user_exams` VALUES (89, '3726d7f8325b4fe6ad281755bb61fa16', 1, 1000, 0, '阿', '2025-04-09 12:10:12', '2025-04-09 12:10:12', 1);
INSERT INTO `sm_user_exams` VALUES (90, '3726d7f8325b4fe6ad281755bb61fa16', 1, 115, 0, '亲王2', '2025-04-09 12:10:12', '2025-04-09 12:10:12', 1);
INSERT INTO `sm_user_exams` VALUES (91, '3726d7f8325b4fe6ad281755bb61fa16', 1, 103, 3179, NULL, '2025-04-09 12:10:12', '2025-04-09 12:10:12', 1);
INSERT INTO `sm_user_exams` VALUES (92, '3726d7f8325b4fe6ad281755bb61fa16', 1, 101, 3154, NULL, '2025-04-09 12:10:12', '2025-04-09 12:10:12', 1);
INSERT INTO `sm_user_exams` VALUES (93, '3726d7f8325b4fe6ad281755bb61fa16', 1, 109, 3166, NULL, '2025-04-09 12:10:12', '2025-04-09 12:10:12', 1);
INSERT INTO `sm_user_exams` VALUES (94, '3726d7f8325b4fe6ad281755bb61fa16', 1, 102, 3157, NULL, '2025-04-09 12:10:12', '2025-04-09 12:10:12', 1);
INSERT INTO `sm_user_exams` VALUES (95, '3726d7f8325b4fe6ad281755bb61fa16', 1, 104, 3183, NULL, '2025-04-09 12:10:12', '2025-04-09 12:10:12', 1);
INSERT INTO `sm_user_exams` VALUES (96, '3726d7f8325b4fe6ad281755bb61fa16', 1, 1002, 7, NULL, '2025-04-09 12:10:12', '2025-04-09 12:10:12', 1);
INSERT INTO `sm_user_exams` VALUES (97, '3726d7f8325b4fe6ad281755bb61fa16', 1, 105, 3159, NULL, '2025-04-09 12:10:12', '2025-04-09 12:10:12', 1);
INSERT INTO `sm_user_exams` VALUES (98, '3726d7f8325b4fe6ad281755bb61fa16', 1, 114, 3170, NULL, '2025-04-09 12:10:12', '2025-04-09 12:10:12', 1);
INSERT INTO `sm_user_exams` VALUES (99, '3726d7f8325b4fe6ad281755bb61fa16', 1, 1000, 0, '12rtq', '2025-04-09 12:10:12', '2025-04-09 12:10:12', 1);
INSERT INTO `sm_user_exams` VALUES (100, '3726d7f8325b4fe6ad281755bb61fa16', 1, 1000, 0, 'wqe', '2025-04-09 12:10:12', '2025-04-09 12:10:12', 1);
INSERT INTO `sm_user_exams` VALUES (101, '7d9030e8cb5841c288c7d8b2412b97cc', 52, 1162, 0, '2', '2025-04-09 18:28:02', '2025-04-09 18:28:02', 1);
INSERT INTO `sm_user_exams` VALUES (102, '7d9030e8cb5841c288c7d8b2412b97cc', 52, 1009, 3241, NULL, '2025-04-09 18:28:02', '2025-04-09 18:28:02', 1);
INSERT INTO `sm_user_exams` VALUES (103, '7d9030e8cb5841c288c7d8b2412b97cc', 52, 1005, 3227, NULL, '2025-04-09 18:28:02', '2025-04-09 18:28:02', 1);
INSERT INTO `sm_user_exams` VALUES (104, '7d9030e8cb5841c288c7d8b2412b97cc', 52, 1009, 3240, NULL, '2025-04-09 18:28:02', '2025-04-09 18:28:02', 1);
INSERT INTO `sm_user_exams` VALUES (105, '7d9030e8cb5841c288c7d8b2412b97cc', 52, 1010, 3244, NULL, '2025-04-09 18:28:02', '2025-04-09 18:28:02', 1);
INSERT INTO `sm_user_exams` VALUES (106, '7d9030e8cb5841c288c7d8b2412b97cc', 52, 1008, 0, '营养丰富', '2025-04-09 18:28:02', '2025-04-09 18:28:02', 1);
INSERT INTO `sm_user_exams` VALUES (107, '7bdc4b7c11524a42851dfd2283cbf9c1', 37, 1162, 0, '1', '2025-04-10 10:24:35', '2025-04-10 10:24:35', 1);
INSERT INTO `sm_user_exams` VALUES (108, '7bdc4b7c11524a42851dfd2283cbf9c1', 37, 112, 3198, NULL, '2025-04-10 10:24:35', '2025-04-10 10:24:35', 1);
INSERT INTO `sm_user_exams` VALUES (109, '7bdc4b7c11524a42851dfd2283cbf9c1', 37, 1005, 3227, NULL, '2025-04-10 10:24:35', '2025-04-10 10:24:35', 1);
INSERT INTO `sm_user_exams` VALUES (110, '7bdc4b7c11524a42851dfd2283cbf9c1', 37, 1010, 3244, NULL, '2025-04-10 10:24:35', '2025-04-10 10:24:35', 1);
INSERT INTO `sm_user_exams` VALUES (111, '7bdc4b7c11524a42851dfd2283cbf9c1', 37, 1009, 3241, NULL, '2025-04-10 10:24:35', '2025-04-10 10:24:35', 1);
INSERT INTO `sm_user_exams` VALUES (112, '7bdc4b7c11524a42851dfd2283cbf9c1', 37, 1009, 3240, NULL, '2025-04-10 10:24:35', '2025-04-10 10:24:35', 1);
INSERT INTO `sm_user_exams` VALUES (113, '7bdc4b7c11524a42851dfd2283cbf9c1', 37, 1008, 0, '1', '2025-04-10 10:24:35', '2025-04-10 10:24:35', 1);
INSERT INTO `sm_user_exams` VALUES (114, '7bdc4b7c11524a42851dfd2283cbf9c1', 38, 1018, 3272, NULL, '2025-04-10 10:26:30', '2025-04-10 10:26:30', 1);
INSERT INTO `sm_user_exams` VALUES (115, '7bdc4b7c11524a42851dfd2283cbf9c1', 38, 1013, 3254, NULL, '2025-04-10 10:26:30', '2025-04-10 10:26:30', 1);
INSERT INTO `sm_user_exams` VALUES (116, '7bdc4b7c11524a42851dfd2283cbf9c1', 38, 1014, 3256, NULL, '2025-04-10 10:26:30', '2025-04-10 10:26:30', 1);
INSERT INTO `sm_user_exams` VALUES (117, '7bdc4b7c11524a42851dfd2283cbf9c1', 38, 1017, 3269, NULL, '2025-04-10 10:26:30', '2025-04-10 10:26:30', 1);
INSERT INTO `sm_user_exams` VALUES (118, '7bdc4b7c11524a42851dfd2283cbf9c1', 38, 1016, 3266, NULL, '2025-04-10 10:26:30', '2025-04-10 10:26:30', 1);
INSERT INTO `sm_user_exams` VALUES (119, '7bdc4b7c11524a42851dfd2283cbf9c1', 38, 1015, 3261, NULL, '2025-04-10 10:26:30', '2025-04-10 10:26:30', 1);
INSERT INTO `sm_user_exams` VALUES (120, '7bdc4b7c11524a42851dfd2283cbf9c1', 38, 1018, 3273, NULL, '2025-04-10 10:26:30', '2025-04-10 10:26:30', 1);
INSERT INTO `sm_user_exams` VALUES (121, '7bdc4b7c11524a42851dfd2283cbf9c1', 38, 1018, 3274, NULL, '2025-04-10 10:26:30', '2025-04-10 10:26:30', 1);
INSERT INTO `sm_user_exams` VALUES (122, '7bdc4b7c11524a42851dfd2283cbf9c1', 38, 1018, 3276, NULL, '2025-04-10 10:26:30', '2025-04-10 10:26:30', 1);
INSERT INTO `sm_user_exams` VALUES (123, '7bdc4b7c11524a42851dfd2283cbf9c1', 38, 1018, 3277, NULL, '2025-04-10 10:26:30', '2025-04-10 10:26:30', 1);
INSERT INTO `sm_user_exams` VALUES (124, '7bdc4b7c11524a42851dfd2283cbf9c1', 38, 1018, 3275, NULL, '2025-04-10 10:26:30', '2025-04-10 10:26:30', 1);
INSERT INTO `sm_user_exams` VALUES (125, '7bdc4b7c11524a42851dfd2283cbf9c1', 38, 1019, 3278, NULL, '2025-04-10 10:26:30', '2025-04-10 10:26:30', 1);
INSERT INTO `sm_user_exams` VALUES (126, '7bdc4b7c11524a42851dfd2283cbf9c1', 38, 1019, 3281, NULL, '2025-04-10 10:26:30', '2025-04-10 10:26:30', 1);
INSERT INTO `sm_user_exams` VALUES (127, '7bdc4b7c11524a42851dfd2283cbf9c1', 38, 1019, 3280, NULL, '2025-04-10 10:26:30', '2025-04-10 10:26:30', 1);
INSERT INTO `sm_user_exams` VALUES (128, '7bdc4b7c11524a42851dfd2283cbf9c1', 38, 1020, 3282, NULL, '2025-04-10 10:26:30', '2025-04-10 10:26:30', 1);
INSERT INTO `sm_user_exams` VALUES (129, '7bdc4b7c11524a42851dfd2283cbf9c1', 38, 1020, 3283, NULL, '2025-04-10 10:26:30', '2025-04-10 10:26:30', 1);
INSERT INTO `sm_user_exams` VALUES (130, '7bdc4b7c11524a42851dfd2283cbf9c1', 38, 1020, 3286, NULL, '2025-04-10 10:26:30', '2025-04-10 10:26:30', 1);
INSERT INTO `sm_user_exams` VALUES (131, '7bdc4b7c11524a42851dfd2283cbf9c1', 38, 1020, 3284, NULL, '2025-04-10 10:26:30', '2025-04-10 10:26:30', 1);
INSERT INTO `sm_user_exams` VALUES (132, '7bdc4b7c11524a42851dfd2283cbf9c1', 38, 1021, 3287, NULL, '2025-04-10 10:26:30', '2025-04-10 10:26:30', 1);
INSERT INTO `sm_user_exams` VALUES (133, '7bdc4b7c11524a42851dfd2283cbf9c1', 38, 1021, 3290, NULL, '2025-04-10 10:26:30', '2025-04-10 10:26:30', 1);
INSERT INTO `sm_user_exams` VALUES (134, '7bdc4b7c11524a42851dfd2283cbf9c1', 38, 1020, 3285, NULL, '2025-04-10 10:26:30', '2025-04-10 10:26:30', 1);
INSERT INTO `sm_user_exams` VALUES (135, '7bdc4b7c11524a42851dfd2283cbf9c1', 38, 1021, 3288, NULL, '2025-04-10 10:26:30', '2025-04-10 10:26:30', 1);
INSERT INTO `sm_user_exams` VALUES (136, '7bdc4b7c11524a42851dfd2283cbf9c1', 38, 1021, 3291, NULL, '2025-04-10 10:26:30', '2025-04-10 10:26:30', 1);
INSERT INTO `sm_user_exams` VALUES (137, '7bdc4b7c11524a42851dfd2283cbf9c1', 38, 1021, 3289, NULL, '2025-04-10 10:26:30', '2025-04-10 10:26:30', 1);
INSERT INTO `sm_user_exams` VALUES (138, '7bdc4b7c11524a42851dfd2283cbf9c1', 38, 1022, 3292, NULL, '2025-04-10 10:26:30', '2025-04-10 10:26:30', 1);
INSERT INTO `sm_user_exams` VALUES (139, '7bdc4b7c11524a42851dfd2283cbf9c1', 38, 1022, 3293, NULL, '2025-04-10 10:26:30', '2025-04-10 10:26:30', 1);
INSERT INTO `sm_user_exams` VALUES (140, '7bdc4b7c11524a42851dfd2283cbf9c1', 38, 1022, 3294, NULL, '2025-04-10 10:26:30', '2025-04-10 10:26:30', 1);
INSERT INTO `sm_user_exams` VALUES (141, '7bdc4b7c11524a42851dfd2283cbf9c1', 38, 1022, 3295, NULL, '2025-04-10 10:26:30', '2025-04-10 10:26:30', 1);
INSERT INTO `sm_user_exams` VALUES (142, '7bdc4b7c11524a42851dfd2283cbf9c1', 38, 1023, 3296, NULL, '2025-04-10 10:26:30', '2025-04-10 10:26:30', 1);
INSERT INTO `sm_user_exams` VALUES (143, '7bdc4b7c11524a42851dfd2283cbf9c1', 38, 1024, 3298, NULL, '2025-04-10 10:26:30', '2025-04-10 10:26:30', 1);
INSERT INTO `sm_user_exams` VALUES (144, '7bdc4b7c11524a42851dfd2283cbf9c1', 38, 1025, 3301, NULL, '2025-04-10 10:26:30', '2025-04-10 10:26:30', 1);
INSERT INTO `sm_user_exams` VALUES (145, '7bdc4b7c11524a42851dfd2283cbf9c1', 38, 1026, 3302, NULL, '2025-04-10 10:26:30', '2025-04-10 10:26:30', 1);
INSERT INTO `sm_user_exams` VALUES (146, '4b1081937a8e4f67a7115bbdaeb2cf17', 37, 1009, 3241, NULL, '2025-04-10 10:27:30', '2025-04-10 10:27:30', 1);
INSERT INTO `sm_user_exams` VALUES (147, '4b1081937a8e4f67a7115bbdaeb2cf17', 37, 1009, 3240, NULL, '2025-04-10 10:27:30', '2025-04-10 10:27:30', 1);
INSERT INTO `sm_user_exams` VALUES (148, '4b1081937a8e4f67a7115bbdaeb2cf17', 37, 112, 3198, NULL, '2025-04-10 10:27:30', '2025-04-10 10:27:30', 1);
INSERT INTO `sm_user_exams` VALUES (149, '4b1081937a8e4f67a7115bbdaeb2cf17', 37, 1005, 3227, NULL, '2025-04-10 10:27:30', '2025-04-10 10:27:30', 1);
INSERT INTO `sm_user_exams` VALUES (150, '4b1081937a8e4f67a7115bbdaeb2cf17', 37, 1162, 0, '5', '2025-04-10 10:27:30', '2025-04-10 10:27:30', 1);
INSERT INTO `sm_user_exams` VALUES (151, '4b1081937a8e4f67a7115bbdaeb2cf17', 37, 1010, 3244, NULL, '2025-04-10 10:27:30', '2025-04-10 10:27:30', 1);
INSERT INTO `sm_user_exams` VALUES (152, '4b1081937a8e4f67a7115bbdaeb2cf17', 37, 1008, 0, '1', '2025-04-10 10:27:30', '2025-04-10 10:27:30', 1);
INSERT INTO `sm_user_exams` VALUES (153, '4b1081937a8e4f67a7115bbdaeb2cf17', 38, 1013, 3254, NULL, '2025-04-10 10:28:32', '2025-04-10 10:28:32', 1);
INSERT INTO `sm_user_exams` VALUES (154, '4b1081937a8e4f67a7115bbdaeb2cf17', 38, 1014, 3260, NULL, '2025-04-10 10:28:32', '2025-04-10 10:28:32', 1);
INSERT INTO `sm_user_exams` VALUES (155, '4b1081937a8e4f67a7115bbdaeb2cf17', 38, 1015, 3261, NULL, '2025-04-10 10:28:32', '2025-04-10 10:28:32', 1);
INSERT INTO `sm_user_exams` VALUES (156, '4b1081937a8e4f67a7115bbdaeb2cf17', 38, 1016, 3266, NULL, '2025-04-10 10:28:32', '2025-04-10 10:28:32', 1);
INSERT INTO `sm_user_exams` VALUES (157, '4b1081937a8e4f67a7115bbdaeb2cf17', 38, 1017, 3269, NULL, '2025-04-10 10:28:32', '2025-04-10 10:28:32', 1);
INSERT INTO `sm_user_exams` VALUES (158, '4b1081937a8e4f67a7115bbdaeb2cf17', 38, 1018, 3272, NULL, '2025-04-10 10:28:32', '2025-04-10 10:28:32', 1);
INSERT INTO `sm_user_exams` VALUES (159, '4b1081937a8e4f67a7115bbdaeb2cf17', 38, 1018, 3273, NULL, '2025-04-10 10:28:32', '2025-04-10 10:28:32', 1);
INSERT INTO `sm_user_exams` VALUES (160, '4b1081937a8e4f67a7115bbdaeb2cf17', 38, 1018, 3274, NULL, '2025-04-10 10:28:32', '2025-04-10 10:28:32', 1);
INSERT INTO `sm_user_exams` VALUES (161, '4b1081937a8e4f67a7115bbdaeb2cf17', 38, 1018, 3275, NULL, '2025-04-10 10:28:32', '2025-04-10 10:28:32', 1);
INSERT INTO `sm_user_exams` VALUES (162, '4b1081937a8e4f67a7115bbdaeb2cf17', 38, 1018, 3276, NULL, '2025-04-10 10:28:32', '2025-04-10 10:28:32', 1);
INSERT INTO `sm_user_exams` VALUES (163, '4b1081937a8e4f67a7115bbdaeb2cf17', 38, 1018, 3277, NULL, '2025-04-10 10:28:32', '2025-04-10 10:28:32', 1);
INSERT INTO `sm_user_exams` VALUES (164, '4b1081937a8e4f67a7115bbdaeb2cf17', 38, 1019, 3278, NULL, '2025-04-10 10:28:32', '2025-04-10 10:28:32', 1);
INSERT INTO `sm_user_exams` VALUES (165, '4b1081937a8e4f67a7115bbdaeb2cf17', 38, 1019, 3280, NULL, '2025-04-10 10:28:32', '2025-04-10 10:28:32', 1);
INSERT INTO `sm_user_exams` VALUES (166, '4b1081937a8e4f67a7115bbdaeb2cf17', 38, 1019, 3281, NULL, '2025-04-10 10:28:32', '2025-04-10 10:28:32', 1);
INSERT INTO `sm_user_exams` VALUES (167, '4b1081937a8e4f67a7115bbdaeb2cf17', 38, 1019, 3279, NULL, '2025-04-10 10:28:32', '2025-04-10 10:28:32', 1);
INSERT INTO `sm_user_exams` VALUES (168, '4b1081937a8e4f67a7115bbdaeb2cf17', 38, 1020, 3283, NULL, '2025-04-10 10:28:32', '2025-04-10 10:28:32', 1);
INSERT INTO `sm_user_exams` VALUES (169, '4b1081937a8e4f67a7115bbdaeb2cf17', 38, 1020, 3282, NULL, '2025-04-10 10:28:32', '2025-04-10 10:28:32', 1);
INSERT INTO `sm_user_exams` VALUES (170, '4b1081937a8e4f67a7115bbdaeb2cf17', 38, 1020, 3286, NULL, '2025-04-10 10:28:32', '2025-04-10 10:28:32', 1);
INSERT INTO `sm_user_exams` VALUES (171, '4b1081937a8e4f67a7115bbdaeb2cf17', 38, 1020, 3284, NULL, '2025-04-10 10:28:32', '2025-04-10 10:28:32', 1);
INSERT INTO `sm_user_exams` VALUES (172, '4b1081937a8e4f67a7115bbdaeb2cf17', 38, 1020, 3285, NULL, '2025-04-10 10:28:32', '2025-04-10 10:28:32', 1);
INSERT INTO `sm_user_exams` VALUES (173, '4b1081937a8e4f67a7115bbdaeb2cf17', 38, 1021, 3287, NULL, '2025-04-10 10:28:32', '2025-04-10 10:28:32', 1);
INSERT INTO `sm_user_exams` VALUES (174, '4b1081937a8e4f67a7115bbdaeb2cf17', 38, 1021, 3290, NULL, '2025-04-10 10:28:32', '2025-04-10 10:28:32', 1);
INSERT INTO `sm_user_exams` VALUES (175, '4b1081937a8e4f67a7115bbdaeb2cf17', 38, 1021, 3291, NULL, '2025-04-10 10:28:32', '2025-04-10 10:28:32', 1);
INSERT INTO `sm_user_exams` VALUES (176, '4b1081937a8e4f67a7115bbdaeb2cf17', 38, 1021, 3288, NULL, '2025-04-10 10:28:32', '2025-04-10 10:28:32', 1);
INSERT INTO `sm_user_exams` VALUES (177, '4b1081937a8e4f67a7115bbdaeb2cf17', 38, 1021, 3289, NULL, '2025-04-10 10:28:32', '2025-04-10 10:28:32', 1);
INSERT INTO `sm_user_exams` VALUES (178, '4b1081937a8e4f67a7115bbdaeb2cf17', 38, 1022, 3292, NULL, '2025-04-10 10:28:32', '2025-04-10 10:28:32', 1);
INSERT INTO `sm_user_exams` VALUES (179, '4b1081937a8e4f67a7115bbdaeb2cf17', 38, 1022, 3293, NULL, '2025-04-10 10:28:32', '2025-04-10 10:28:32', 1);
INSERT INTO `sm_user_exams` VALUES (180, '4b1081937a8e4f67a7115bbdaeb2cf17', 38, 1022, 3294, NULL, '2025-04-10 10:28:32', '2025-04-10 10:28:32', 1);
INSERT INTO `sm_user_exams` VALUES (181, '4b1081937a8e4f67a7115bbdaeb2cf17', 38, 1022, 3295, NULL, '2025-04-10 10:28:32', '2025-04-10 10:28:32', 1);
INSERT INTO `sm_user_exams` VALUES (182, '4b1081937a8e4f67a7115bbdaeb2cf17', 38, 1023, 3296, NULL, '2025-04-10 10:28:32', '2025-04-10 10:28:32', 1);
INSERT INTO `sm_user_exams` VALUES (183, '4b1081937a8e4f67a7115bbdaeb2cf17', 38, 1024, 3298, NULL, '2025-04-10 10:28:32', '2025-04-10 10:28:32', 1);
INSERT INTO `sm_user_exams` VALUES (184, '4b1081937a8e4f67a7115bbdaeb2cf17', 38, 1025, 3300, NULL, '2025-04-10 10:28:32', '2025-04-10 10:28:32', 1);
INSERT INTO `sm_user_exams` VALUES (185, '4b1081937a8e4f67a7115bbdaeb2cf17', 38, 1026, 3302, NULL, '2025-04-10 10:28:32', '2025-04-10 10:28:32', 1);
INSERT INTO `sm_user_exams` VALUES (186, '44964845a7db45b4b6b1d7ed98761ee9', 37, 1005, 3227, NULL, '2025-04-10 10:29:24', '2025-04-10 10:29:24', 1);
INSERT INTO `sm_user_exams` VALUES (187, '44964845a7db45b4b6b1d7ed98761ee9', 37, 112, 3198, NULL, '2025-04-10 10:29:24', '2025-04-10 10:29:24', 1);
INSERT INTO `sm_user_exams` VALUES (188, '44964845a7db45b4b6b1d7ed98761ee9', 37, 1009, 3241, NULL, '2025-04-10 10:29:24', '2025-04-10 10:29:24', 1);
INSERT INTO `sm_user_exams` VALUES (189, '44964845a7db45b4b6b1d7ed98761ee9', 37, 1009, 3240, NULL, '2025-04-10 10:29:24', '2025-04-10 10:29:24', 1);
INSERT INTO `sm_user_exams` VALUES (190, '44964845a7db45b4b6b1d7ed98761ee9', 37, 1010, 3244, NULL, '2025-04-10 10:29:24', '2025-04-10 10:29:24', 1);
INSERT INTO `sm_user_exams` VALUES (191, '44964845a7db45b4b6b1d7ed98761ee9', 37, 1162, 0, '6', '2025-04-10 10:29:24', '2025-04-10 10:29:24', 1);
INSERT INTO `sm_user_exams` VALUES (192, '44964845a7db45b4b6b1d7ed98761ee9', 37, 1008, 0, '2', '2025-04-10 10:29:24', '2025-04-10 10:29:24', 1);
INSERT INTO `sm_user_exams` VALUES (193, '7d9030e8cb5841c288c7d8b2412b97cc', 55, 1009, 3240, NULL, '2025-04-10 13:36:35', '2025-04-10 13:36:35', 1);
INSERT INTO `sm_user_exams` VALUES (194, '7d9030e8cb5841c288c7d8b2412b97cc', 55, 1006, 3234, NULL, '2025-04-10 13:36:35', '2025-04-10 13:36:35', 1);
INSERT INTO `sm_user_exams` VALUES (195, '7d9030e8cb5841c288c7d8b2412b97cc', 55, 1011, 3246, NULL, '2025-04-10 13:36:35', '2025-04-10 13:36:35', 1);
INSERT INTO `sm_user_exams` VALUES (196, '7d9030e8cb5841c288c7d8b2412b97cc', 55, 1162, 0, '1', '2025-04-10 13:36:35', '2025-04-10 13:36:35', 1);
INSERT INTO `sm_user_exams` VALUES (197, '7d9030e8cb5841c288c7d8b2412b97cc', 45, 1027, 3304, NULL, '2025-04-10 13:38:17', '2025-04-10 13:38:17', 1);
INSERT INTO `sm_user_exams` VALUES (198, '7d9030e8cb5841c288c7d8b2412b97cc', 45, 1029, 3314, NULL, '2025-04-10 13:38:17', '2025-04-10 13:38:17', 1);
INSERT INTO `sm_user_exams` VALUES (199, '7d9030e8cb5841c288c7d8b2412b97cc', 45, 1030, 3317, NULL, '2025-04-10 13:38:17', '2025-04-10 13:38:17', 1);
INSERT INTO `sm_user_exams` VALUES (200, '7d9030e8cb5841c288c7d8b2412b97cc', 45, 1030, 3318, NULL, '2025-04-10 13:38:17', '2025-04-10 13:38:17', 1);
INSERT INTO `sm_user_exams` VALUES (201, '7d9030e8cb5841c288c7d8b2412b97cc', 45, 1030, 3316, NULL, '2025-04-10 13:38:17', '2025-04-10 13:38:17', 1);
INSERT INTO `sm_user_exams` VALUES (202, '7d9030e8cb5841c288c7d8b2412b97cc', 45, 1030, 3319, NULL, '2025-04-10 13:38:17', '2025-04-10 13:38:17', 1);
INSERT INTO `sm_user_exams` VALUES (203, '7d9030e8cb5841c288c7d8b2412b97cc', 45, 1030, 3320, NULL, '2025-04-10 13:38:17', '2025-04-10 13:38:17', 1);
INSERT INTO `sm_user_exams` VALUES (204, '7d9030e8cb5841c288c7d8b2412b97cc', 45, 1031, 3321, NULL, '2025-04-10 13:38:17', '2025-04-10 13:38:17', 1);
INSERT INTO `sm_user_exams` VALUES (205, '7d9030e8cb5841c288c7d8b2412b97cc', 45, 1031, 3322, NULL, '2025-04-10 13:38:17', '2025-04-10 13:38:17', 1);
INSERT INTO `sm_user_exams` VALUES (206, '7d9030e8cb5841c288c7d8b2412b97cc', 45, 1031, 3324, NULL, '2025-04-10 13:38:17', '2025-04-10 13:38:17', 1);
INSERT INTO `sm_user_exams` VALUES (207, '7d9030e8cb5841c288c7d8b2412b97cc', 45, 1031, 3325, NULL, '2025-04-10 13:38:17', '2025-04-10 13:38:17', 1);
INSERT INTO `sm_user_exams` VALUES (208, '7d9030e8cb5841c288c7d8b2412b97cc', 45, 1035, 3329, NULL, '2025-04-10 13:38:17', '2025-04-10 13:38:17', 1);
INSERT INTO `sm_user_exams` VALUES (209, '7d9030e8cb5841c288c7d8b2412b97cc', 45, 1036, 3331, NULL, '2025-04-10 13:38:17', '2025-04-10 13:38:17', 1);
INSERT INTO `sm_user_exams` VALUES (210, '7d9030e8cb5841c288c7d8b2412b97cc', 45, 1033, 0, '2', '2025-04-10 13:38:17', '2025-04-10 13:38:17', 1);
INSERT INTO `sm_user_exams` VALUES (211, '7d9030e8cb5841c288c7d8b2412b97cc', 45, 1032, 0, '1', '2025-04-10 13:38:17', '2025-04-10 13:38:17', 1);
INSERT INTO `sm_user_exams` VALUES (212, '7d9030e8cb5841c288c7d8b2412b97cc', 45, 1037, 0, '1', '2025-04-10 13:38:17', '2025-04-10 13:38:17', 1);
INSERT INTO `sm_user_exams` VALUES (213, '7d9030e8cb5841c288c7d8b2412b97cc', 44, 118, 3209, NULL, '2025-04-10 13:39:25', '2025-04-10 13:39:25', 1);
INSERT INTO `sm_user_exams` VALUES (214, '7d9030e8cb5841c288c7d8b2412b97cc', 44, 118, 3208, NULL, '2025-04-10 13:39:25', '2025-04-10 13:39:25', 1);
INSERT INTO `sm_user_exams` VALUES (215, '7d9030e8cb5841c288c7d8b2412b97cc', 44, 1031, 3322, NULL, '2025-04-10 13:39:25', '2025-04-10 13:39:25', 1);
INSERT INTO `sm_user_exams` VALUES (216, '7d9030e8cb5841c288c7d8b2412b97cc', 44, 1031, 3321, NULL, '2025-04-10 13:39:25', '2025-04-10 13:39:25', 1);
INSERT INTO `sm_user_exams` VALUES (217, '7d9030e8cb5841c288c7d8b2412b97cc', 44, 118, 3211, NULL, '2025-04-10 13:39:25', '2025-04-10 13:39:25', 1);
INSERT INTO `sm_user_exams` VALUES (218, '7d9030e8cb5841c288c7d8b2412b97cc', 44, 1031, 3324, NULL, '2025-04-10 13:39:25', '2025-04-10 13:39:25', 1);
INSERT INTO `sm_user_exams` VALUES (219, '7d9030e8cb5841c288c7d8b2412b97cc', 44, 1031, 3325, NULL, '2025-04-10 13:39:25', '2025-04-10 13:39:25', 1);
INSERT INTO `sm_user_exams` VALUES (220, '7d9030e8cb5841c288c7d8b2412b97cc', 44, 118, 3210, NULL, '2025-04-10 13:39:25', '2025-04-10 13:39:25', 1);
INSERT INTO `sm_user_exams` VALUES (221, '7d9030e8cb5841c288c7d8b2412b97cc', 44, 1036, 3331, NULL, '2025-04-10 13:39:25', '2025-04-10 13:39:25', 1);
INSERT INTO `sm_user_exams` VALUES (222, '7d9030e8cb5841c288c7d8b2412b97cc', 37, 1162, 0, '1', '2025-04-10 15:46:16', '2025-04-10 15:46:16', 1);
INSERT INTO `sm_user_exams` VALUES (223, '7d9030e8cb5841c288c7d8b2412b97cc', 37, 112, 3195, NULL, '2025-04-10 15:46:16', '2025-04-10 15:46:16', 1);
INSERT INTO `sm_user_exams` VALUES (224, '7d9030e8cb5841c288c7d8b2412b97cc', 37, 1005, 3230, NULL, '2025-04-10 15:46:16', '2025-04-10 15:46:16', 1);
INSERT INTO `sm_user_exams` VALUES (225, '7d9030e8cb5841c288c7d8b2412b97cc', 37, 1009, 3241, NULL, '2025-04-10 15:46:16', '2025-04-10 15:46:16', 1);
INSERT INTO `sm_user_exams` VALUES (226, '7d9030e8cb5841c288c7d8b2412b97cc', 37, 1008, 0, '12', '2025-04-10 15:46:16', '2025-04-10 15:46:16', 1);
INSERT INTO `sm_user_exams` VALUES (227, '7d9030e8cb5841c288c7d8b2412b97cc', 37, 1010, 3244, NULL, '2025-04-10 15:46:16', '2025-04-10 15:46:16', 1);
INSERT INTO `sm_user_exams` VALUES (228, '7d9030e8cb5841c288c7d8b2412b97cc', 37, 112, 3198, NULL, '2025-04-10 15:52:44', '2025-04-10 15:52:44', 2);
INSERT INTO `sm_user_exams` VALUES (229, '7d9030e8cb5841c288c7d8b2412b97cc', 37, 1010, 3245, NULL, '2025-04-10 15:52:44', '2025-04-10 15:52:44', 2);
INSERT INTO `sm_user_exams` VALUES (230, '7d9030e8cb5841c288c7d8b2412b97cc', 37, 1009, 3243, NULL, '2025-04-10 15:52:44', '2025-04-10 15:52:44', 2);
INSERT INTO `sm_user_exams` VALUES (231, '7d9030e8cb5841c288c7d8b2412b97cc', 37, 1005, 3230, NULL, '2025-04-10 15:52:44', '2025-04-10 15:52:44', 2);
INSERT INTO `sm_user_exams` VALUES (232, '7d9030e8cb5841c288c7d8b2412b97cc', 37, 1162, 0, '<script>test(); function test(){alert(123);}</script>', '2025-04-10 15:52:44', '2025-04-10 15:52:44', 2);
INSERT INTO `sm_user_exams` VALUES (233, '7d9030e8cb5841c288c7d8b2412b97cc', 37, 1008, 0, '<script>test(); function test(){alert(123);}</script>', '2025-04-10 15:52:44', '2025-04-10 15:52:44', 2);

-- ----------------------------
-- Table structure for sm_users
-- ----------------------------
DROP TABLE IF EXISTS `sm_users`;
CREATE TABLE `sm_users`  (
  `user_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `user_number` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `contact_info` char(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `user_password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `type_id` int UNSIGNED NULL DEFAULT NULL,
  `department` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `user_gender` tinyint UNSIGNED NULL DEFAULT NULL,
  `user_img` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `time_create` datetime NULL DEFAULT NULL,
  `time_modify` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sm_users
-- ----------------------------
INSERT INTO `sm_users` VALUES ('3726d7f8325b4fe6ad281755bb61fa16', 'test', '2025182345', '156987564', 'c16a41e5cd43e0f481c9fc99e2b16057115194fe8073187e', 1000, '基层一线', 0, 'https://img.shetu66.com/2023/04/25/1682391088794617.png', '2025-04-09 11:55:28', '2025-04-10 15:47:52');
INSERT INTO `sm_users` VALUES ('44964845a7db45b4b6b1d7ed98761ee9', '张三', '202012345612', NULL, 'c3b457d1bb88f5478b653637f8fc7c54f06e94334ee19756', 1000, '基层二线', 0, 'https://tse4-mm.cn.bing.net/th/id/OIP-C.JCEcaQJVR_vC2kgt6BGZlAAAAA?rs=1&pid=ImgDetMain', '2025-03-31 11:58:12', '2025-04-10 13:47:28');
INSERT INTO `sm_users` VALUES ('4b1081937a8e4f67a7115bbdaeb2cf17', '维斯将', '202312345121', '13412345677', '84621339ba94d3c52497c61cc32c6157b84291d968b3ee5f', 1000, '基层一线', 0, 'https://www.keaitupian.cn/cjpic/frombd/1/253/553424311/2788528016.jpg', '2025-04-09 11:58:51', '2025-04-09 14:47:16');
INSERT INTO `sm_users` VALUES ('74f587743e1044699939145d24ef4bdf', '崔静', '202261477916', NULL, 'e2e93e493f9109d802d22b77a0644805ee9b521a61393606', 1000, NULL, 1, NULL, '2025-04-10 11:21:04', '2025-04-10 11:21:04');
INSERT INTO `sm_users` VALUES ('7bdc4b7c11524a42851dfd2283cbf9c1', '温回力', '202212561341', NULL, '98dc4c977c32091614e0d55285329507878732f131f62865', 1000, '基层一线', 1, 'https://tse2-mm.cn.bing.net/th/id/OIP-C.vqcOLKlCWwWg2kDEqd3s7QHaE8?rs=1&pid=ImgDetMain', '2025-04-09 11:59:41', '2025-04-09 14:31:36');
INSERT INTO `sm_users` VALUES ('7d9030e8cb5841c288c7d8b2412b97cc', '陈亿', '202225220303', '19859802622', '790c7b910f8eb1604e22078ce34c85170a0842500a816010', 1000, '基层一线', 1, 'https://img.shetu66.com/2023/04/25/1682391088794617.png', '2025-03-30 11:22:46', '2025-04-08 19:33:48');
INSERT INTO `sm_users` VALUES ('8636d364052b4fd1afbe0a478d1fecb8', '管李员', '202218330113', NULL, '718d1595023ca3768a37267014251925b07929d68398f46e', 1111, '管理部门', 0, 'https://www.keaitupian.cn/cjpic/frombd/0/253/514208677/1191973426.jpg', '2025-04-01 11:24:34', '2025-04-09 11:43:46');
INSERT INTO `sm_users` VALUES ('ce6062f1efa8422090d17d000e525a73', '关理员', '202225220313', '1111111111', 'a91879a81a7eb79f0b826c7040b41d44a364e61c3641b305', 1111, '管理部门', 1, 'https://pica.zhimg.com/v2-a89d7a5e0a4464ebd627a514f3f76b3a_720w.jpg?source=172ae18b', '2025-04-08 19:32:31', '2025-04-09 10:22:51');

-- ----------------------------
-- Triggers structure for table sm_item_bank
-- ----------------------------
DROP TRIGGER IF EXISTS `trg_sm_item_bank_insert`;
delimiter ;;
CREATE TRIGGER `trg_sm_item_bank_insert` AFTER INSERT ON `sm_item_bank` FOR EACH ROW BEGIN
    -- 增加对应 bank_id 的 item_count
    UPDATE sm_bank_info
    SET item_count = item_count + 1
    WHERE bank_id = NEW.bank_id;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table sm_item_bank
-- ----------------------------
DROP TRIGGER IF EXISTS `trg_sm_item_bank_update`;
delimiter ;;
CREATE TRIGGER `trg_sm_item_bank_update` AFTER UPDATE ON `sm_item_bank` FOR EACH ROW BEGIN
    -- 如果 bank_id 发生变化
    IF OLD.bank_id != NEW.bank_id THEN
        -- 减少原 bank_id 的 item_count
        UPDATE sm_bank_info
        SET item_count = item_count - 1
        WHERE bank_id = OLD.bank_id;

        -- 增加新 bank_id 的 item_count
        UPDATE sm_bank_info
        SET item_count = item_count + 1
        WHERE bank_id = NEW.bank_id;
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table sm_item_bank
-- ----------------------------
DROP TRIGGER IF EXISTS `trg_sm_item_bank_delete`;
delimiter ;;
CREATE TRIGGER `trg_sm_item_bank_delete` AFTER DELETE ON `sm_item_bank` FOR EACH ROW BEGIN
    -- 减少对应 bank_id 的 item_count
    UPDATE sm_bank_info
    SET item_count = item_count - 1
    WHERE bank_id = OLD.bank_id;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table sm_item_bank
-- ----------------------------
DROP TRIGGER IF EXISTS `update_total_score_after_item_score_update`;
delimiter ;;
CREATE TRIGGER `update_total_score_after_item_score_update` AFTER UPDATE ON `sm_item_bank` FOR EACH ROW BEGIN
    IF OLD.item_score <> NEW.item_score THEN
        -- 更新所有包含该题目的试卷的总分
        UPDATE sm_papers_info pi
        JOIN (
            SELECT p.paper_id
            FROM sm_papers p
            JOIN sm_item_bank ib ON p.item_id = ib.item_id
            WHERE ib.item_id = NEW.item_id
            GROUP BY p.paper_id
        ) AS subquery ON pi.paper_id = subquery.paper_id
        SET pi.total_score = (
            SELECT SUM(ib.item_score)
            FROM sm_papers p
            JOIN sm_item_bank ib ON p.item_id = ib.item_id
            WHERE p.paper_id = pi.paper_id
        )
        WHERE pi.paper_id = subquery.paper_id;
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table sm_papers
-- ----------------------------
DROP TRIGGER IF EXISTS `trg_sm_papers_insert`;
delimiter ;;
CREATE TRIGGER `trg_sm_papers_insert` AFTER INSERT ON `sm_papers` FOR EACH ROW BEGIN
    UPDATE `sm_papers_info`
    SET `item_count` = `item_count` + 1
    WHERE `paper_id` = NEW.`paper_id`;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table sm_papers
-- ----------------------------
DROP TRIGGER IF EXISTS `trg_sm_papers_delete`;
delimiter ;;
CREATE TRIGGER `trg_sm_papers_delete` AFTER DELETE ON `sm_papers` FOR EACH ROW BEGIN
    UPDATE `sm_papers_info`
    SET `item_count` = `item_count` - 1
    WHERE `paper_id` = OLD.`paper_id`;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table sm_papers
-- ----------------------------
DROP TRIGGER IF EXISTS `update_total_score_after_insert`;
delimiter ;;
CREATE TRIGGER `update_total_score_after_insert` AFTER INSERT ON `sm_papers` FOR EACH ROW BEGIN
    UPDATE sm_papers_info
    SET total_score = (
        SELECT SUM(item_score)
        FROM sm_papers
        JOIN sm_item_bank ON sm_papers.item_id = sm_item_bank.item_id
        WHERE sm_papers.paper_id = NEW.paper_id
    )
    WHERE paper_id = NEW.paper_id;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table sm_papers
-- ----------------------------
DROP TRIGGER IF EXISTS `update_total_score_after_update`;
delimiter ;;
CREATE TRIGGER `update_total_score_after_update` AFTER UPDATE ON `sm_papers` FOR EACH ROW BEGIN
    UPDATE sm_papers_info
    SET total_score = (
        SELECT SUM(item_score)
        FROM sm_papers
        JOIN sm_item_bank ON sm_papers.item_id = sm_item_bank.item_id
        WHERE sm_papers.paper_id = NEW.paper_id
    )
    WHERE paper_id = NEW.paper_id;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table sm_papers
-- ----------------------------
DROP TRIGGER IF EXISTS `update_total_score_after_delete`;
delimiter ;;
CREATE TRIGGER `update_total_score_after_delete` AFTER DELETE ON `sm_papers` FOR EACH ROW BEGIN
    UPDATE sm_papers_info
    SET total_score = (
        SELECT SUM(item_score)
        FROM sm_papers
        JOIN sm_item_bank ON sm_papers.item_id = sm_item_bank.item_id
        WHERE sm_papers.paper_id = OLD.paper_id
    )
    WHERE paper_id = OLD.paper_id;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
