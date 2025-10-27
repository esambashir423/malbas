-- قاعدة بيانات الموقع لجمعية ملبس الأهلية
-- ترميز: utf8mb4

CREATE DATABASE IF NOT EXISTS malbas_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE malbas_db;

-- صفحات ثابتة
CREATE TABLE IF NOT EXISTS pages (
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	slug VARCHAR(190) NOT NULL UNIQUE,
	title VARCHAR(255) NOT NULL,
	content LONGTEXT NULL,
	status ENUM('draft','published','archived') NOT NULL DEFAULT 'draft',
	menu_order INT NOT NULL DEFAULT 0,
	created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- أعضاء الفريق ومجلس الإدارة
CREATE TABLE IF NOT EXISTS team_members (
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(190) NOT NULL,
	role_title VARCHAR(190) NULL,
	bio TEXT NULL,
	photo_url VARCHAR(512) NULL,
	member_type ENUM('board','executive','staff') NOT NULL DEFAULT 'board',
	order_index INT NOT NULL DEFAULT 0,
	is_active TINYINT(1) NOT NULL DEFAULT 1,
	created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	INDEX idx_team_type (member_type),
	INDEX idx_team_active (is_active)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- وثائق الحوكمة والشفافية
CREATE TABLE IF NOT EXISTS documents (
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	category ENUM('policy','financial_report','annual_report','strategic_plan','operational_plan','ethical_charter','registration_certificate') NOT NULL,
	title VARCHAR(255) NOT NULL,
	year SMALLINT NULL,
	file_url VARCHAR(1024) NOT NULL,
	summary TEXT NULL,
	is_published TINYINT(1) NOT NULL DEFAULT 1,
	created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	INDEX idx_docs_category (category),
	INDEX idx_docs_year (year),
	INDEX idx_docs_published (is_published)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- الحسابات البنكية
CREATE TABLE IF NOT EXISTS bank_accounts (
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	bank_name VARCHAR(190) NOT NULL,
	account_name VARCHAR(190) NULL,
	account_number VARCHAR(64) NULL,
	iban VARCHAR(34) NULL,
	swift_code VARCHAR(16) NULL,
	display_order INT NOT NULL DEFAULT 0,
	is_active TINYINT(1) NOT NULL DEFAULT 1,
	created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
	INDEX idx_bank_active (is_active)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- احصائيات المستفيدين
CREATE TABLE IF NOT EXISTS beneficiary_stats (
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	period_type ENUM('year','month') NOT NULL DEFAULT 'year',
	year SMALLINT NOT NULL,
	month TINYINT NULL,
	metric_key VARCHAR(64) NOT NULL,
	metric_label VARCHAR(190) NOT NULL,
	value BIGINT NOT NULL DEFAULT 0,
	created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
	INDEX idx_beneficiary_period (period_type, year, month),
	INDEX idx_beneficiary_metric (metric_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- الأعضاء المؤسسون
CREATE TABLE IF NOT EXISTS founders (
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(190) NOT NULL,
	bio TEXT NULL,
	photo_url VARCHAR(512) NULL,
	order_index INT NOT NULL DEFAULT 0,
	created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- أعضاء الجمعية العمومية
CREATE TABLE IF NOT EXISTS general_assembly_members (
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(190) NOT NULL,
	email VARCHAR(190) NULL,
	phone VARCHAR(32) NULL,
	join_date DATE NULL,
	is_active TINYINT(1) NOT NULL DEFAULT 1,
	created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
	INDEX idx_ga_active (is_active)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- محاضر الجمعية العمومية (عادية / غير عادية)
CREATE TABLE IF NOT EXISTS ga_minutes (
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	meeting_type ENUM('ordinary','extraordinary') NOT NULL,
	meeting_date DATE NOT NULL,
	title VARCHAR(255) NOT NULL,
	file_url VARCHAR(1024) NOT NULL,
	summary TEXT NULL,
	created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
	INDEX idx_ga_minutes_type (meeting_type),
	INDEX idx_ga_minutes_date (meeting_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- البرامج والمبادرات
CREATE TABLE IF NOT EXISTS programs (
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	title VARCHAR(255) NOT NULL,
	description TEXT NULL,
	status ENUM('current','past') NOT NULL DEFAULT 'current',
	start_date DATE NULL,
	end_date DATE NULL,
	cover_image_url VARCHAR(1024) NULL,
	created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	INDEX idx_program_status (status),
	INDEX idx_program_dates (start_date, end_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- طلبات التسجيل في البرامج
CREATE TABLE IF NOT EXISTS program_registrations (
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	program_id BIGINT UNSIGNED NOT NULL,
	full_name VARCHAR(190) NOT NULL,
	email VARCHAR(190) NULL,
	phone VARCHAR(32) NULL,
	notes TEXT NULL,
	status ENUM('new','reviewed','accepted','rejected') NOT NULL DEFAULT 'new',
	created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT fk_program_reg_program FOREIGN KEY (program_id) REFERENCES programs(id) ON DELETE CASCADE,
	INDEX idx_reg_program (program_id),
	INDEX idx_reg_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- طلبات التطوع
CREATE TABLE IF NOT EXISTS volunteer_applications (
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	full_name VARCHAR(190) NOT NULL,
	email VARCHAR(190) NULL,
	phone VARCHAR(32) NULL,
	skills TEXT NULL,
	interests TEXT NULL,
	status ENUM('new','approved','rejected','on_hold') NOT NULL DEFAULT 'new',
	created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
	INDEX idx_volunteer_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- طلب متطوعين من الأقسام
CREATE TABLE IF NOT EXISTS volunteer_requests (
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	title VARCHAR(255) NOT NULL,
	department VARCHAR(190) NULL,
	description TEXT NULL,
	required_skills TEXT NULL,
	num_needed INT NOT NULL DEFAULT 1,
	contact_email VARCHAR(190) NULL,
	status ENUM('open','closed') NOT NULL DEFAULT 'open',
	created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
	INDEX idx_vreq_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- الأخبار والمبادرات (منشورات)
CREATE TABLE IF NOT EXISTS posts (
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	category ENUM('news','initiative') NOT NULL,
	slug VARCHAR(190) NOT NULL UNIQUE,
	title VARCHAR(255) NOT NULL,
	content LONGTEXT NULL,
	cover_image_url VARCHAR(1024) NULL,
	is_published TINYINT(1) NOT NULL DEFAULT 0,
	published_at TIMESTAMP NULL DEFAULT NULL,
	created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	INDEX idx_posts_category (category),
	INDEX idx_posts_published (is_published, published_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- مكتبات الصور والفيديو
CREATE TABLE IF NOT EXISTS media_albums (
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	title VARCHAR(255) NOT NULL,
	description TEXT NULL,
	type ENUM('photo','video') NOT NULL,
	cover_image_url VARCHAR(1024) NULL,
	created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
	INDEX idx_album_type (type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS media_items (
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	album_id BIGINT UNSIGNED NOT NULL,
	type ENUM('image','video') NOT NULL,
	title VARCHAR(255) NULL,
	url VARCHAR(1024) NOT NULL,
	thumbnail_url VARCHAR(1024) NULL,
	sort_order INT NOT NULL DEFAULT 0,
	is_published TINYINT(1) NOT NULL DEFAULT 1,
	created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT fk_media_album FOREIGN KEY (album_id) REFERENCES media_albums(id) ON DELETE CASCADE,
	INDEX idx_media_album (album_id),
	INDEX idx_media_type (type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- البث المباشر
CREATE TABLE IF NOT EXISTS live_streams (
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	title VARCHAR(255) NOT NULL,
	platform ENUM('youtube','facebook','twitter','custom') NOT NULL DEFAULT 'youtube',
	stream_url VARCHAR(1024) NOT NULL,
	starts_at DATETIME NULL,
	ends_at DATETIME NULL,
	is_active TINYINT(1) NOT NULL DEFAULT 0,
	created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
	INDEX idx_live_active (is_active),
	INDEX idx_live_time (starts_at, ends_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- المسابقات
CREATE TABLE IF NOT EXISTS competitions (
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	title VARCHAR(255) NOT NULL,
	description TEXT NULL,
	rules TEXT NULL,
	start_date DATE NULL,
	end_date DATE NULL,
	status ENUM('upcoming','open','closed') NOT NULL DEFAULT 'upcoming',
	created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
	INDEX idx_comp_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- شركاء النجاح
CREATE TABLE IF NOT EXISTS partners (
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
	logo_url VARCHAR(1024) NULL,
	website_url VARCHAR(1024) NULL,
	order_index INT NOT NULL DEFAULT 0,
	is_active TINYINT(1) NOT NULL DEFAULT 1,
	created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
	INDEX idx_partner_active (is_active)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- التزكيات
CREATE TABLE IF NOT EXISTS testimonials (
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(190) NOT NULL,
	role_title VARCHAR(190) NULL,
	content TEXT NOT NULL,
	avatar_url VARCHAR(1024) NULL,
	is_approved TINYINT(1) NOT NULL DEFAULT 0,
	created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
	INDEX idx_testimonial_approved (is_approved)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- متجر التبرع (حملات التبرع والمعاملات)
CREATE TABLE IF NOT EXISTS donation_campaigns (
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	slug VARCHAR(190) NOT NULL UNIQUE,
	title VARCHAR(255) NOT NULL,
	description TEXT NULL,
	goal_amount DECIMAL(12,2) NULL,
	collected_amount DECIMAL(12,2) NOT NULL DEFAULT 0.00,
	cover_image_url VARCHAR(1024) NULL,
	is_active TINYINT(1) NOT NULL DEFAULT 1,
	created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	INDEX idx_campaign_active (is_active)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS donation_transactions (
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	campaign_id BIGINT UNSIGNED NULL,
	donor_name VARCHAR(190) NULL,
	donor_email VARCHAR(190) NULL,
	amount DECIMAL(12,2) NOT NULL,
	payment_reference VARCHAR(190) NULL,
	payment_status ENUM('pending','paid','failed','refunded') NOT NULL DEFAULT 'pending',
	paid_at DATETIME NULL,
	created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT fk_donation_campaign FOREIGN KEY (campaign_id) REFERENCES donation_campaigns(id) ON DELETE SET NULL,
	INDEX idx_donation_campaign (campaign_id),
	INDEX idx_donation_status (payment_status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- رسائل اتصل بنا
CREATE TABLE IF NOT EXISTS contact_messages (
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	full_name VARCHAR(190) NOT NULL,
	email VARCHAR(190) NULL,
	phone VARCHAR(32) NULL,
	subject VARCHAR(255) NULL,
	message TEXT NOT NULL,
	status ENUM('new','read','closed') NOT NULL DEFAULT 'new',
	created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
	INDEX idx_contact_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- فهارس إضافية يمكن إضافتها لاحقاً حسب الحاجة