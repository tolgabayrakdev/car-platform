CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- ============================================
-- KULLANICILAR
-- ============================================

CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    phone VARCHAR(20) UNIQUE,
    password VARCHAR(255) NOT NULL, 
    is_verified BOOLEAN DEFAULT false,
    email_verified BOOLEAN DEFAULT false,
    phone_verified BOOLEAN DEFAULT false,
    email_verify_token VARCHAR(255),
    email_verify_token_created_at TIMESTAMP,
    phone_verify_token VARCHAR(255),
    phone_verify_token_created_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- ============================================
-- MARKALAR VE MODELLER
-- ============================================

-- Markalar (BMW, Mercedes, Audi, vb.)
CREATE TABLE brands (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(100) UNIQUE NOT NULL,
    logo_url VARCHAR(255),
    created_at TIMESTAMP DEFAULT NOW()
);

-- Araç Modelleri (320, C200, A4, vb.)
CREATE TABLE car_models (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    brand_id UUID NOT NULL REFERENCES brands(id) ON DELETE CASCADE,
    name VARCHAR(100) NOT NULL,
    year_start INTEGER,
    year_end INTEGER,
    created_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(brand_id, name)
);

-- ============================================
-- TÜRKİYE ŞEHİRLER VE İLÇELER
-- ============================================

-- Şehirler (81 il)
CREATE TABLE cities (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(100) NOT NULL,
    plate_code INTEGER UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

-- İlçeler
CREATE TABLE districts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    city_id UUID NOT NULL REFERENCES cities(id) ON DELETE CASCADE,
    name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(city_id, name)
);

-- ============================================
-- KULLANICI ARAÇLARI
-- ============================================

-- Kullanıcı Araçları (kullanıcının sahip olduğu araçlar)
CREATE TABLE user_vehicles (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    car_model_id UUID NOT NULL REFERENCES car_models(id) ON DELETE CASCADE,
    city_id UUID NOT NULL REFERENCES cities(id),
    district_id UUID REFERENCES districts(id),
    year INTEGER,
    color VARCHAR(50),
    plate_number VARCHAR(20),
    is_primary BOOLEAN DEFAULT false,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- ============================================
-- TOPLULUKLAR (Model + Şehir/İlçe bazlı)
-- ============================================

-- Topluluklar (Model + Şehir/İlçe kombinasyonu)
-- Kullanıcılar user_vehicles tablosu üzerinden otomatik olarak topluluğa dahil olur
-- Örnek: "Mercedes E200 - Antalya" veya "BMW 320 - Giresun Merkez"
CREATE TABLE communities (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    car_model_id UUID NOT NULL REFERENCES car_models(id) ON DELETE CASCADE,
    city_id UUID NOT NULL REFERENCES cities(id),
    district_id UUID REFERENCES districts(id), -- NULL ise şehir bazlı, dolu ise ilçe bazlı
    name VARCHAR(255) NOT NULL, -- "BMW 320 - Giresun Merkez" veya "Mercedes E200 - Antalya"
    description TEXT,
    member_count INTEGER DEFAULT 0, -- user_vehicles tablosundan hesaplanır
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(car_model_id, city_id, district_id)
);

-- ============================================
-- GÖNDERİLER VE YORUMLAR
-- ============================================

-- Gönderiler (teknik sorunlar, paylaşımlar)
CREATE TABLE posts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    community_id UUID NOT NULL REFERENCES communities(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    post_type VARCHAR(50) DEFAULT 'general', -- 'technical_issue', 'general', 'question'
    is_solved BOOLEAN DEFAULT false,
    view_count INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Yorumlar
CREATE TABLE comments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    post_id UUID NOT NULL REFERENCES posts(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    content TEXT NOT NULL,
    is_solution BOOLEAN DEFAULT false, -- Teknik sorun için çözüm olarak işaretlenebilir
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- ============================================
-- İNDEKSLER (Performans için)
-- ============================================

CREATE INDEX idx_user_vehicles_user_id ON user_vehicles(user_id);
CREATE INDEX idx_user_vehicles_car_model_id ON user_vehicles(car_model_id);
CREATE INDEX idx_user_vehicles_city_id ON user_vehicles(city_id);
CREATE INDEX idx_user_vehicles_car_model_city ON user_vehicles(car_model_id, city_id);
CREATE INDEX idx_communities_car_model_city ON communities(car_model_id, city_id);
CREATE INDEX idx_communities_city_id ON communities(city_id);
CREATE INDEX idx_posts_community_id ON posts(community_id);
CREATE INDEX idx_posts_user_id ON posts(user_id);
CREATE INDEX idx_comments_post_id ON comments(post_id);
CREATE INDEX idx_comments_user_id ON comments(user_id);
