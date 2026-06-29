-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: asset_management
-- ------------------------------------------------------
-- Server version	8.0.46

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
-- Table structure for table `asset_assignments`
--

DROP TABLE IF EXISTS `asset_assignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `asset_assignments` (
  `assignment_id` int NOT NULL AUTO_INCREMENT,
  `asset_id` int NOT NULL,
  `employee_id` int NOT NULL,
  `assigned_date` datetime NOT NULL,
  `returned_date` datetime DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `notes` text,
  PRIMARY KEY (`assignment_id`),
  KEY `fk_assignments_assets` (`asset_id`),
  KEY `fk_assignments_employees` (`employee_id`),
  CONSTRAINT `fk_assignments_assets` FOREIGN KEY (`asset_id`) REFERENCES `assets` (`asset_id`),
  CONSTRAINT `fk_assignments_employees` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asset_assignments`
--

LOCK TABLES `asset_assignments` WRITE;
/*!40000 ALTER TABLE `asset_assignments` DISABLE KEYS */;
INSERT INTO `asset_assignments` VALUES (1,2,1,'2026-06-24 11:25:03','2026-06-24 11:25:03','Returned','تم تسليم الجهاز لأحمد علي كعهدة شخصية'),(2,2,2,'2026-06-24 11:25:03',NULL,'Assigned','تم نقل العهدة من أحمد علي إلى سارة محمود');
/*!40000 ALTER TABLE `asset_assignments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asset_status`
--

DROP TABLE IF EXISTS `asset_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `asset_status` (
  `status_id` int NOT NULL AUTO_INCREMENT,
  `status_name` varchar(50) NOT NULL,
  PRIMARY KEY (`status_id`),
  UNIQUE KEY `status_name` (`status_name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asset_status`
--

LOCK TABLES `asset_status` WRITE;
/*!40000 ALTER TABLE `asset_status` DISABLE KEYS */;
INSERT INTO `asset_status` VALUES (1,'Available'),(4,'Damaged'),(5,'Disposed'),(2,'In Use'),(3,'Maintenance');
/*!40000 ALTER TABLE `asset_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asset_transactions`
--

DROP TABLE IF EXISTS `asset_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `asset_transactions` (
  `transaction_id` int NOT NULL AUTO_INCREMENT,
  `asset_id` int NOT NULL,
  `transaction_type` varchar(50) NOT NULL,
  `old_location_id` int DEFAULT NULL,
  `new_location_id` int DEFAULT NULL,
  `performed_by_user_id` int NOT NULL,
  `transaction_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `notes` text,
  PRIMARY KEY (`transaction_id`),
  KEY `fk_transactions_assets` (`asset_id`),
  KEY `fk_transactions_old_location` (`old_location_id`),
  KEY `fk_transactions_new_location` (`new_location_id`),
  KEY `fk_transactions_users` (`performed_by_user_id`),
  CONSTRAINT `fk_transactions_assets` FOREIGN KEY (`asset_id`) REFERENCES `assets` (`asset_id`),
  CONSTRAINT `fk_transactions_new_location` FOREIGN KEY (`new_location_id`) REFERENCES `locations` (`location_id`),
  CONSTRAINT `fk_transactions_old_location` FOREIGN KEY (`old_location_id`) REFERENCES `locations` (`location_id`),
  CONSTRAINT `fk_transactions_users` FOREIGN KEY (`performed_by_user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asset_transactions`
--

LOCK TABLES `asset_transactions` WRITE;
/*!40000 ALTER TABLE `asset_transactions` DISABLE KEYS */;
INSERT INTO `asset_transactions` VALUES (1,2,'Transfer',1,1,1,'2026-06-24 11:25:03','نقل اللابتوب من الموظف أحمد علي (1) إلى الموظفة سارة محمود (2)');
/*!40000 ALTER TABLE `asset_transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assets`
--

DROP TABLE IF EXISTS `assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `assets` (
  `asset_id` int NOT NULL AUTO_INCREMENT,
  `asset_code` varchar(255) DEFAULT NULL,
  `asset_name` varchar(255) DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  `serial_number` varchar(255) DEFAULT NULL,
  `purchase_date` date DEFAULT NULL,
  `purchase_cost` double DEFAULT NULL,
  `status_id` int NOT NULL,
  `location_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`asset_id`),
  UNIQUE KEY `asset_code` (`asset_code`),
  UNIQUE KEY `serial_number` (`serial_number`),
  KEY `fk_assets_categories` (`category_id`),
  KEY `fk_assets_status` (`status_id`),
  KEY `fk_assets_locations` (`location_id`),
  CONSTRAINT `fk_assets_categories` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`),
  CONSTRAINT `fk_assets_locations` FOREIGN KEY (`location_id`) REFERENCES `locations` (`location_id`),
  CONSTRAINT `fk_assets_status` FOREIGN KEY (`status_id`) REFERENCES `asset_status` (`status_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assets`
--

LOCK TABLES `assets` WRITE;
/*!40000 ALTER TABLE `assets` DISABLE KEYS */;
INSERT INTO `assets` VALUES (1,'AST-001','Dell Latitude 5540',1,'DL123456789','2026-06-20',950,1,1,'2026-06-24 08:25:03'),(2,'AST-002','MacBook Pro 16',1,'MAC998877','2026-01-15',2100,2,1,'2026-06-24 08:25:03'),(3,'AST-101','MacBook Pro 16',1,'MAC554433','2026-01-15',2000,1,1,'2026-06-24 08:25:03'),(4,'AST-102','Dell Latitude 5540',1,'DEL112233','2024-12-24',1000,1,1,'2026-06-24 08:25:03');
/*!40000 ALTER TABLE `assets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `audit_log`
--

DROP TABLE IF EXISTS `audit_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audit_log` (
  `log_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `action` varchar(100) NOT NULL,
  `table_name` varchar(100) NOT NULL,
  `record_id` int NOT NULL,
  `action_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `old_value` text,
  `new_value` text,
  PRIMARY KEY (`log_id`),
  KEY `fk_audit_users` (`user_id`),
  CONSTRAINT `fk_audit_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audit_log`
--

LOCK TABLES `audit_log` WRITE;
/*!40000 ALTER TABLE `audit_log` DISABLE KEYS */;
INSERT INTO `audit_log` VALUES (1,1,'INSERT','Users',1,'2026-06-24 06:00:00',NULL,'Username: admin, Role: Admin'),(2,1,'INSERT','Assets',1,'2026-06-24 06:01:00',NULL,'Asset: Dell Latitude 5540, Status: Available'),(3,1,'INSERT','Assets',2,'2026-06-24 06:02:00',NULL,'Asset: MacBook Pro 16, Status: Available');
/*!40000 ALTER TABLE `audit_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `category_name` (`category_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Laptop','Portable computers'),(2,'Printer','Office printers'),(3,'Furniture','Office furniture');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `departments` (
  `department_id` int NOT NULL AUTO_INCREMENT,
  `department_name` varchar(150) NOT NULL,
  PRIMARY KEY (`department_id`),
  UNIQUE KEY `department_name` (`department_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
INSERT INTO `departments` VALUES (3,'Finance'),(2,'HR'),(1,'IT');
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `depreciation`
--

DROP TABLE IF EXISTS `depreciation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `depreciation` (
  `depreciation_id` int NOT NULL AUTO_INCREMENT,
  `asset_id` int NOT NULL,
  `current_efficiency` decimal(5,2) DEFAULT '100.00',
  `status_notes` varchar(255) DEFAULT NULL,
  `calculated_date` date NOT NULL,
  PRIMARY KEY (`depreciation_id`),
  KEY `fk_depreciation_assets` (`asset_id`),
  CONSTRAINT `fk_depreciation_assets` FOREIGN KEY (`asset_id`) REFERENCES `assets` (`asset_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `depreciation`
--

LOCK TABLES `depreciation` WRITE;
/*!40000 ALTER TABLE `depreciation` DISABLE KEYS */;
INSERT INTO `depreciation` VALUES (1,1,100.00,'حالة تشغيلية ممتازة - أصل جديد كلياً','2026-06-28'),(2,2,87.50,'حالة ممتازة - استهلاك خفيف','2026-06-28'),(3,3,87.50,'حالة ممتازة - استهلاك خفيف','2026-06-28'),(4,4,55.00,'حالة جيدة - مستهلك بشكل طبيعي','2026-06-28');
/*!40000 ALTER TABLE `depreciation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employees` (
  `employee_id` int NOT NULL AUTO_INCREMENT,
  `employee_name` varchar(150) NOT NULL,
  `department_id` int DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`employee_id`),
  KEY `fk_employees_departments` (`department_id`),
  CONSTRAINT `fk_employees_departments` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (1,'Ahmad Ali',1,'ahmad@company.com','0791234567'),(2,'سارة محمود',1,'sara@company.com','0795555555');
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locations`
--

DROP TABLE IF EXISTS `locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `locations` (
  `location_id` int NOT NULL AUTO_INCREMENT,
  `location_name` varchar(150) NOT NULL,
  PRIMARY KEY (`location_id`),
  UNIQUE KEY `location_name` (`location_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locations`
--

LOCK TABLES `locations` WRITE;
/*!40000 ALTER TABLE `locations` DISABLE KEYS */;
INSERT INTO `locations` VALUES (3,'HR Department'),(2,'IT Department'),(1,'Main Warehouse');
/*!40000 ALTER TABLE `locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `role_id` int NOT NULL AUTO_INCREMENT,
  `role_name` varchar(100) NOT NULL,
  PRIMARY KEY (`role_id`),
  UNIQUE KEY `role_name` (`role_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Admin'),(2,'Asset Manager'),(3,'Employee');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`),
  KEY `fk_users_roles` (`role_id`),
  CONSTRAINT `fk_users_roles` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','$2y$10$abc123xyz',1,'2026-06-24 08:25:03');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'asset_management'
--
/*!50003 DROP PROCEDURE IF EXISTS `Calculate_All_Assets_Depreciation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Calculate_All_Assets_Depreciation`()
BEGIN
    -- تنظيف الجدول قبل إعادة الحساب لضمان دقة البيانات
    TRUNCATE TABLE Depreciation;

    -- إدخال الحسابات التلقائية المبنية على عدد الأشهر
    INSERT INTO Depreciation (asset_id, current_efficiency, status_notes, calculated_date)
    SELECT 
        a.asset_id,
        -- حساب الكفاءة تلقائياً بناءً على الأشهر المرت منذ تاريخ الشراء
        CASE 
            -- إذا كان عمره أقل من 3 أشهر تظل كفاءته كاملة 100%
            WHEN TIMESTAMPDIFF(MONTH, a.purchase_date, CURDATE()) < 3 THEN 100.00
            
            -- إذا كان عمره أكبر من 36 شهراً (3 سنوات) يثبت عند الحد الأدنى 10%
            WHEN TIMESTAMPDIFF(MONTH, a.purchase_date, CURDATE()) >= 36 THEN 10.00
            
            -- في الحالات التي بينهما: يطرح 2.5% عن كل شهر مر من عمره
            ELSE 100.00 - (TIMESTAMPDIFF(MONTH, a.purchase_date, CURDATE()) * 2.5)
        END AS current_efficiency,
        
        -- تقرير الحالة الفنية المبني على عدد الأشهر المرت
        CASE 
            WHEN TIMESTAMPDIFF(MONTH, a.purchase_date, CURDATE()) < 3 THEN 'حالة تشغيلية ممتازة - أصل جديد كلياً'
            WHEN TIMESTAMPDIFF(MONTH, a.purchase_date, CURDATE()) BETWEEN 3 AND 11 THEN 'حالة ممتازة - استهلاك خفيف'
            WHEN TIMESTAMPDIFF(MONTH, a.purchase_date, CURDATE()) BETWEEN 12 AND 23 THEN 'حالة جيدة - مستهلك بشكل طبيعي'
            WHEN TIMESTAMPDIFF(MONTH, a.purchase_date, CURDATE()) BETWEEN 24 AND 35 THEN 'حالة متوسطة - يوصى بعمل صيانة دورية'
            ELSE 'كفاءة منخفضة - يوصى بالاستبدال الفوري'
        END AS status_notes,
        
        CURDATE() -- تاريخ اليوم تلقائياً
    FROM Assets a;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-28 12:51:35
