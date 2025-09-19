/*
 Navicat Premium Dump SQL

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80040 (8.0.40)
 Source Host           : localhost:3306
 Source Schema         : assignment

 Target Server Type    : MySQL
 Target Server Version : 80040 (8.0.40)
 File Encoding         : 65001

 Date: 30/12/2024 22:33:11
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for cultures
-- ----------------------------
DROP TABLE IF EXISTS `cultures`;
CREATE TABLE `cultures`  (
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  INDEX `email`(`email` ASC) USING BTREE,
  CONSTRAINT `email` FOREIGN KEY (`email`) REFERENCES `user` (`email`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cultures
-- ----------------------------
INSERT INTO `cultures` VALUES ('undefined', 'xihu', 'null', '0000000001@qq.com', NULL);
INSERT INTO `cultures` VALUES ('31213', 'do', NULL, '3074548601@qq.com', NULL);
INSERT INTO `cultures` VALUES (NULL, 'donnnn', NULL, '3074548601@qq.com', 'http://localhost:8080/img/cultures/1111.bmp');
INSERT INTO `cultures` VALUES ('杭州市上城区中山中路', '南宋御街文化', '南宋时期的繁华主街，现保留古建筑与商业氛围，街道两旁商铺林立，古色古香，是探索杭州历史文化的好去处。', '3074548601@qq.com', 'http://localhost:8080/img/cultures/南宋御街文化.jpg');
INSERT INTO `cultures` VALUES ('杭州市余杭区瓶窑镇', '良渚文化遗址', '距今约5000年的文明遗址，被列为世界文化遗产，展示了中国新石器时代的社会形态与文化成就，遗址公园内有良渚博物院和考古体验区。', '3074548601@qq.com', 'http://localhost:8080/img/cultures/良渚文化遗址.jpg');

-- ----------------------------
-- Table structure for foods
-- ----------------------------
DROP TABLE IF EXISTS `foods`;
CREATE TABLE `foods`  (
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `material` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  INDEX `fk_foods_user_email`(`email` ASC) USING BTREE,
  CONSTRAINT `fk_food_user_email` FOREIGN KEY (`email`) REFERENCES `user` (`email`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of foods
-- ----------------------------
INSERT INTO `foods` VALUES ('西湖醋鱼', '草鱼、醋、糖、生姜', '西湖醋鱼以鲜美的草鱼为主料，采用杭帮特有的甜酸调味制作，鱼肉鲜嫩入味，酸甜适中.带有淡淡的生姜香气，是杭州市的经典传统名菜，尤其适合搭配白米饭享用。\r\n', 'http://localhost:8080/img/foods/西湖醋鱼.jpg', '3074548601@qq.com');
INSERT INTO `foods` VALUES ('龙井虾仁', '河虾仁、龙井茶、鸡蛋清', '这道菜融合了鲜嫩虾仁与清香龙井茶叶的独特风味，虾仁洁白滑嫩，茶叶点缀其中，既有海鲜的鲜味又带茶香清新，展现了杭州饮食的精致与文化底蕴。', 'http://localhost:8080/img/foods/龙井虾仁.jpg', '3074548601@qq.com');
INSERT INTO `foods` VALUES ('东坡肉', '五花肉、黄酒、酱油、冰糖。', '以五花肉为主料，小火慢炖至入口即化，酱香浓郁，油而不腻，相传为北宋文豪苏东坡创制，是杭州家喻户晓的经典菜肴之一，适合搭配米饭或馒头。', 'http://localhost:8080/img/foods/东坡肉.jpg', '3074548601@qq.com');
INSERT INTO `foods` VALUES ('蜜汁藕', '藕、糯米、红糖、桂花。', '将糯米填入藕孔后煮至软糯，再以红糖和桂花调制蜜汁浇淋，口感软糯香甜，外观金黄诱人，是杭州传统的甜品小吃之一。', 'http://localhost:8080/img/foods/蜜汁藕.jpg', '3074548601@qq.com');
INSERT INTO `foods` VALUES ('定胜糕', '糯米粉、红豆沙、糖', '一种传统蒸糕，以糯米粉制成，内包甜润的红豆沙，口感软糯香甜，寓意“步步高升”，常用于杭州民间庆祝节日或喜事的场合。', 'http://localhost:8080/img/foods/定胜糕.jpg', '3074548601@qq.com');
INSERT INTO `foods` VALUES ('葱包桧', '面皮、香葱、酱油。', '杭州街头小吃，以香葱夹入面皮中，再煎至金黄酥脆，搭配甜酱油食用，香气扑鼻，外皮酥脆内里鲜嫩，是地道杭州风味的代表之一。', 'http://localhost:8080/img/foods/葱包桧.jpg', '3074548601@qq.com');

-- ----------------------------
-- Table structure for scenery
-- ----------------------------
DROP TABLE IF EXISTS `scenery`;
CREATE TABLE `scenery`  (
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  INDEX `scenery`(`email` ASC) USING BTREE,
  CONSTRAINT `scenery` FOREIGN KEY (`email`) REFERENCES `user` (`email`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of scenery
-- ----------------------------
INSERT INTO `scenery` VALUES ('西湖', '西湖以秀丽的自然风光和深厚的文化内涵闻名，十景如苏堤春晓、雷峰夕照尽显湖光山色之美，是杭州的象征，被誉为“人间天堂”。', '杭州市西湖区龙井路1号', '3074548601@qq.com', 'http://localhost:8080/img/scenery/西湖.jpg');
INSERT INTO `scenery` VALUES ('灵隐寺', '创建于东晋的名刹，位于飞来峰下，是中国佛教禅宗的重要道场，寺内环境清幽，石刻艺术精湛，吸引无数信众与游客。', '杭州市西湖区灵隐路法云弄1号', '3074548601@qq.com', 'http://localhost:8080/img/scenery/灵隐寺.jpg');
INSERT INTO `scenery` VALUES ('断桥残雪', '位于西湖白堤，传说是白蛇与许仙初遇的地方，冬雪时桥面残雪点点，与湖面相映成趣，成为杭州爱情文化的象征之一。', '杭州市西湖区北山路白堤东端', '3074548601@qq.com', 'http://localhost:8080/img/scenery/断桥残雪.jpg');
INSERT INTO `scenery` VALUES ('雷峰塔', '始建于公元975年，塔内文物丰富，建筑巍峨壮观，登塔可俯瞰西湖全景，传说与白蛇传故事密切相关，是西湖的重要景观之一。', '杭州市西湖区南山路15号', '3074548601@qq.com', 'http://localhost:8080/img/scenery/雷峰塔.jpg');
INSERT INTO `scenery` VALUES ('九溪烟树', '九溪十八涧的溪流汇聚于此，沿途山林茂密、溪水潺潺，秋天的红叶更是迷人，是徒步和亲近自然的理想选择。', '杭州市西湖区龙井村至九溪村之间', '3074548601@qq.com', 'http://localhost:8080/img/scenery/九溪烟树.jpg');
INSERT INTO `scenery` VALUES ('aqaa', 'DASCASDASDDAS', '瓜沥镇明港城清华园28幢', '3074548601@qq.com', 'http://localhost:8080/img/scenery/1111.bmp');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `userName` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `email` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `realName` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `gender` int NULL DEFAULT NULL,
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `phone` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `office` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `officeAdress` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`email`) USING BTREE,
  UNIQUE INDEX `user_pk2`(`email` ASC) USING BTREE,
  UNIQUE INDEX `user_pk3`(`userName` ASC) USING BTREE,
  UNIQUE INDEX `user_pk4`(`realName` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('oii0', '0000000001@qq.com', '123123', 'QQ', 1, 'http://localhost:8080/img/users/1111.bmp', NULL, NULL, NULL, NULL);
INSERT INTO `user` VALUES ('aaaa', '1111548601@qq.com', '123123', 'aqq', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user` VALUES ('iuyy', '1114228601@qq.com', '123123', 'mybat', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user` VALUES ('pppp', '1776492014@qq.com', '123123', 'ppsp', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user` VALUES ('999', '1836593012@qq.com', '123123', 'wss', 1, 'http://localhost:8080/img/users/ScreenShoot_2024-12-21_172740.png', NULL, NULL, NULL, NULL);
INSERT INTO `user` VALUES ('Tee', '2160459978@qq.com', '123123', 'Sean', 1, 'none', '13867457786', 'qedqcfqfd', 'qwesdxs', 'none');
INSERT INTO `user` VALUES ('wdu', '3000048601@qq.com', '123123', 'saxm', 1, '', NULL, NULL, NULL, NULL);
INSERT INTO `user` VALUES ('qsre', '3042814667@qq.com', 'ewdsh', 'sqaa', 1, NULL, '187647391823', 'CJLU', '浙江, 杭州, 钱塘区', '12ed');
INSERT INTO `user` VALUES ('wows', '3042878865@qq.com', '123123', 'outs', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user` VALUES ('evc', '3074000001@qq.com', '123123', 'fvvv', 1, 'http://localhost:8080/img/users/1111.bmp', NULL, NULL, NULL, NULL);
INSERT INTO `user` VALUES ('Lee', '3074548601@qq.com', '123123', 'Lee', 2, 'http://localhost:8080/img/users/imageERROR.jpg', '17858834388', '信息工程学院', 'CJLU', 'ccccccc');
INSERT INTO `user` VALUES ('ffff', '3224167234@qq.com', '123123', 'qqqq', 1, 'http://localhost:8080/img/users/1111.bmp', NULL, NULL, NULL, NULL);
INSERT INTO `user` VALUES ('nihao', '5555555555@qq.com', '123123', 'test', 1, 'http://localhost:8080/img/users/1111.bmp', NULL, NULL, NULL, NULL);
INSERT INTO `user` VALUES ('bbbb', '6078395283@qq.com', '123123', '111', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user` VALUES ('hhh', '9822358600@qq.com', '123123', 'zec', 1, 'http://localhost:8080/img/users/1111.bmp', NULL, NULL, NULL, NULL);
INSERT INTO `user` VALUES ('AAAAAA', '98756392784@qq.com', '123123', '沈力诚', 1, 'http://localhost:8080/img/users/1111.bmp', NULL, NULL, NULL, NULL);

SET FOREIGN_KEY_CHECKS = 1;
