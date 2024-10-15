-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: happypotato
-- ------------------------------------------------------
-- Server version	8.0.37

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `campaigntbl`
--

DROP TABLE IF EXISTS `campaigntbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `campaigntbl` (
  `num` int NOT NULL AUTO_INCREMENT,
  `status` varchar(10) DEFAULT NULL,
  `title` varchar(50) NOT NULL,
  `hash_tag` varchar(30) NOT NULL,
  `thumb` varchar(20) NOT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`num`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campaigntbl`
--

LOCK TABLES `campaigntbl` WRITE;
/*!40000 ALTER TABLE `campaigntbl` DISABLE KEYS */;
INSERT INTO `campaigntbl` VALUES (1,'진행중','뜨거워지는 지구,','지구특공대','thumb_01.jpg','2024-09-20','2024-10-04','<p><br>&nbsp;</p><h4><strong>&lt;h1&gt;생활 속 탄소중립으로 기후위기를 극복해요&lt;/h1&gt;</strong></h4><p>충청도 방언 \'~해유\'와 \'태양의 기름\'이라는 의미가 있는 에너지전환해유는 생활 속 탄소중립 실천을 중심으로 활동하는 단체예요. 에너지로 지구를 지키고 마을을 살리는 사람들의 이야기를 전해드릴게요.</p><p>&nbsp;</p><h2><strong>지구를 지키는 마을</strong></h2><p>에너지전환해유는 충청도에서 환경 측면으로 중요한 대청댐 소재지인 미호동 마을에 자리 잡고 있어요. 이 마을은 발전소에서 만들어진 전기 대신 재생에너지를 사용하는 에너지 자립 마을이에요. 여기서 에너지전환해유는 버려진 공판장을 재탄생시켜 마을 주민들과 함께 에너지 문화를 만들어가고 있어요. 마을 주민들과 지구를 지키는 활동을 함께 하는 셈이죠.</p><p>&nbsp;</p><h2><strong>꽃을 피워 꿀벌에게 맛있는 식사를 대접해요</strong></h2><p>꿀벌이 사라지면 인류도 사라진다는 이야기를 들어보셨나요? 기후위기로 온도에 민감한 꿀벌의 개체수가 급감하고 있어요. 멸종위기에 처한 꿀벌을 살리려고 해피빈 모금으로 ‘윙윙꿀벌식당’ 프로젝트를 진행했어요. 꿀벌이 좋아하는 밀원 식물을 계절별로 다양하게 심어서 오래 살 수 있는 환경을 만드는 거죠. 지난 6월에 심은 들깨에 꽃이 피어 꿀벌이 모여들고 있고, 10월에는 수확해서 생들기름을 짜 판매할 거에요. 들깨 수확이 끝나면 라벤더를 심어서 내년 봄 꿀벌식당을 준비하고요.</p><p>&nbsp;</p><h2><strong>기후 위기는 불평등하게 찾아와요</strong></h2><p>폭염, 폭우와 한파가 찾아올 때 모든 사람이 냉난방으로 건강을 지킬 수 있는건 아니에요. 숨 막히는 더위에 부채 하나로 지내시는 에너지 빈곤 사각지대가 있거든요. 올여름, 해피빈 기부자분들의 참여로 기후 위기 취약계층을 찾아가 선풍기를 선물해 드렸어요. 고장난 선풍기를 수리하지 못해 더위를 온몸으로 견뎌내시던 어르신이 선풍기를 받고 얼마나 좋아하시던지... 모두 함께해준 콩대원 덕분이에요!</p><p>&nbsp;</p><h2><strong>한 번 경험하면 생활 속 실천으로 이어질 거예요.</strong></h2><p>꿀벌 숲길을 걸으며 꿀벌의 중요성을 배우기도 하고, 샴푸바나 천연수세미를 만들어서 써보기도 하고. 나도 기후위기를 늦출 수 있다는 한번의 경험이 중요하다는 담당자님. 앞으로도 생활 속에서 기후 위기를 떠올리고 행동으로 옮기도록 돕는 에너지전환해유의 활동이 기대됩니다.</p><p>&nbsp;</p><p><img src=\"https://happybean-phinf.pstatic.net/20240913_218/1726196076057KL5o5_JPEG/%25A2%25E1%25B7%25E1%25A6%25E1%25B5%25E1_%25A6%25E1%25B5%25E1_%25BC%25E1%25A1%25E1%2528998_n%2529_3.jpg\" alt=\"\"></p><p><img src=\"https://happybean-phinf.pstatic.net/20240913_249/17261960861037ccPH_JPEG/%25A2%25E1%25B7%25E1%25A6%25E1%25B5%25E1_%25A6%25E1%25B5%25E1_%25BC%25E1%25A1%25E1%2528998_n%2529_13.jpg\" alt=\"\"></p><p><img src=\"https://happybean-phinf.pstatic.net/20240913_71/1726195666018sbkY3_JPEG/%25A2%25E1%25B7%25E1%25A6%25E1%25B5%25E1_%25A6%25E1%25B5%25E1_%25BC%25E1%25A1%25E1%2528998_n%2529_4.jpg\" alt=\"\"></p><p><img src=\"https://happybean-phinf.pstatic.net/20240913_122/1726196072124NjexB_JPEG/%25A2%25E1%25B7%25E1%25A6%25E1%25B5%25E1_%25A6%25E1%25B5%25E1_%25BC%25E1%25A1%25E1%2528998_n%2529_2.jpg\" alt=\"\"></p><p><img src=\"https://happybean-phinf.pstatic.net/20240913_218/1726196076057KL5o5_JPEG/%25A2%25E1%25B7%25E1%25A6%25E1%25B5%25E1_%25A6%25E1%25B5%25E1_%25BC%25E1%25A1%25E1%2528998_n%2529_3.jpg\" alt=\"\"></p><p>&nbsp;</p><h2>&nbsp;</h2><h2><strong>생태계를 지키는 데는 모두의 노력이 필요해요</strong></h2><p>&nbsp;</p><p>생태지평연구소는 현장과 이론이 만나는 연구소에요. 환경을 지키는 데 충실한 조사를 바탕으로 한 연구는 행동 못지않게 중요한데요. 꾸준히 한반도 생태계를 지켜온 생태지평연구소의 활동이 인상 깊었습니다.</p><p>&nbsp;</p><p>&nbsp;</p><h2><strong>우리나라 갯벌과 DMZ일원 생태계를 지켜요.</strong></h2><p>&nbsp;</p><p>한반도 생태계를 지키려면 빼놓지 말아야 할 곳이 있어요. 바로 갯벌과 DMZ일원이예요. 갯벌에는 다양한 생물이 서식하고 있어요. DMZ일원은 오랜 시간 사람의 발길이 드물었던 곳이라 자연이 그대로 살아있지요. 생태지평연구소는 갯벌과 DMZ일원을 중심으로 우리나라 곳곳의 생태계를 조사하고, 연구하고, 교육하는 일을 하고 있어요.</p><p>&nbsp;</p><p>&nbsp;</p><h2><strong>긴 시간 함께 쌓은 데이터는 환경 연구의 핵심</strong></h2><p>&nbsp;</p><p>우리나라는 삼면이 바다로 둘러싸여 있고, DMZ일원은 동서에 걸쳐 길게 자리 잡고 있어서 작은 단체가 이 넓은 면적을 연구하기는 불가능해요. 그래서 100여 명의 시민 과학자가 갯벌생태계 조사를 함께하고 있어요. 이분들이 정기적으로 현장에 방문해 갯벌을 찾는 철새 등을 관찰하고, 조사 기록은 \'갯벌키퍼스\'에 공개해요. 덕분에 가치 있는 데이터가 쌓여 갯벌 연구가 빛을 발하고 있어요.</p><p>&nbsp;</p><p>&nbsp;</p><h2><strong>자연을 지키는 일에 누구도 소외될 수 없어요</strong></h2><p>&nbsp;</p><p>연구 결과를 대중에게 쉽게 전하는 일도 무척 중요해요. 멸종위기종이라는 말 자체가 생소한 아이들이 놀이를 하며 공부할 수 있게 환경 놀이북도 만들고, 발달이 느린 아이들이나 시각 장애인을 위해 오디오북도 제작했어요. 교육에 소외될 수 있는 지방의 지역아동센터, 양육시설이나 작은 초등학교에 교육 자료를 무료로 배포하기도 해요.</p><p>&nbsp;</p><p>&nbsp;</p><h2><strong>생태계를 지키는 일에 최선을 다할 거예요</strong></h2><p>&nbsp;</p><p>오랜 시간 생태계를 관찰하다 보니 해가 갈수록 기후위기가 심각해지는 걸 느낀다는 담당자님. 서식 환경이 바뀌니 관찰하는 멸종위기 동물의 개체수가 줄어들거나 찾아오는 동물이 바뀐다고 해요. 작년에는 DMZ일원을 찾는 두루미류와 내성천 모래톱에 사는 흰목물떼새 조사 활동을 해피빈 모금으로 진행했어요. 올겨울엔 산양 관련 활동을 준비하고 있어요. 생태계를 지키는 일이라면 조사도, 연구도, 멸종위기 동물 보호에도 열심인 생태지평연구소를 응원합니다.</p><p>&nbsp;</p><p>&nbsp;</p><h2><a href=\"https://www.getbolkeepers.org/o/map\"><strong>갯벌키퍼스</strong></a></h2><p>&nbsp;</p><p><img src=\"https://happybean-phinf.pstatic.net/20240913_29/17261961501397dacP_JPEG/%25A2%25E1%25B7%25E1%25A6%25E1%25B5%25E1_%25A6%25E1%25B5%25E1_%25BC%25E1%25A1%25E1%2528998_n%2529_10.jpg\" alt=\"\"></p><p><img src=\"https://happybean-phinf.pstatic.net/20240913_290/1726196169198DH3wX_JPEG/%25A2%25E1%25B7%25E1%25A6%25E1%25B5%25E1_%25A6%25E1%25B5%25E1_%25BC%25E1%25A1%25E1%2528998_n%2529_6.jpg\" alt=\"\"></p><p><img src=\"https://happybean-phinf.pstatic.net/20240913_41/1726196099507LxBFr_JPEG/%25A2%25E1%25B7%25E1%25A6%25E1%25B5%25E1_%25A6%25E1%25B5%25E1_%25BC%25E1%25A1%25E1%2528998_n%2529_7.jpg\" alt=\"\"></p><p><img src=\"https://happybean-phinf.pstatic.net/20240913_237/1726196140289668vE_JPEG/%25A2%25E1%25B7%25E1%25A6%25E1%25B5%25E1_%25A6%25E1%25B5%25E1_%25BC%25E1%25A1%25E1%2528998_n%2529_9.jpg\" alt=\"\"></p><p>&nbsp;</p><h2>&nbsp;</h2><h2><strong>우리가 살아가는 지구, 함께 지켜요</strong></h2><p>&nbsp;</p><p>기후위기는 먼 이야기가 아니에요. 지구에서 사라지는 생명을 지키는 일은 우리가 모두 함께해야 해요.<br>여러분의 관심이 행동으로 이어지도록, 지구를 지키는 일에 모금으로 동참해 주세요.</p><p>\"&gt;</p>');
/*!40000 ALTER TABLE `campaigntbl` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-08 10:48:55
