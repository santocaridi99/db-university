-- GROUP BY


-- Contare quanti iscritti ci sono stati ogni anno
-- -----------------------------------------------
-- seleziono tutte le somme delle righe e degli anni (funzione year )
-- da studenti e li raggruppo per anno
SELECT COUNT(*) , YEAR(`enrolment_date`) 
FROM `students` 
GROUP BY YEAR(`enrolment_date`)

-- Contare gli insegnanti che hanno l'ufficio nello stesso edificio
-- -------------------------------------------------
-- stesso metodo utilizzato prima
-- condizione per quelli che condividono + di un edificio
SELECT COUNT(*) , `office_address` 
FROM `teachers`
GROUP BY `office_address`
Having COUNT(id) > 1


-- Calcolare la media dei voti di ogni appello d'esame
-- -------------------------------------------------
-- selezione come colonne gli id degli esami e la media dei voti presenti in exam_student
-- e li raggruppo per id esame
SELECT `exam_id` ,AVG(`vote`)
FROM `exam_student`
GROUP BY `exam_id`


--  Contare quanti corsi di laurea ci sono per ogni dipartimento
-- --------------------------------------------------------
-- stessa soluzione dei primi esercizi
SELECT COUNT(*) , `department_id`
FROM `degrees`
GROUP BY `department_id`

-- JOIN


-- Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia
-- ---------------------------------------------------------
-- seleziono le righe che voglio vedere , in questo caso ho messo id dello studente nome , cognome e corso di laurea
-- prendo questi dati da studenti e da degrees facendo la operazione inner Join .
-- messo condizione per visualizzare solo gli studenti con corso di laurea desiderato
SELECT  `students`.`id`,`students`.`name`,`students`.`surname` ,`degrees`.`name`
FROM `students` 
JOIN `degrees`
  ON `degrees`.`id`= `students`.`degree_id`
WHERE `degrees`.`name` = 'Corso di Laurea in Economia';


-- Selezionare tutti i Corsi di Laurea del Dipartimento di Neuroscienze
-- -------------------------------------------------------------
-- selezionato da degrees solo i nomi dei corsi  e del dipartimento 
-- preso nome dal dipartimento facendo la inner join 
-- messo condizione per visualizzare solo gli studenti con corso di laurea desiderato
SELECT `degrees`.`name`,`departments`.`name` 
FROM `degrees` 
JOIN `departments`
  ON `departments`.`id`= `degrees`.`department_id`
WHERE `departments`.`name` = 'Dipartimento di Neuroscienze';


-- Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)
-- ---------------------------------------------------------
--  join prima sulla tabella ponte
-- dopo faccio un altro join su courses
-- e mettendo condizione che teacher id = 44 avrò i corsi in cui insegna quell'insegnante
SELECT `teachers`.`id`, `teachers`.`name`,`teachers`.`surname`,`courses`.`name`
FROM `teachers`
JOIN `course_teacher`
   ON `course_teacher`.`teacher_id`= `teachers`.`id`
JOIN `courses`
ON  `courses`.`id`= `course_teacher`.`course_id`      
WHERE `teachers`.`id`= 44;


-- Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e il
-- relativo dipartimento, in ordine alfabetico per cognome e nome
-- ----------------------------------------------------------------------
-- stesso procedimento come sopra ,solo che faccio un order alla fine per cognome e nome
SELECT `students`.`name`,`students`.`surname`,`degrees`.`name`,`departments`.`name`
FROM `students`
JOIN `degrees`
	ON `degrees`.`id` = `students`.`degree_id`
JOIN `departments`
	ON `departments`.`id` = `degrees`.`department_id`
ORDER BY `students`.`surname`, `students`.`name`;


-- Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti
-- ---------------------------------------------------------------------
SELECT `degrees`.`name` , `courses`.`name` ,`teachers`.`name`, `teachers`.`surname` 
FROM `degrees`
JOIN `courses`
	ON `courses`.`degree_id` = `degrees`.`id`
JOIN `course_teacher`
	ON `course_teacher`.`course_id` = `courses`.`id`
JOIN `teachers`
	ON `teachers`.`id` = `course_teacher`.`teacher_id`


-- Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica (54)
-- ------------------------------------------------------------------
-- condizione che il dipartimento sia quello di matematica
SELECT `departments`.`name` ,`teachers`.`name` , `teachers`.`surname`
FROM `departments`
JOIN `degrees`
	ON `degrees`.`department_id` = `departments`.`id`
JOIN `courses`
	ON `courses`.`degree_id` = `degrees`.`id`
JOIN `course_teacher`
	ON `course_teacher`.`course_id` = `courses`.`id`
JOIN `teachers`
	ON `teachers`.`id` = `course_teacher`.`teacher_id`
WHERE `departments`.`name`= 'Dipartimento di Matematica';

-- BONUS: Selezionare per ogni studente quanti tentativi d’esame ha sostenuto per
-- superare ciascuno dei suoi esame
-- ----------------------------------------------------
-- per i tentativi conto le righe e rinomino la tabella tentativi
SELECT `students`.`id`, `students`.`name`, `students`.`surname`, `exams`.`course_id`, `courses`.`name`,COUNT(*) AS `attempts`, MAX(`exam_student`.`vote`)
FROM `students`
JOIN `exam_student`
	ON `students`.`id` = `exam_student`.`student_id`
JOIN `exams`
	ON `exam_student`.`exam_id` = `exams`.`id`
JOIN `courses`
	ON `exams`.`course_id` = `courses`.`id`
GROUP BY `students`.`id`, `exams`.`course_id`
  HAVING MAX(`exam_student`).`vote`>=18