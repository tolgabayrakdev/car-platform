-- ============================================
-- TÜRKİYE'NİN 81 İLİ VE PLAKA KODLARI
-- ============================================

INSERT INTO cities (name, plate_code) VALUES
('Adana', 1), ('Adıyaman', 2), ('Afyonkarahisar', 3), ('Ağrı', 4), ('Amasya', 5),
('Ankara', 6), ('Antalya', 7), ('Artvin', 8), ('Aydın', 9), ('Balıkesir', 10),
('Bilecik', 11), ('Bingöl', 12), ('Bitlis', 13), ('Bolu', 14), ('Burdur', 15),
('Bursa', 16), ('Çanakkale', 17), ('Çankırı', 18), ('Çorum', 19), ('Denizli', 20),
('Diyarbakır', 21), ('Edirne', 22), ('Elazığ', 23), ('Erzincan', 24), ('Erzurum', 25),
('Eskişehir', 26), ('Gaziantep', 27), ('Giresun', 28), ('Gümüşhane', 29), ('Hakkari', 30),
('Hatay', 31), ('Isparta', 32), ('Mersin', 33), ('İstanbul', 34), ('İzmir', 35),
('Kars', 36), ('Kastamonu', 37), ('Kayseri', 38), ('Kırklareli', 39), ('Kırşehir', 40),
('Kocaeli', 41), ('Konya', 42), ('Kütahya', 43), ('Malatya', 44), ('Manisa', 45),
('Kahramanmaraş', 46), ('Mardin', 47), ('Muğla', 48), ('Muş', 49), ('Nevşehir', 50),
('Niğde', 51), ('Ordu', 52), ('Rize', 53), ('Sakarya', 54), ('Samsun', 55),
('Siirt', 56), ('Sinop', 57), ('Sivas', 58), ('Tekirdağ', 59), ('Tokat', 60),
('Trabzon', 61), ('Tunceli', 62), ('Şanlıurfa', 63), ('Uşak', 64), ('Van', 65),
('Yozgat', 66), ('Zonguldak', 67), ('Aksaray', 68), ('Bayburt', 69), ('Karaman', 70),
('Kırıkkale', 71), ('Batman', 72), ('Şırnak', 73), ('Bartın', 74), ('Ardahan', 75),
('Iğdır', 76), ('Yalova', 77), ('Karabük', 78), ('Kilis', 79), ('Osmaniye', 80),
('Düzce', 81)
ON CONFLICT (plate_code) DO NOTHING;

-- ============================================
-- ÖRNEK İLÇELER
-- ============================================

-- Her şehir için "Merkez" ilçesi ekle
INSERT INTO districts (city_id, name) 
SELECT id, 'Merkez' FROM cities
ON CONFLICT (city_id, name) DO NOTHING;

-- İstanbul ilçeleri
INSERT INTO districts (city_id, name) 
SELECT id, unnest(ARRAY[
    'Adalar', 'Arnavutköy', 'Ataşehir', 'Avcılar', 'Bağcılar', 'Bahçelievler', 
    'Bakırköy', 'Başakşehir', 'Bayrampaşa', 'Beşiktaş', 'Beykoz', 'Beylikdüzü', 
    'Beyoğlu', 'Büyükçekmece', 'Çatalca', 'Çekmeköy', 'Esenler', 'Esenyurt', 
    'Eyüpsultan', 'Fatih', 'Gaziosmanpaşa', 'Güngören', 'Kadıköy', 'Kağıthane', 
    'Kartal', 'Küçükçekmece', 'Maltepe', 'Pendik', 'Sancaktepe', 'Sarıyer', 
    'Silivri', 'Sultanbeyli', 'Sultangazi', 'Şile', 'Şişli', 'Tuzla', 'Ümraniye', 
    'Üsküdar', 'Zeytinburnu'
])
FROM cities WHERE plate_code = 34
ON CONFLICT (city_id, name) DO NOTHING;

-- Ankara ilçeleri
INSERT INTO districts (city_id, name) 
SELECT id, unnest(ARRAY[
    'Altındağ', 'Ayaş', 'Bala', 'Beypazarı', 'Çamlıdere', 'Çankaya', 'Çubuk', 
    'Elmadağ', 'Güdül', 'Haymana', 'Kalecik', 'Kızılcahamam', 'Nallıhan', 
    'Polatlı', 'Şereflikoçhisar', 'Yenimahalle', 'Gölbaşı', 'Keçiören', 'Mamak', 
    'Sincan', 'Etimesgut', 'Pursaklar', 'Akyurt', 'Akköy', 'Aksu', 'Akyurt', 
    'Ayaş', 'Beypazarı', 'Çamlıdere', 'Çankaya', 'Çubuk', 'Elmadağ', 'Güdül', 
    'Haymana', 'Kalecik', 'Kızılcahamam', 'Nallıhan', 'Polatlı', 'Şereflikoçhisar'
])
FROM cities WHERE plate_code = 6
ON CONFLICT (city_id, name) DO NOTHING;

-- İzmir ilçeleri
INSERT INTO districts (city_id, name) 
SELECT id, unnest(ARRAY[
    'Aliağa', 'Bayındır', 'Bergama', 'Bornova', 'Çeşme', 'Dikili', 'Foça', 
    'Karaburun', 'Karşıyaka', 'Kemalpaşa', 'Kınık', 'Kiraz', 'Menemen', 
    'Ödemiş', 'Seferihisar', 'Selçuk', 'Tire', 'Torbalı', 'Urla', 'Buca', 
    'Çiğli', 'Gaziemir', 'Güzelbahçe', 'Konak', 'Menderes', 'Narlıdere'
])
FROM cities WHERE plate_code = 35
ON CONFLICT (city_id, name) DO NOTHING;

-- Bursa ilçeleri
INSERT INTO districts (city_id, name) 
SELECT id, unnest(ARRAY[
    'Büyükorhan', 'Gemlik', 'Gürsu', 'Harmancık', 'İnegöl', 'İznik', 'Karacabey', 
    'Keles', 'Kestel', 'Mudanya', 'Mustafakemalpaşa', 'Nilüfer', 'Orhaneli', 
    'Orhangazi', 'Osmangazi', 'Yenişehir', 'Yıldırım'
])
FROM cities WHERE plate_code = 16
ON CONFLICT (city_id, name) DO NOTHING;

-- Antalya ilçeleri
INSERT INTO districts (city_id, name) 
SELECT id, unnest(ARRAY[
    'Akseki', 'Aksu', 'Alanya', 'Demre', 'Döşemealtı', 'Elmalı', 'Finike', 
    'Gazipaşa', 'Gündoğmuş', 'İbradı', 'Kaş', 'Kemer', 'Kepez', 'Konyaaltı', 
    'Korkuteli', 'Kumluca', 'Manavgat', 'Muratpaşa', 'Serik'
])
FROM cities WHERE plate_code = 7
ON CONFLICT (city_id, name) DO NOTHING;

-- Giresun ilçeleri (örnek için)
INSERT INTO districts (city_id, name) 
SELECT id, unnest(ARRAY[
    'Alucra', 'Bulancak', 'Çanakçı', 'Dereli', 'Doğankent', 'Espiye', 'Eynesil', 
    'Görele', 'Güce', 'Keşap', 'Piraziz', 'Şebinkarahisar', 'Tirebolu', 'Yağlıdere'
])
FROM cities WHERE plate_code = 28
ON CONFLICT (city_id, name) DO NOTHING;

