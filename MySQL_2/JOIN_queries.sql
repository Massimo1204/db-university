-- 1. Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia
-- 2. Selezionare tutti i Corsi di Laurea del Dipartimento di Neuroscienze
-- 3. Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)
-- 4. Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e il
-- relativo dipartimento, in ordine alfabetico per cognome e nome
-- 5. Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti
-- 6. Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica (54)
-- 7. BONUS: Selezionare per ogni studente quanti tentativi d’esame ha sostenuto per
-- superare ciascuno dei suoi esami

-- 1
SELECT `students`.`name` AS `student_name`,
`students`.`surname` AS `student_surname`,
`degrees`.`name` AS `degree_name`
FROM `students`
JOIN `degrees` ON `students`.`degree_id` = `degrees`.`id`
WHERE `degrees`.`name` = 'Corso di Laurea in Economia';

-- 2
SELECT `degrees`.`name` AS `degree_name`,
`degrees`.`level` AS `degree_level`,
`departments`.`name` AS `department_name`
FROM `degrees`
JOIN `departments` ON `degrees`.`department_id` = `departments`.`id`
WHERE `departments`.`name` = 'Dipartimento di Neuroscienze';

-- 3
SELECT `courses`.`name` AS `course_name`,
`teachers`.`name` AS `teacher_name`,
`teachers`.`surname` AS `teacher_surname`
FROM `teachers`
JOIN `course_teacher` ON `teachers`.`id` = `course_teacher`.`teacher_id`
JOIN `courses` ON `course_teacher`.`course_id` = `courses`.`id`
WHERE `teachers`.`id` = 44;

-- 4
SELECT `students`.`surname` AS `student_surname`,
`students`.`name` AS `student_name`,
`departments`.`name` AS `department_name`,
`degrees`.`*`
FROM `students`
JOIN `degrees` ON `students`.`degree_id` = `degrees`.`id`
JOIN `departments` ON `degrees`.`department_id` = `departments`.`id`
ORDER BY `student_surname` ASC;

-- 5
SELECT `degrees`.`name` AS `degree_name`,
`courses`.`name` AS `course_name`,
`teachers`.`surname` AS `teacher_surname`,
`teachers`.`name` AS `teacher_name`
FROM `degrees`
JOIN `courses` ON `degrees`.`id` = `courses`.`degree_id`
JOIN `course_teacher` ON `courses`.`id` = `course_teacher`.`course_id`
JOIN `teachers` ON `course_teacher`.`teacher_id` = `teachers`.`id`
ORDER BY `degree_name`;

-- 6
SELECT `teachers`.`surname` AS `teacher_surname`,
`teachers`.`name` AS `teacher_name`,
`departments`.`name` AS `department_name`
FROM `departments`
JOIN `degrees` ON `departments`.`id` = `degrees`.`department_id`
JOIN `courses` ON `degrees`.`id` = `courses`.`degree_id`
JOIN `course_teacher` ON `courses`.`id` = `course_teacher`.`course_id`
JOIN `teachers` ON `course_teacher`.`teacher_id` = `teachers`.`id`
WHERE `departments`.`name` = 'Dipartimento di Matematica'
GROUP BY `teachers`.`id`;

-- 7
SELECT `students`.`surname` AS `student_surname`,
`students`.`name` AS `student_name`,
`courses`.`name` AS `course_name`,
`exam_student`.`vote`AS `vote`,
COUNT(`exam_student`.`vote`) AS `attempts`
FROM `students`
JOIN `exam_student` ON `students`.`id` = `exam_student`.`student_id`
JOIN `exams` ON `exam_student`.`exam_id` = `exams`.`id`
JOIN `courses` ON `exams`.`course_id` = `courses`.`id`
GROUP BY `student_id`, `courses`.`id`;
