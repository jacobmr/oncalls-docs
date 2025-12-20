-- ================================================
-- ONCALLS APPLICATION DATABASE SCHEMA
-- Complete schema definition for the oncalls system
-- Generated: 2025-09-02
-- Database: oncalls
-- Engine: MySQL 8.0/MariaDB
-- ================================================

-- Set session variables for compatibility
SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT;
SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS;
SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION;
SET NAMES utf8mb4;
SET @OLD_TIME_ZONE=@@TIME_ZONE;
SET TIME_ZONE='+00:00';
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';

-- ================================================
-- DATABASE CREATION
-- ================================================

CREATE DATABASE IF NOT EXISTS `oncalls` 
DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci 
DEFAULT ENCRYPTION='N';

USE `oncalls`;

-- ================================================
-- CORE TABLES
-- ================================================

-- Accounts table - Main account/organization management
CREATE TABLE `accounts` (
  `accountid` int NOT NULL AUTO_INCREMENT,
  `posting_ip` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `groupname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `fname` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `lname` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `street` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `city` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `state` char(2) DEFAULT NULL,
  `zip` char(12) DEFAULT NULL,
  `country` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `phone_ac` char(3) DEFAULT NULL,
  `phone_ex` char(3) DEFAULT NULL,
  `phone_nu` char(4) DEFAULT NULL,
  `fax_ac` char(3) DEFAULT NULL,
  `fax_ex` char(3) DEFAULT NULL,
  `fax_nu` char(4) DEFAULT NULL,
  `ptype` char(3) DEFAULT NULL,
  `users` smallint DEFAULT NULL,
  `isactivated` tinyint(1) NOT NULL DEFAULT '0',
  `cost` decimal(19,4) DEFAULT NULL,
  `admincreated` tinyint(1) NOT NULL DEFAULT '0',
  `sponsoredby` int DEFAULT NULL,
  `pcode` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`accountid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Legacy accounts table (preserved for migration purposes)
CREATE TABLE `accounts_old` (
  `accountid` int NOT NULL,
  `accountname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `street` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `city` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `state` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `zip` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `country` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `phone` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `fax` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `contactfname` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `contactlname` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `contactphone` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `contactfax` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `contactemail` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `debtype` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `userlimit` int DEFAULT NULL,
  `costperuser` decimal(19,4) DEFAULT NULL,
  `startdate` datetime DEFAULT NULL,
  PRIMARY KEY (`accountid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Groups table - Core organizational units
CREATE TABLE `groups` (
  `GroupID` int NOT NULL AUTO_INCREMENT,
  `GroupName` varchar(50) DEFAULT NULL,
  `weekends` varchar(50) DEFAULT NULL,
  `weekdays` varchar(50) DEFAULT NULL,
  `admin_sw_app` int DEFAULT NULL,
  `show_done` int DEFAULT NULL,
  `AdminEmail` char(10) DEFAULT NULL,
  `ReqEmailDate` datetime DEFAULT NULL,
  `GroupOptions` longtext,
  `admin_vol` tinyint(1) NOT NULL DEFAULT '0',
  `ClusterId` int DEFAULT '0',
  `coola` tinyint(1) NOT NULL DEFAULT '0',
  `schedlock` tinyint(1) NOT NULL DEFAULT '0',
  `locktime` datetime DEFAULT NULL,
  `lockedby` int DEFAULT NULL,
  `accountid` int DEFAULT NULL,
  `payment_date` datetime DEFAULT NULL,
  `auto_payment` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`GroupID`),
  KEY `GroupID` (`GroupID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- User authentication and profile management
CREATE TABLE `passwords` (
  `Password` varchar(50) DEFAULT NULL,
  `Login` varchar(50) DEFAULT NULL,
  `Admin` tinyint(1) NOT NULL,
  `Sadmin` tinyint(1) NOT NULL DEFAULT '0',
  `GroupId` int DEFAULT NULL,
  `fname` varchar(50) DEFAULT NULL,
  `lname` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `pager` varchar(50) DEFAULT NULL,
  `docid` int NOT NULL AUTO_INCREMENT,
  `deleted` tinyint NOT NULL,
  `isdoc` tinyint NOT NULL,
  `CallRows` tinyint(1) NOT NULL DEFAULT '0',
  `LastLogout` datetime DEFAULT NULL,
  `Cadmin` tinyint(1) NOT NULL DEFAULT '0',
  `Vpref` smallint NOT NULL,
  `Homephone` varchar(50) DEFAULT NULL,
  `Officephone` varchar(50) DEFAULT NULL,
  `StreetAddress` varchar(100) DEFAULT NULL,
  `City` varchar(50) DEFAULT NULL,
  `State` varchar(50) DEFAULT NULL,
  `Zipcode` varchar(50) DEFAULT NULL,
  `AAdmin` tinyint(1) NOT NULL DEFAULT '0',
  `AdminEmail` tinyint NOT NULL,
  `ViewReqs` tinyint NOT NULL,
  `viewasblock` tinyint NOT NULL,
  `blockstart` tinyint NOT NULL,
  `genKey` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `Auth_Token` varchar(50) DEFAULT NULL,
  `STRIPECUSTOMERID` varchar(100) DEFAULT NULL,
  `isSuperuser` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`docid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ================================================
-- SCHEDULING TABLES
-- ================================================

-- Main schedule table
CREATE TABLE `schedule` (
  `Dates` datetime DEFAULT NULL,
  `DOCID` int DEFAULT NULL,
  `GroupCallID` int DEFAULT NULL,
  `GroupID` int DEFAULT NULL,
  `ScheduleID` int NOT NULL AUTO_INCREMENT,
  `pos` tinyint DEFAULT NULL,
  PRIMARY KEY (`ScheduleID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Group call definitions
CREATE TABLE `groupcalls` (
  `id` int NOT NULL AUTO_INCREMENT,
  `groupid` int DEFAULT NULL,
  `callabr` varchar(50) DEFAULT NULL,
  `callfull` varchar(50) DEFAULT NULL,
  `deleted` tinyint NOT NULL,
  `sortorder` smallint DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Daily call schedules and parameters
CREATE TABLE `groupcalldays` (
  `groupcallid` bigint NOT NULL,
  `dayofweek` char(3) NOT NULL,
  `points` smallint DEFAULT NULL,
  `maxsize` smallint DEFAULT NULL,
  `startTime` tinyint DEFAULT NULL,
  `endTime` tinyint DEFAULT NULL,
  `duration` smallint DEFAULT NULL,
  `stHour` tinyint DEFAULT NULL,
  `stMin` tinyint DEFAULT NULL,
  `stAmPm` char(2) DEFAULT NULL,
  `etHour` tinyint DEFAULT NULL,
  `etMin` tinyint DEFAULT NULL,
  `etAmPm` char(2) DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Special assignments and scheduling overrides
CREATE TABLE `specialassignments` (
  `dates` datetime NOT NULL,
  `points` smallint DEFAULT NULL,
  `startTime` tinyint DEFAULT NULL,
  `endTime` tinyint DEFAULT NULL,
  `groupcallid` bigint NOT NULL,
  `stHour` tinyint DEFAULT NULL,
  `stMin` tinyint DEFAULT NULL,
  `stAmPm` char(2) DEFAULT NULL,
  `etHour` tinyint DEFAULT NULL,
  `etMin` tinyint DEFAULT NULL,
  `etAmPm` char(2) DEFAULT NULL,
  `message` text,
  `istimeDefault` tinyint NOT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ================================================
-- REQUEST AND VOLUNTEER MANAGEMENT
-- ================================================

-- Request types configuration
CREATE TABLE `reqtype` (
  `ReqTypeID` int NOT NULL AUTO_INCREMENT,
  `ReqType` varchar(50) DEFAULT NULL,
  `AbbrevType` varchar(50) DEFAULT NULL,
  `Color` varchar(50) DEFAULT NULL,
  `GroupId` int DEFAULT NULL,
  `isConflict` tinyint NOT NULL,
  `deleted` tinyint NOT NULL,
  PRIMARY KEY (`ReqTypeID`),
  KEY `GroupId` (`GroupId`),
  KEY `ReqTypeID` (`ReqTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Requests for schedule changes/time off
CREATE TABLE `requests` (
  `ReqID` int NOT NULL AUTO_INCREMENT,
  `DocID` int DEFAULT NULL,
  `ReqTypeID` int DEFAULT NULL,
  `ReqDate` datetime DEFAULT NULL,
  `DateOfAction` datetime DEFAULT NULL,
  `IsApproved` tinyint NOT NULL DEFAULT '0',
  `DateOfRequest` datetime DEFAULT NULL,
  `isReceived` tinyint DEFAULT NULL,
  `ApprovalDate` datetime DEFAULT NULL,
  `ReceivedDate` datetime DEFAULT NULL,
  `isRejected` tinyint NOT NULL DEFAULT '0',
  `RejectedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`ReqID`),
  KEY `Requests_FK01` (`ReqTypeID`),
  CONSTRAINT `Requests_FK01` FOREIGN KEY (`ReqTypeID`) REFERENCES `reqtype` (`ReqTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volunteer/coverage requests
CREATE TABLE `volunteers` (
  `VolID` int NOT NULL AUTO_INCREMENT,
  `DocID` int NOT NULL,
  `GroupcallID` int NOT NULL,
  `Voldate` datetime NOT NULL,
  `dateofaction` datetime DEFAULT NULL,
  `isapproved` tinyint DEFAULT NULL,
  `dateofrequest` datetime DEFAULT NULL,
  `isreceived` tinyint NOT NULL,
  `receiveddate` datetime DEFAULT NULL,
  `approvaldate` datetime DEFAULT NULL,
  `isrejected` tinyint NOT NULL,
  `rejecteddate` datetime DEFAULT NULL,
  PRIMARY KEY (`VolID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ================================================
-- COMMUNICATION AND MESSAGING
-- ================================================

-- Daily messages and announcements
CREATE TABLE `daymessages` (
  `dates` datetime NOT NULL,
  `groupid` int NOT NULL,
  `message` text NOT NULL,
  `specialDay` tinyint NOT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- General messages system
CREATE TABLE `messages` (
  `Id` int NOT NULL,
  `lname` varchar(50) DEFAULT NULL,
  `fname` varchar(50) DEFAULT NULL,
  `startdate` datetime DEFAULT NULL,
  `enddate` datetime DEFAULT NULL,
  `message` longtext,
  `Groupid` int DEFAULT NULL,
  `upsize_ts` longblob,
  `docid` int DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `Groupid` (`Groupid`),
  KEY `Id` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Fax communication logs
CREATE TABLE `faxes` (
  `faxid` int NOT NULL,
  `groupid` int NOT NULL,
  `docid` int NOT NULL,
  `faxdatetime` datetime NOT NULL,
  `faxnum` varchar(50) NOT NULL,
  `numcalls` int NOT NULL,
  PRIMARY KEY (`faxid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ================================================
-- CALL SWITCHING AND MANAGEMENT
-- ================================================

-- Call switching requests and approvals
CREATE TABLE `callswitches` (
  `id` int NOT NULL,
  `docid` int DEFAULT NULL,
  `doc_date` datetime DEFAULT NULL,
  `doc_call` varchar(50) DEFAULT NULL,
  `sw_docid` int DEFAULT NULL,
  `sw_date` datetime DEFAULT NULL,
  `sw_call` varchar(50) DEFAULT NULL,
  `date_of_req` datetime DEFAULT NULL,
  `email_ap_date` datetime DEFAULT NULL,
  `email_ap` tinyint NOT NULL,
  `admin_ap_date` datetime DEFAULT NULL,
  `admin_ap` tinyint NOT NULL,
  `sw_done` tinyint NOT NULL,
  `groupid` int DEFAULT NULL,
  `show_done` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `docid` (`docid`),
  KEY `id` (`id`),
  KEY `sw_docid` (`sw_docid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ================================================
-- SERVICES AND SPECIALTIES
-- ================================================

-- Medical services/specialties definitions
CREATE TABLE `services` (
  `ServiceID` int NOT NULL,
  `ServiceName` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ServiceID`),
  KEY `ServiceID` (`ServiceID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Doctor-service associations
CREATE TABLE `docservice` (
  `DocSerid` int NOT NULL AUTO_INCREMENT,
  `Docid` int DEFAULT NULL,
  `ServiceId` int DEFAULT NULL,
  PRIMARY KEY (`DocSerid`),
  KEY `Docid` (`Docid`),
  KEY `DocSerid` (`DocSerid`),
  KEY `ServiceId` (`ServiceId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ================================================
-- PAYMENT AND BILLING
-- ================================================

-- Payment processing records
CREATE TABLE `payments` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `STRIPE_USERID` int NOT NULL DEFAULT '0',
  `STRIPECUSTOMERID` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `AMOUNT` double DEFAULT NULL,
  `STRIPE_PAYMENTID` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `CREATED_AT` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UPDATED_AT` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `GROUPID` int DEFAULT NULL,
  `ITEM_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `SUBSCRIPTION_ID` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `STRIPE_CHARGEID` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `STRIPE_CARD_DETAILS` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `FK_USERID_PASSWORDS` (`STRIPE_USERID`) USING BTREE,
  KEY `FK_PAYMENT_GROUPS` (`GROUPID`) USING BTREE,
  CONSTRAINT `FK_PAYMENT_GROUPS` FOREIGN KEY (`GROUPID`) REFERENCES `groups` (`GroupID`),
  CONSTRAINT `FK_USERID_PASSWORDS` FOREIGN KEY (`STRIPE_USERID`) REFERENCES `passwords` (`docid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- Card details storage
CREATE TABLE `card_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `card_last_four_digits` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `brand` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `exp_date` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` int DEFAULT NULL,
  `card_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- Invoice management
CREATE TABLE `invoices` (
  `invoiceid` bigint NOT NULL,
  `accountid` bigint NOT NULL,
  `invoice_amount` decimal(19,4) NOT NULL,
  `paid` tinyint NOT NULL,
  `Date_issued` datetime DEFAULT NULL,
  `Date_Due` datetime DEFAULT NULL,
  `Date_Received` datetime DEFAULT NULL,
  `method_sent` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`invoiceid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Money/financial transactions
CREATE TABLE `money` (
  `accountid` int NOT NULL,
  `actiondatetime` datetime NOT NULL,
  `amount` decimal(19,4) NOT NULL,
  `description` varchar(50) DEFAULT NULL,
  `id` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ================================================
-- PROMOTIONS AND DISCOUNTS
-- ================================================

-- Promotional codes
CREATE TABLE `promocode` (
  `ID` int NOT NULL,
  `PromoName` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Discount` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `CREATED_AT` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UPDATED_AT` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- Promotions usage tracking
CREATE TABLE `promotions` (
  `PromotionCode` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `Sponsoredby` int DEFAULT NULL,
  `Max_Users` int NOT NULL,
  `Cost` decimal(19,4) NOT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  `PromoId` int DEFAULT NULL,
  `GroupId` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_PROMOID_PROMOTIONS` (`PromoId`),
  KEY `FK_GROUPID_GROUPS` (`GroupId`),
  CONSTRAINT `FK_GROUPID_GROUPS` FOREIGN KEY (`GroupId`) REFERENCES `groups` (`GroupID`),
  CONSTRAINT `FK_PROMOID_PROMOTIONS` FOREIGN KEY (`PromoId`) REFERENCES `promocode` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ================================================
-- CLUSTERING AND ADMINISTRATION
-- ================================================

-- Cluster definitions for multi-tenant architecture
CREATE TABLE `clusters` (
  `ClusterId` int NOT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `Max_Groups` int NOT NULL,
  `Contact` int DEFAULT NULL,
  PRIMARY KEY (`ClusterId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Cluster administrators
CREATE TABLE `clusteradmins` (
  `cadminid` int NOT NULL,
  `Password` varchar(50) DEFAULT NULL,
  `Login` varchar(50) DEFAULT NULL,
  `fname` varchar(50) DEFAULT NULL,
  `lname` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `deleted` tinyint NOT NULL DEFAULT '0',
  `clusterid` int NOT NULL,
  PRIMARY KEY (`cadminid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ================================================
-- SPECIAL DAYS AND HOLIDAYS
-- ================================================

-- Special day definitions
CREATE TABLE `specialdaytypes` (
  `SpecialDayID` int NOT NULL,
  `SpecialdayName` varchar(50) DEFAULT NULL,
  `Dates` datetime DEFAULT NULL,
  PRIMARY KEY (`SpecialDayID`),
  KEY `SpecialDayID` (`SpecialDayID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ================================================
-- RELATIONSHIP/JUNCTION TABLES
-- ================================================

-- Group to account relationships
CREATE TABLE `group2accounts` (
  `groupid` int NOT NULL,
  `accountid` int NOT NULL,
  `id` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Group to special day relationships
CREATE TABLE `group2special` (
  `Groupid` int DEFAULT NULL,
  `SpecialDayId` int DEFAULT NULL,
  `id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Groupid` (`Groupid`),
  KEY `SpecialDayId` (`SpecialDayId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ================================================
-- REPORTING AND VIEWS
-- ================================================

-- Email reporting configuration
CREATE TABLE `emailreports` (
  `emailid` int NOT NULL AUTO_INCREMENT,
  `label` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `login` varchar(255) DEFAULT NULL,
  `email_accountid` int DEFAULT NULL,
  PRIMARY KEY (`emailid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Viewed calls tracking
CREATE TABLE `viewedcalls` (
  `DocId` int NOT NULL,
  `GroupCallId` int NOT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Extended viewed calls tracking
CREATE TABLE `viewedcallse` (
  `docid` int NOT NULL,
  `groupcallid` int NOT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ================================================
-- AUTHENTICATION AND SECURITY
-- ================================================

-- User authentication tokens
CREATE TABLE `user_token` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `token` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `isvalid` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_user_token_passwords` (`user_id`) USING BTREE,
  CONSTRAINT `FK_user_token_passwords` FOREIGN KEY (`user_id`) REFERENCES `passwords` (`docid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- Social login integration
CREATE TABLE `sociallogindetails` (
  `sld_id` int NOT NULL,
  `sld_fb_id` varchar(50) NOT NULL,
  `sld_google_id` varchar(50) NOT NULL,
  `sld_doc_id` int DEFAULT NULL,
  PRIMARY KEY (`sld_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ================================================
-- UTILITY AND HELPER TABLES
-- ================================================

-- Day of week lookup
CREATE TABLE `dowjoin` (
  `dayint` int NOT NULL AUTO_INCREMENT,
  `daychar` char(3) NOT NULL,
  PRIMARY KEY (`dayint`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Residential addresses
CREATE TABLE `res_add` (
  `resid` int NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`resid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Sponsor codes
CREATE TABLE `sponsorcode` (
  `accountid` int NOT NULL,
  `sponsorcode` longtext,
  `id` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ================================================
-- LEGACY AND VIEW TABLES
-- ================================================

-- View-based password management
CREATE TABLE `view_passwords` (
  `Id` int NOT NULL,
  `Password` varchar(50) DEFAULT NULL,
  `Login` varchar(50) DEFAULT NULL,
  `fname` varchar(50) DEFAULT NULL,
  `lname` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `deleted` tinyint NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Id` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- View group lists
CREATE TABLE `view_grouplist` (
  `id` int NOT NULL,
  `View_Id` int DEFAULT NULL,
  `View_GroupId` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`),
  KEY `View_GroupId` (`View_GroupId`),
  KEY `View_Id` (`View_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- View service lists
CREATE TABLE `view_servicelist` (
  `id` int NOT NULL,
  `View_Id` int DEFAULT NULL,
  `GroupId` int DEFAULT NULL,
  `ServiceId` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`),
  KEY `ServiceId` (`ServiceId`),
  KEY `View_GroupId` (`GroupId`),
  KEY `View_Id` (`View_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ================================================
-- TEMPORARY AND STAGING TABLES
-- ================================================

-- Temporary account creation staging
CREATE TABLE `tempaccounts` (
  `id` int NOT NULL,
  `Password` varchar(50) DEFAULT NULL,
  `Login` varchar(50) DEFAULT NULL,
  `fname` varchar(50) DEFAULT NULL,
  `lname` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `GroupName` varchar(50) DEFAULT NULL,
  `isDoc` tinyint NOT NULL,
  `created` tinyint NOT NULL,
  `accountname` varchar(50) DEFAULT NULL,
  `street` varchar(50) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `zip` varchar(25) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `phone` varchar(25) DEFAULT NULL,
  `fax` varchar(25) DEFAULT NULL,
  `contactfname` varchar(25) DEFAULT NULL,
  `contactlname` varchar(25) DEFAULT NULL,
  `contactphone` varchar(25) DEFAULT NULL,
  `contactfax` varchar(25) DEFAULT NULL,
  `contactemail` varchar(25) DEFAULT NULL,
  `userascontact` tinyint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ================================================
-- SYSTEM TABLES
-- ================================================

-- System logs
CREATE TABLE `logs` (
  `logid` int NOT NULL AUTO_INCREMENT,
  `userid` int DEFAULT NULL,
  `type` char(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `row` int DEFAULT NULL,
  `value1` int DEFAULT NULL,
  `value2` int DEFAULT NULL,
  `value3` int DEFAULT NULL,
  `value4` int DEFAULT NULL,
  `logdatetime` datetime DEFAULT NULL,
  PRIMARY KEY (`logid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Help system content
CREATE TABLE `help` (
  `ID` int NOT NULL,
  `PageName` varchar(250) DEFAULT NULL,
  `HelpText` longtext,
  `upsize_ts` longblob,
  PRIMARY KEY (`ID`),
  KEY `ID` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Feedback system
CREATE TABLE `feedback` (
  `id` int NOT NULL,
  `docid` int NOT NULL,
  `subject` varchar(50) DEFAULT NULL,
  `message` longtext,
  `contactinfo` varchar(50) DEFAULT NULL,
  `createdate` datetime DEFAULT NULL,
  `commentid` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ================================================
-- STORED PROCEDURES
-- ================================================

DELIMITER ;;
CREATE PROCEDURE `getschedrows`()
BEGIN
    -- Declare variables for cursor
    DECLARE callbrevholder CHAR(5);
    DECLARE callidholder INT;

    -- Declare a cursor
    DECLARE c_Groupcalls CURSOR FOR
        SELECT callabr, id
        FROM groupcalls
        WHERE groupid = '22' AND deleted = 0;

    -- Declare a continue handler for cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET callbrevholder = NULL;

    -- Create a temporary table
    CREATE TEMPORARY TABLE schedulerows (
        docid INT,
        docname CHAR(10),
        callabr CHAR(5)
    );

    -- Open the cursor
    OPEN c_Groupcalls;

    -- Fetch the first row
    FETCH c_Groupcalls INTO callbrevholder, callidholder;

    -- Loop through the cursor
    WHILE callbrevholder IS NOT NULL DO
        -- Insert into the temporary table
        INSERT INTO schedulerows (docid, docname, callabr)
        VALUES (236, 'Ross', callbrevholder);
        
        -- Fetch the next row
        FETCH c_Groupcalls INTO callbrevholder, callidholder;
    END WHILE;

    -- Close the cursor
    CLOSE c_Groupcalls;

    -- Select from the temporary table
    SELECT * FROM schedulerows;

    -- The temporary table will be dropped automatically when the session ends
END ;;
DELIMITER ;

-- ================================================
-- RESTORE SESSION VARIABLES
-- ================================================

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT;
SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS;
SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION;
SET TIME_ZONE=@OLD_TIME_ZONE;

-- ================================================
-- SCHEMA SUMMARY
-- ================================================
-- 
-- This schema represents a medical on-call scheduling system with:
-- - Multi-tenant architecture (clusters, groups, accounts)
-- - User authentication and authorization
-- - Complex scheduling with call rotations
-- - Request/approval workflows
-- - Payment processing integration
-- - Communication systems (messages, faxes)
-- - Reporting and analytics
-- - Audit logging
-- 
-- Key relationships:
-- - Accounts contain Groups
-- - Groups contain Users (passwords table)
-- - Users have Schedules for GroupCalls
-- - Users can make Requests and volunteer
-- - Payment processing via Stripe
-- 
-- ================================================
