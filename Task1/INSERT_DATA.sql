SET search_path TO public;

-- Abbasi.
INSERT INTO activity_type (activity_name, multiplication_factor) VALUES
 ('Lecture',        3.6),
 ('Lab',            2.4),
 ('Workshop',       2.4),
 ('Seminar',        1.8),
 ('Project',        1.0),
 ('Examination',    1.0),
 ('Administration', 1.0);

INSERT INTO system_rules (rule_name, rule_value) VALUES
 ('max_course_instances_per_period', 4),
 ('periods_per_year',                4),
 ('exam_base_hours',                 32),
 ('exam_hours_per_student',          0.725),
 ('admin_hours_per_hp',              2),
 ('admin_base_hours',                28),
 ('admin_hours_per_student',         0.2);

-- Samat
-- Managers are set after the employees exist
INSERT INTO department (department_name, manager_employee_id) VALUES
 ('ABE',  NULL), -- ABE  = Department för arkitektur och samhällsbyggnad
 ('CBH',  NULL), -- CBH  = Department för kemi, bioteknologi och hälsa
 ('EECS', NULL), -- EECS = Department för elektroteknik och datavetenskap
 ('ITM',  NULL), -- ITM  = Department för industriell teknik och management
 ('SCI',  NULL); -- SCI  = Department för teknikvetenskap

INSERT INTO employee (name, title, email, phone, department_id, supervisor_id) VALUES
 ('Marco Chiesa',              'Associate professor', 'mchiesa@kth.se',  '+46 8 790 44 29', 3, NULL),
 ('Paris Carbone',             'Associate professor', 'parisc@kth.se',   NULL,              3, 1),
 ('Lars Filipsson',            'Associate professor', 'lfn@kth.se',      '+46 8 790 66 55', 5, 1),
 ('Leif Lindbäck',             'Lecturer',            'leifl@kth.se',    '+46 8 790 44 25', 3, 1),
 ('Tommy Ekola',               'Lecturer',            'ekola@kth.se',    '+46 8 790 75 15', 5, 1),
 ('Niharika Gauraha',          'Lecturer',            'niharika@kth.se', '+46 8 790 41 01', 3, 1),
 ('Johan Karlander',           'Associate professor', 'karlan@kth.se',   '+46 8 790 63 40', 3, 1),
 ('Aristides Gionis',          'Professor',           'argioni@kth.se',  '+46 8 790 68 33', 3, 1),
 ('Anne Håkansson',            'Professor',           'annehak@kth.se',  '+46 8 790 40 41', 3, 1),
 ('Fredrik Lundevall',         'Lecturer',            'flu@kth.se',      '+46 8 790 41 47', 3, 1),
 ('Anders Bergström',          'Associate professor', 'abe@kth.se',      '+46 8 790 60 69', 1, 1),
 ('Ann Legeby',                'Professor',           'alegeby@kth.se',  '+46 8 790 60 59', 1, 1),
 ('Amelie Eriksson Karlström', 'Professor',           'ameliek@kth.se',  '+46 8 790 99 78', 2, 1),
 ('Cecilia Williams',          'Professor',           'cwil@kth.se',     '+46 8 790 98 91', 2, 1),
 ('Mats Engwall',              'Professor',           'matseng@kth.se',  '+46 8 790 61 16', 4, 1),
 ('Pär Jönsson',               'Professor',           'parj@kth.se',     '+46 8 790 83 75', 4, 1);

UPDATE department 
SET manager_employee_id = 11 
WHERE department_id = 1;

UPDATE department 
SET manager_employee_id = 13 
WHERE department_id = 2;

UPDATE department 
SET manager_employee_id = 1  
WHERE department_id = 3;

UPDATE department 
SET manager_employee_id = 15 
WHERE department_id = 4;

UPDATE department 
SET manager_employee_id = 5  
WHERE department_id = 5;

INSERT INTO salary_history (employee_id, effective_date, salary) VALUES
 (1,  '2024-01-01',  70000),
 (1,  '2025-01-01',  75000),
 (1,  '2026-01-01',  80000),
 (2,  '2023-01-01',  80000),
 (2,  '2024-05-01',  90000),
 (2,  '2025-01-01',  85000),
 (3,  '2000-06-07',  40000),
 (4,  '2024-02-05', 100000),
 (5,  '2026-01-01',  80000),
 (6,  '2026-01-01',  60000),
 (7,  '2026-01-01',  80000),
 (8,  '2021-06-01',  50000),
 (9,  '2021-03-01',  80000),
 (10, '2023-01-01',  60000),
 (11, '2018-05-02',  70000),
 (12, '2010-05-01',  90000),
 (13, '2000-01-01', 100000),
 (14, '2003-04-03', 110000),
 (15, '2023-08-06',  80000),
 (16, '2020-04-02',  80000);

-- Husein
-- IV1351 has two layout versions (9 hp and 7.5 hp)
INSERT INTO course_layout (course_code, effective_date, course_name, hp, min_students, max_students) VALUES
 ('IV1351', '2026-01-01', 'datalagring',                                     9.0,  67,  92),
 ('IV1351', '2026-04-01', 'datalagring',                                     7.5,  67, 300),
 ('IS1200', '2026-01-01', 'datorteknik',                                     7.5,  50, 300),
 ('IS1300', '2026-01-01', 'inbyggda system',                                 7.5,  50, 300),
 ('DH2642', '2026-01-01', 'interaktionsprogrammering',                       7.5, 100, 400),
 ('SF1686', '2026-01-01', 'flervariabelanalys',                              7.5,  50, 300),
 ('ID1018', '2026-01-01', 'programmering 1',                                 7.5,  80, 250),
 ('IE1204', '2026-01-01', 'digital design',                                  7.5,  60, 200),
 ('SF1610', '2026-01-01', 'diskret matematik',                               7.5, 100, 350),
 ('ID1021', '2026-01-01', 'algoritmer och datastrukturer',                   7.5,  75, 250),
 ('IK1203', '2026-01-01', 'nätverk och kommunikation',                       7.5,  50, 180),
 ('ID1206', '2026-01-01', 'operativsystem',                                  7.5,  40, 150),
 ('IV1350', '2026-01-01', 'objektorienterad design',                         7.5,  40, 120),
 ('II1305', '2026-01-01', 'informations- och kommunikationsteknik projekt',  7.5,  20, 100),
 ('DD1388', '2026-01-01', 'programsystemkonstruktion i C++',                 7.5,  40, 120),
 ('ID2201', '2026-01-01', 'distributerade system',                           7.5,  30, 100);

INSERT INTO course_instance (course_instance_id, course_code, effective_date, period, year, num_students) VALUES
 ('1',  'IV1351', '2026-01-01', 'P1', 2026,  85),
 ('2',  'IV1351', '2026-04-01', 'P2', 2026,  75),
 ('3',  'IS1200', '2026-01-01', 'P1', 2026, 180),
 ('4',  'IS1300', '2026-01-01', 'P2', 2026, 120),
 ('5',  'DH2642', '2026-01-01', 'P2', 2026, 210),
 ('6',  'SF1686', '2026-01-01', 'P1', 2026, 150),
 ('7',  'ID1018', '2026-01-01', 'P1', 2026, 220),
 ('8',  'SF1610', '2026-01-01', 'P3', 2026, 290),
 ('9',  'IE1204', '2026-01-01', 'P1', 2026, 140),
 ('10', 'ID1021', '2026-01-01', 'P4', 2026, 195);

INSERT INTO planned_activity (course_instance_id, activity_name, planned_hours) VALUES
 ('1',  'Lab',      16),
 ('1',  'Lecture',  24),
 ('2',  'Lab',      12),
 ('3',  'Lab',      10),
 ('3',  'Lecture',  28),
 ('4',  'Lab',      20),
 ('4',  'Seminar',   8),
 ('5',  'Project',  40),
 ('5',  'Lecture',  26),
 ('6',  'Workshop', 30),
 ('7',  'Lab',      18),
 ('7',  'Lecture',  32),
 ('8',  'Workshop', 28),
 ('9',  'Lab',      14),
 ('10', 'Lab',      15);

INSERT INTO teaching_allocation (employee_id, course_instance_id, activity_name, allocated_hours) VALUES
 (1, '3',  'Lab',      10),
 (1, '3',  'Lecture',  28),
 (2, '1',  'Lab',      16),
 (2, '1',  'Lecture',  24),
 (3, '2',  'Lab',      12),
 (4, '4',  'Lab',      20),
 (4, '4',  'Seminar',   8),
 (5, '5',  'Project',  40),
 (3, '6',  'Workshop', 30),
 (2, '7',  'Lab',      14),
 (1, '8',  'Workshop', 28),
 (5, '9',  'Lab',      14),
 (3, '10', 'Lab',      15);
