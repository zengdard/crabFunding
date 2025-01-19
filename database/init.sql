CREATE DATABASE IF NOT EXISTS CroW;

-- Grant privileges
GRANT ALL PRIVILEGES ON CroW.* TO 'root'@'%';
GRANT ALL PRIVILEGES ON CroW.* TO 'root'@'localhost';
FLUSH PRIVILEGES;

USE CroW;

CREATE TABLE IF NOT EXISTS users (
    id VARCHAR(36) PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS favorite_stocks (
    id VARCHAR(36) PRIMARY KEY,
    user_id VARCHAR(36),
    symbol VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS stock_cache (
    symbol VARCHAR(20) PRIMARY KEY,
    price DECIMAL(10, 2),
    last_updated TIMESTAMP,
    INDEX idx_last_updated (last_updated)
);

-- Nouvelle table pour l'historique des recherches
CREATE TABLE IF NOT EXISTS search_history (
    id VARCHAR(36) PRIMARY KEY,
    user_id VARCHAR(36),
    symbol VARCHAR(20) NOT NULL,
    search_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    INDEX idx_user_searches (user_id, search_date)
);