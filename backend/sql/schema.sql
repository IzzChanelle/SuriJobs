-- ============================================
-- SuriJobs — Database Schema
-- Run: mysql -u root -p surijobs < sql/schema.sql
-- ============================================

SET FOREIGN_KEY_CHECKS = 0;

-- ---- Users ----
CREATE TABLE IF NOT EXISTS users (
    id            INT AUTO_INCREMENT PRIMARY KEY,
    name          VARCHAR(100) NOT NULL,
    email         VARCHAR(150) NOT NULL UNIQUE,
    password_hash VARCHAR(255),
    photo         VARCHAR(500),
    active_mode   ENUM('individual','business') DEFAULT 'individual',
    has_business  TINYINT(1) DEFAULT 0,
    google_id     VARCHAR(100),
    is_verified   TINYINT(1) DEFAULT 0,
    reset_token   VARCHAR(255),
    reset_expires DATETIME,
    created_at    DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at    DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---- Profiles ----
CREATE TABLE IF NOT EXISTS profiles (
    id               INT AUTO_INCREMENT PRIMARY KEY,
    user_id          INT NOT NULL UNIQUE,
    job_title        VARCHAR(100),
    bio              TEXT,
    phone            VARCHAR(30),
    district         VARCHAR(50),
    branche          VARCHAR(50),
    work_type        VARCHAR(50),
    experience_level VARCHAR(50),
    education        VARCHAR(50),
    website          VARCHAR(255),
    linkedin         VARCHAR(255),
    created_at       DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at       DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---- Skills ----
CREATE TABLE IF NOT EXISTS skills (
    id         INT AUTO_INCREMENT PRIMARY KEY,
    user_id    INT NOT NULL,
    skill      VARCHAR(100) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---- Companies ----
CREATE TABLE IF NOT EXISTS companies (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    user_id     INT NOT NULL UNIQUE,
    name        VARCHAR(150),
    description TEXT,
    branche     VARCHAR(50),
    district    VARCHAR(50),
    size        VARCHAR(20),
    website     VARCHAR(255),
    logo_url    VARCHAR(500),
    created_at  DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at  DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---- Jobs ----
CREATE TABLE IF NOT EXISTS jobs (
    id               INT AUTO_INCREMENT PRIMARY KEY,
    user_id          INT NOT NULL,
    title            VARCHAR(150) NOT NULL,
    description      TEXT,
    branche          VARCHAR(50),
    district         VARCHAR(50),
    hours            VARCHAR(30),
    experience_level VARCHAR(50),
    salary           VARCHAR(50),
    image_url        VARCHAR(500),
    views            INT DEFAULT 0,
    is_active        TINYINT(1) DEFAULT 1,
    created_at       DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at       DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---- Applications ----
CREATE TABLE IF NOT EXISTS applications (
    id         INT AUTO_INCREMENT PRIMARY KEY,
    job_id     INT NOT NULL,
    user_id    INT NOT NULL,
    status     ENUM('pending','accepted','rejected') DEFAULT 'pending',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY unique_application (job_id, user_id),
    FOREIGN KEY (job_id)  REFERENCES jobs(id)  ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---- Market listings ----
CREATE TABLE IF NOT EXISTS market_items (
    id             INT AUTO_INCREMENT PRIMARY KEY,
    user_id        INT NOT NULL,
    name           VARCHAR(150) NOT NULL,
    description    TEXT,
    price          VARCHAR(50),
    category       VARCHAR(50),
    condition_type VARCHAR(50),
    district       VARCHAR(50),
    image_url      VARCHAR(500),
    is_active      TINYINT(1) DEFAULT 1,
    created_at     DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at     DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---- Services ----
CREATE TABLE IF NOT EXISTS services (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    user_id     INT NOT NULL,
    name        VARCHAR(150) NOT NULL,
    description TEXT,
    branche     VARCHAR(50),
    district    VARCHAR(50),
    price_range VARCHAR(30),
    contact     VARCHAR(100),
    image_url   VARCHAR(500),
    is_active   TINYINT(1) DEFAULT 1,
    created_at  DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at  DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---- Saved items ----
CREATE TABLE IF NOT EXISTS saved_items (
    id         INT AUTO_INCREMENT PRIMARY KEY,
    user_id    INT NOT NULL,
    item_type  ENUM('job','market','service') NOT NULL,
    item_id    INT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY unique_saved (user_id, item_type, item_id),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---- Messages ----
CREATE TABLE IF NOT EXISTS messages (
    id           INT AUTO_INCREMENT PRIMARY KEY,
    from_user_id INT NOT NULL,
    to_user_id   INT NOT NULL,
    message      TEXT NOT NULL,
    is_read      TINYINT(1) DEFAULT 0,
    created_at   DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (from_user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (to_user_id)   REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---- Notifications ----
CREATE TABLE IF NOT EXISTS notifications (
    id         INT AUTO_INCREMENT PRIMARY KEY,
    user_id    INT NOT NULL,
    type       VARCHAR(30) DEFAULT 'system',
    title      VARCHAR(200) NOT NULL,
    body       TEXT,
    link       VARCHAR(255),
    is_read    TINYINT(1) DEFAULT 0,
    is_important TINYINT(1) DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

SET FOREIGN_KEY_CHECKS = 1;
