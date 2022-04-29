-- Query con SELECT
-- 1. Selezionare tutti gli studenti nati nel 1990 (160)
-- 2. Selezionare tutti i corsi che valgono più di 10 crediti (479)
-- 3. Selezionare tutti gli studenti che hanno più di 30 anni
-- 4. Selezionare tutti i corsi del primo semestre del primo anno di un qualsiasi corso di
-- laurea (286)
-- 5. Selezionare tutti gli appelli d'esame che avvengono nel pomeriggio (dopo le 14) del
-- 20/06/2020 (21)
-- 6. Selezionare tutti i corsi di laurea magistrale (38)
-- 7. Da quanti dipartimenti è composta l'università? (12)
-- 8. Quanti sono gli insegnanti che non hanno un numero di telefono? (50)

-- 1
SELECT * FROM `students` WHERE YEAR(`date_of_birth`) = 1990;
-- 2
SELECT * FROM `courses` WHERE `cfu` > 10;
-- 3
SELECT * FROM `students` WHERE TIMESTAMPDIFF(YEAR,`date_of_birth`,CURRENT_DATE()) > 30;
-- 4
SELECT * FROM `courses` WHERE `period` = 'I SEMESTRE' AND `year` = 1;
-- 5
SELECT * FROM `exams` WHERE HOUR(`hour`) >= 14 AND `date` = '2020-06-20';
-- 6
SELECT * FROM `degrees` WHERE `level` = 'magistrale';
-- 7
SELECT COUNT(`id`) FROM `departments`;
-- 8
SELECT COUNT(`id`) FROM `teachers` WHERE `phone` IS NULL;

-- Query con GROUP BY
-- 1. Contare quanti iscritti ci sono stati ogni anno
-- 2. Contare gli insegnanti che hanno l'ufficio nello stesso edificio
-- 3. Calcolare la media dei voti di ogni appello d'esame
-- 4. Contare quanti corsi di laurea ci sono per ogni dipartimento

-- 1
SELECT COUNT(`id`), YEAR(`enrolment_date`) FROM `students` GROUP BY YEAR(`enrolment_date`);
-- 2
SELECT COUNT(`id`), `office_address` FROM `teachers` GROUP BY `office_address` ORDER BY COUNT(`id`) DESC;
-- 3
SELECT AVG(`vote`), `exam_id` FROM `exam_student` GROUP BY `exam_id`;
-- 4
SELECT COUNT(`department_id`), `department_id` FROM `degrees` GROUP BY `department_id`;