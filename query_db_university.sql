-- seleziona tutti gli studenti nati nel 1990
-- YEAR() funzione che ritorna l'anno
SELECT * 
FROM `students`
WHERE YEAR(`date_of_birth`) = 1990;
-- seleziona tutti i corsi che valgono più di 10 cfu
SELECT *
FROM `courses` 
WHERE `cfu` > 10;
-- seleziona tutti gli studenti che hanno + di 30 anni
-- si può usare sia CURDATE() CHE CURRENT_DATE
SELECT * 
FROM `students`
WHERE YEAR(CURRENT_DATE()) - YEAR(`date_of_birth`) > 30  ;
-- Selezionare tutti i corsi del primo semestre del primo anno di un qualsiasi corso di laurea 
SELECT *
FROM `courses`
WHERE `period` = 'I semestre'
  AND  `year` = 1;
-- Selezionare tutti gli appelli d'esame che avvengono nel pomeriggio (dopo le 14) del 20/06/2020
SELECT *
FROM `exams`
WHERE `date` = '2020-06-20'
	AND `hour` > '14:00:00';

-- Selezionare tutti i corsi di laurea magistrale
-- ho testato pure `level` like 'm%' però è più lento di 1,1 millisecondi
SELECT *
FROM `degrees` 
WHERE `level` = 'magistrale';
-- Da quanti dipartimenti è composta l'università?
-- con count restituisco il numero
-- facendo as number , rinomino la colonna da count(id) a number
SELECT  COUNT(`id`) AS 'number'
FROM `departments`
-- Quanti sono gli insegnanti che non hanno un numero di telefono?
SELECT * 
FROM `teachers` 
WHERE `phone`IS NULL