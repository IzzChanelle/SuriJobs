-- ============================================
-- SuriJobs — Seed Data
-- Run AFTER schema.sql:
-- mysql -u root -p surijobs < sql/seed.sql
-- Passwords are all: password123
-- Hash below = bcrypt of "password123", saltRounds=10
-- ============================================

SET FOREIGN_KEY_CHECKS = 0;

-- ---- Users ----
INSERT INTO users (id, name, email, password_hash, active_mode, has_business, is_verified) VALUES
(1, 'Admin SuriJobs',     'admin@surijobs.com',     '$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2uheWG/igi.', 'business',   1, 1),
(2, 'NV Hakrinbank',      'employer@surijobs.com',  '$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2uheWG/igi.', 'business',   1, 1),
(3, 'Priya Ramlakhan',    'jobseeker@surijobs.com', '$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2uheWG/igi.', 'individual', 0, 1),
(4, 'Marco de Vries',     'marco@surijobs.com',     '$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2uheWG/igi.', 'individual', 0, 1),
(5, 'Naomi Bouterse',     'naomi@surijobs.com',     '$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2uheWG/igi.', 'individual', 0, 1);

-- ---- Profiles ----
INSERT INTO profiles (user_id, job_title, bio, phone, district, branche, experience_level, education) VALUES
(3, 'Front-End Developer', 'Passionate developer with 3 years of experience building web apps.', '+597 8521234', 'Paramaribo', 'ICT',       'Junior',  'HBO'),
(4, 'Graphic Designer',    'Creative designer specialising in branding and UI.',                  '+597 7634567', 'Wanica',      'Marketing', 'Medior',  'MBO'),
(5, 'Nail Technician',     'Professional nail tech, 5+ years experience.',                        '+597 8910111', 'Paramaribo', 'Schoonheid','Senior',  'VOS');

-- ---- Companies ----
INSERT INTO companies (user_id, name, description, branche, district, size) VALUES
(1, 'SuriJobs HQ',  'Het platform voor werk en diensten in Suriname.', 'ICT',       'Paramaribo', '6-20'),
(2, 'NV Hakrinbank', 'Grootste lokale bank van Suriname.',              'Financiën', 'Paramaribo', '100+');

-- ---- Skills ----
INSERT INTO skills (user_id, skill) VALUES
(3, 'JavaScript'), (3, 'HTML/CSS'), (3, 'React'),
(4, 'Photoshop'),  (4, 'Figma'),   (4, 'Illustrator'),
(5, 'Nail Art'),   (5, 'Acryl'),   (5, 'Gel');

-- ---- Jobs ----
INSERT INTO jobs (id, user_id, title, description, branche, district, hours, experience_level, salary, views) VALUES
(1, 2, 'Front-End Developer',       'Wij zoeken een enthousiaste front-end developer voor ons digitale team. Je werkt met HTML, CSS en JavaScript.',               'ICT',       'Paramaribo', 'Fulltime',  'Junior',  'SRD 8.000',  42),
(2, 2, 'Marketing Medewerker',      'Verantwoordelijk voor social media campagnes, content creatie en merkstrategie.',                                             'Marketing', 'Paramaribo', 'Parttime',  'Medior',  'SRD 5.500',  28),
(3, 2, 'Financieel Analist',        'Analyse van financiële data en rapportages voor het management. Ervaring met Excel en SQL vereist.',                          'Financiën', 'Paramaribo', 'Fulltime',  'Senior',  'SRD 12.000', 67),
(4, 1, 'Backend Developer (Node)',  'Bouwen en onderhouden van REST APIs in Node.js en Express. Ervaring met MySQL is een pré.',                                   'ICT',       'Paramaribo', 'Fulltime',  'Medior',  'SRD 10.000', 55),
(5, 1, 'Klantenservice Medewerker', 'Vriendelijk en proactief omgaan met klanten via telefoon, email en chat.',                                                    'Verkoop',   'Wanica',     'Parttime',  'Starter', 'SRD 3.500',  19),
(6, 2, 'Grafisch Ontwerper',        'Ontwerpen van marketingmateriaal, logo\'s en digitale content. Kennis van Adobe Suite vereist.',                              'Marketing', 'Paramaribo', 'Freelance', 'Medior',  'SRD 6.000',  33);

-- ---- Applications ----
INSERT INTO applications (job_id, user_id, status) VALUES
(1, 3, 'pending'),
(1, 4, 'accepted'),
(2, 3, 'pending'),
(3, 4, 'rejected'),
(4, 3, 'pending');

-- ---- Market items ----
INSERT INTO market_items (user_id, name, description, price, category, condition_type, district) VALUES
(3, 'iPhone 13 Pro',         'Uitstekende staat, 256GB, zwart. Inclusief originele doos.',    'SRD 3.500', 'Elektronica', 'Zo goed als nieuw', 'Paramaribo'),
(4, 'Gaming Stoel',          'Ergonomische gaming stoel, rood/zwart. Licht gebruikt.',         'SRD 850',  'Meubels',     'Gebruikt',          'Wanica'),
(5, 'Nagelset Compleet',     'Professionele nagelset met lamp, gel en acryl producten.',       'SRD 450',  'Schoonheid',  'Nieuw',             'Paramaribo'),
(3, 'MacBook Air M1',        '8GB RAM, 256GB SSD. Perfecte staat, oplader inbegrepen.',        'SRD 6.200', 'Elektronica', 'Zo goed als nieuw', 'Paramaribo'),
(4, 'Fiets (Shimano)',       '21-versnellingen, goede staat. Ideaal voor woon-werkverkeer.',   'SRD 700',  'Sport',       'Gebruikt',          'Paramaribo'),
(5, 'Schoolboeken VOS',      'Set wiskundeboeken en Engelse grammatica boeken.',                'SRD 120',  'Boeken',      'Gebruikt',          'Commewijne');

-- ---- Services ----
INSERT INTO services (user_id, name, description, branche, district, price_range, contact) VALUES
(5, 'Naomi Nails',           'Professionele nagelstudio aan huis. Gel, acryl en nail art.',    'Schoonheid', 'Paramaribo', 'Gemiddeld', '+597 8910111'),
(4, 'Marco Design Studio',   'Logo ontwerp, visitekaartjes en social media graphics.',          'Marketing',  'Wanica',     'Gemiddeld', '+597 7634567'),
(3, 'Priya Web Solutions',   'Websites en webapps op maat. Snel, modern en mobielvriendelijk.','ICT',        'Paramaribo', 'Premium',   '+597 8521234'),
(4, 'Marco Photography',     'Portret- en productfotografie voor bedrijven en particulieren.',  'Marketing',  'Paramaribo', 'Gemiddeld', '+597 7634567');

-- ---- Saved items ----
INSERT INTO saved_items (user_id, item_type, item_id) VALUES
(3, 'job',     2),
(3, 'market',  2),
(4, 'job',     1),
(4, 'service', 1);

-- ---- Messages ----
INSERT INTO messages (from_user_id, to_user_id, message, is_read) VALUES
(3, 4, 'Hoi Marco, ik zag je grafisch ontwerp dienst. Wat zijn je tarieven?',   1),
(4, 3, 'Hey Priya! Hangt af van het project, stuur me je wensen dan geef ik een offerte.', 0),
(3, 4, 'Super! Ik stuur je volgende week een briefing.',                          0),
(5, 3, 'Priya, kun jij een website voor mijn nagelstudio bouwen?',               1),
(3, 5, 'Ja zeker! Plan een gratis intake dan bespreken we de details.',           0);

-- ---- Notifications ----
INSERT INTO notifications (user_id, type, title, body, is_read) VALUES
(3, 'accept',      'Sollicitatie geaccepteerd!',   'Je sollicitatie voor Front-End Developer bij Hakrinbank is geaccepteerd.', 0),
(3, 'message',     'Nieuw bericht van Naomi',      'Naomi stuurde je een bericht over een website project.',                  0),
(4, 'application', 'Nieuwe sollicitant',           'Er heeft iemand gesolliciteerd op je vacature Grafisch Ontwerper.',       1),
(4, 'reject',      'Sollicitatie afgewezen',       'Je sollicitatie voor Financieel Analist is helaas afgewezen.',            1),
(5, 'system',      'Welkom bij SuriJobs!',         'Je profiel is aangemaakt. Vul je profiel aan voor meer kansen.',          1);

SET FOREIGN_KEY_CHECKS = 1;
