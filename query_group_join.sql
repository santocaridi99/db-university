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
SELECT COUNT(*) , `office_address` 
FROM `teachers`
GROUP BY `office_address`


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