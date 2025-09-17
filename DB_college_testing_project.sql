-- Создание таблицы "Группы"
CREATE TABLE groups (
    group_id SERIAL PRIMARY KEY, -- Уникальный ID группы
    group_name VARCHAR(50) NOT NULL UNIQUE, -- Название группы (уникальный)
    faculty VARCHAR(100) NOT NULL, -- Факультет
    course_number INTEGER NOT NULL CHECK (course_number BETWEEN 1 AND 6), -- Номер курса
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Дата создания записи
);

-- Создание таблицы "Студенты"
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY, -- Уникальный ID студента
    first_name VARCHAR(50) NOT NULL, -- Имя студента
    last_name VARCHAR(50) NOT NULL,  -- Фамилия студента
    birth_date DATE, -- Дата рождения
    email VARCHAR(100) UNIQUE, -- Эл. почта
    phone VARCHAR(20), --Номер телефона
    group_id INTEGER NOT NULL, -- ID группы
    enrollment_year INTEGER NOT NULL, -- Год зачисления
    is_active BOOLEAN DEFAULT TRUE, -- Флаг активности/статуса студента.
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Дата создания записи
    
    FOREIGN KEY (group_id) REFERENCES groups(group_id) ON DELETE RESTRICT -- Связь таблиц "Группы" и "Студенты" (одни-ко-многим)
);

-- Создание таблицы "Предметы"
CREATE TABLE subjects (
    subject_id SERIAL PRIMARY KEY,  	-- Уникальный ID предмета
    subject_name VARCHAR(100) NOT NULL,         -- Название предмета (обязательное поле)
    subject_code VARCHAR(20) UNIQUE NOT NULL,   -- Код предмета (уникальный)
    hours_per_semester SMALLINT NOT NULL,       -- Часов в семестр (академических)
    is_core BOOLEAN DEFAULT TRUE,               -- Обязательный предмет (да/нет)
    description TEXT,                           -- Описание предмета
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Дата создания записи
);

-- Связь таблицы "Предметы" с таблицей "Группы" (многие-ко-многим)
CREATE TABLE subjects_groups (
    subject_id INT,
    group_id INT,
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id),
    FOREIGN KEY (group_id) REFERENCES groups(group_id)
);

-- Заполнение таблицы "Группы"
INSERT INTO groups (group_name, faculty, course_number) 
VALUES
('ИТ-101', 'Информационные технологии', 1),
('ИТ-201', 'Информационные технологии', 2),
('ЭК-101', 'Экономика', 1),
('МЕД-201', 'Медицина', 2),
('ЮР-301', 'Юриспруденция', 3);

-- Добавление 15 студентов в таблицу "Студенты"
INSERT INTO students (first_name, last_name, birth_date, email, phone, group_id, enrollment_year) 
VALUES
('Ольга', 'Васильева', '2001-02-14', 'vasileva@email.com', '+79991112233', 1, 2023),
('Сергей', 'Попов', '2000-11-08', 'popov@email.com', '+79992223344', 1, 2023),
('Анна', 'Соколова', '2002-04-25', 'sokolova@email.com', '+79993334455', 2, 2022),
('Михаил', 'Новиков', '2001-07-19', 'novikov@email.com', '+79994445566', 2, 2022),
('Наталья', 'Морозова', '2000-09-12', 'morozova@email.com', '+79995556677', 2, 2022),
('Андрей', 'Волков', '2001-12-30', 'volkov@email.com', '+79996667788', 3, 2023),
('Елена', 'Лебедева', '2002-01-17', 'lebedeva@email.com', '+79997778899', 3, 2023),
('Павел', 'Козлов', '2000-06-05', 'kozlov@email.com', '+79998889900', 3, 2023),
('Светлана', 'Орлова', '2001-03-22', 'orlova@email.com', '+79999990011', 4, 2021),
('Артем', 'Андреев', '1999-08-15', 'andreev@email.com', '+79991001122', 4, 2021),
('Юлия', 'Макарова', '2000-10-28', 'makarova@email.com', '+79992112233', 1, 2023),
('Денис', 'Никитин', '2001-05-11', 'nikitin@email.com', '+79993223344', 2, 2022),
('Ирина', 'Захарова', '2002-02-03', 'zaharova@email.com', '+79994334455', 3, 2023),
('Владимир', 'Семенов', '2000-07-24', 'semenov@email.com', '+79995445566', 4, 2021),
('Татьяна', 'Григорьева', '2001-11-09', 'grigoreva@email.com', '+79996556677', 1, 2023),
('Валерий', 'Н.', '2000-01-15', null, '+79991112671', 1, 2023);

-- Заполнение таблицы "Предметы"
INSERT INTO subjects (subject_name, subject_code, hours_per_semester, is_core, description)
VALUES 
('Математический анализ', 'МАТАН-1001', 120, TRUE, 'Дифференциальное и интегральное исчисление'),
('Программирование на Python', 'ПИТ-1002', 90, FALSE, 'Основы программирования на Python'),
('История философии', 'ФИЛ-6001', 60, FALSE, 'История западной философии от античности до современности'),
('Анатомия', 'АНА-3001', 130, TRUE, 'Строения тела, органов и систем');

-- Заполнение таблицы связей между предметами и группами
INSERT INTO subjects_groups (subject_id, group_id) 
VALUES
(1, 1), -- Математический анализ - Информационные технологии 1
(2, 1), -- Программирование на Python - Информационные технологии 1
(1, 2), -- Математический анализ - Информационные технологии 2
(2, 2), -- Программирование на Python - Информационные технологии 2
(3, 3), -- История философии - Экономика
(4, 4), -- Анатомия - Медицина
(3, 5); -- История философии - Юриспруденция

------------------ SELECT-запросы ------------------

-- 1. Возврат всех строк
-- Вывод всех записей из таблицы "Группы"
SELECT * FROM groups

-- 2. Возврат всех нужных строк
-- Вывод грппы с названием ИТ-201
SELECT * FROM groups WHERE group_name = 'ИТ-201'

-- 3. Обработка NULL
-- Вывод студента без почты
-- Допущена синтаксическая ошибка. = заменить на is
SELECT * FROM students WHERE email = NULL

-- 4. Работа с пустым набором
-- Вывод несуществующего названия предмета
SELECT * FROM subjects WHERE subject_name = 'Теория вероятностей'

-- 5. Сортировка (ORDER BY)
-- Вывод списка студентов по фамилии в алфавитном порядке
SELECT * FROM students
ORDER BY last_name 

-- 6. Ограничение вывода (LIMIT)
-- Вывод двух студентов в третьей группе
SELECT * FROM students
WHERE group_id = 3
LIMIT 2

-- 7 Агрегатная функция COUNT()
-- Вывод количества всех студентов в университете
-- Допущена математическая ошибка. SUM() изменить на COUNT()
SELECT SUM(student_id) FROM students

-- 8. Джойн (JOIN)
-- Вывод всех студентов в группе "Экономика"
SELECT s.last_name AS Фамилия, s.first_name AS Имя
FROM students s
INNER JOIN groups g ON s.group_id = g.group_id
WHERE g.faculty = 'Экономика'
ORDER BY s.last_name

-- 9. Группировка (GROUP BY)
-- Вывод количества студентов в каждой группе
SELECT g.faculty AS Группа, COUNT(s.student_id) AS "Количество студентов"
FROM students s
INNER JOIN groups g ON s.group_id = g.group_id
GROUP BY g.faculty
ORDER BY g.faculty

-- 10. Условное выражение (CASE)
-- Вывод кабинета, где проходит предмет
SELECT subject_name,
CASE 
WHEN subject_code LIKE 'МАТАН%' THEN '101'
WHEN subject_code LIKE 'ПИТ%' THEN '103'
WHEN subject_code LIKE 'ФИЛ%' THEN '310'
WHEN subject_code LIKE 'АНА%' THEN '206'
ELSE 'Нет кабинета'
END AS "Номер кабинета"
FROM subjects

------------------ INSERT-запросы ------------------

-- 1. Успешное добавление строки
-- Добавление нового студента в таблицу "Студенты"
INSERT INTO students (first_name, last_name, birth_date, email, phone, group_id, enrollment_year) 
VALUES ('Николай', 'Иванов', '1999-02-14', 'Ivanov4@email.com', '+79991112324', 5, 2023);

-- 2. Добавление данных в таблицу без указания столбцов
-- Добавление новой группы
INSERT INTO groups
VALUES (6, 'ПМ-301', 'Прикладная математика', 3);

-- 3. В запросе указать определенные столбцы
-- Добавление нового предмета без описания
INSERT INTO subjects (subject_name, subject_code, hours_per_semester, is_core)
VALUES ('Алгебра', 'АЛГ-1003', 120, TRUE);

-- 4. Добавить сразу несколько строк
-- Добавление нескольких новых студентов
INSERT INTO students (first_name, last_name, birth_date, email, phone, group_id, enrollment_year) 
VALUES
('Иван', 'Иванов', '2000-03-16', 'IvanovIvan5@email.com', '+79991112786', 4, 2023),
('Иван', 'Сидоров', '2001-03-16', 'SidIvan6@email.com', '+79991114526', 3, 2023);

-- 5. Значения по умолчанию (DEFAULT)
-- Столбец is_core по умолчанию будет TRUE
INSERT INTO subjects (subject_name, subject_code, hours_per_semester, description)
VALUES 
('Гражданское право', 'ГРПР-6001', 120, 'Вопросы обязательств, собственности и регулирования частных отношений');

-- 6. Обработка NULL
-- Добавление группы без названия факультета
INSERT INTO groups (group_name, faculty, course_number) 
VALUES ('ИТ-103', NULL, 1);

-- 7. Уникальность (UNIQUE constraint)
-- Добавление новой группы с существующим наименованием
INSERT INTO groups (group_name, faculty, course_number) 
VALUES ('ИТ-101', 'Прикладная информатика', 1);

-- 8. Внешние ключи (FOREIGN KEY)
-- Добавление студента с несуществующей группой с номером 10
INSERT INTO students (first_name, last_name, birth_date, email, phone, group_id, enrollment_year) 
VALUES
('Анна', 'Васильева', '2000-02-14', 'vasilevaanna@email.com', '+79991112244', 10, 2023);

------------------ UPDATE-запросы ------------------

-- 1. Изменение конкретной строки
-- Обновление имени одного из студентов
UPDATE students
SET first_name = 'Арина'
WHERE student_id = 3

-- 2. Изменение нужного количества строк
-- Перенесение нескольких студентов из одной группы в другую
-- Допущена синтаксическая ошибка - некорректно указано название таблицы
UPDATE student
SET group_id = 5
WHERE birth_date BETWEEN '1999-01-01' and '1999-12-31'

-- 3. Обновление одновременно несколько полей для одной строки
-- Обновление одновременно несколько полей для одного студента
UPDATE students
SET email = 'kozlov_cool_888@email.com', phone = '+79998889901'
WHERE student_id = 8

-- 4. Обработка условий (WHERE)
-- Обновление названия факультета с несуществующим названием группы
UPDATE groups
SET faculty = 'Экономика и бухгалтерский учет'
WHERE group_name = 'ЭК-203'

-- 5. Валидация данных
-- Обновление названия предметана на NULL, когда subject_name NOT NULL
UPDATE subjects
SET subject_name = NULL
WHERE subjects_id = 2

-- 6. Внешние ключи (FOREIGN KEY)
-- Изменение номера группы на несуществующий номер 
UPDATE groups
SET group_id = 14
WHERE group_id = 2

------------------ DELETE-запросы ------------------

-- 1. Удаление конкретной строки
-- Удаление студента
DELETE FROM students 
WHERE student_id = 2;

-- 2. Удаление нужного количества строк
-- Удаление неактивных студентов
DELETE FROM students 
WHERE is_active = FALSE;

-- 3. Обработка условий (WHERE)
-- Удаление студента с несуществующей группой
DELETE FROM students 
WHERE group_id = 20

-- 4. Ограничения внешнего ключа (ON DELETE RESTRICT)
-- Удаление группы, которая есть в таблице "Студенты"
DELETE FROM groups 
WHERE group_id = 3