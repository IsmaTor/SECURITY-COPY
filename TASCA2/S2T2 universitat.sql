/*Base de dades Universidad

Si us plau, descàrrega la base de dades del fitxer schema_universidad.sql, visualitza el diagrama E-R en un editor i efectua les següents consultes:
*/
-- 1.Retorna un llistat amb el primer cognom, segon cognom i el nom de tots els/les alumnes. El llistat haurà d'estar ordenat alfabèticament de menor a major pel primer cognom, segon cognom i nom.
SELECT apellido1, apellido2, nombre, tipo FROM persona WHERE tipo = 'alumno' ORDER BY apellido1 DESC, apellido2 DESC, nombre DESC ;

-- 2.Esbrina el nom i els dos cognoms dels alumnes que no han donat d'alta el seu número de telèfon en la base de dades.
SELECT nombre, apellido1, apellido2, tipo, telefono FROM persona WHERE tipo = 'alumno' AND telefono IS NULL;

-- 3.Retorna el llistat dels alumnes que van néixer en 1999.
SELECT nombre, apellido1, apellido2, fecha_nacimiento FROM persona WHERE tipo = 'alumno' AND fecha_nacimiento BETWEEN '1999-01-01' AND '1999-12-31';

-- 4.Retorna el llistat de professors/es que no han donat d'alta el seu número de telèfon en la base de dades i a més el seu NIF acaba en K.
SELECT nombre, apellido1, apellido2, tipo, telefono, nif FROM persona WHERE (tipo = 'profesor') AND (nif LIKE '%K');

-- 5.Retorna el llistat de les assignatures que s'imparteixen en el primer quadrimestre, en el tercer curs del grau que té l'identificador 7.
SELECT cuatrimestre, curso, id_grado, nombre FROM asignatura WHERE (cuatrimestre = 1) AND (curso = 3) AND (id_grado = 7);

-- 6.Retorna un llistat dels professors/es juntament amb el nom del departament al qual estan vinculats. El llistat ha de retornar quatre columnes, primer cognom, segon cognom, nom i nom del departament. El resultat estarà ordenat alfabèticament de menor a major pels cognoms i el nom.
SELECT persona.apellido1, persona.apellido2, persona.nombre, departamento.nombre FROM persona INNER JOIN profesor ON profesor.id_profesor = persona.id INNER JOIN departamento ON profesor.id_departamento = departamento.id ORDER BY persona.apellido1 DESC, persona.nombre DESC;

-- 7.Retorna un llistat amb el nom de les assignatures, any d'inici i any de fi del curs escolar de l'alumne/a amb NIF 26902806M.
SELECT asignatura.nombre, curso_escolar.anyo_inicio, curso_escolar.anyo_fin, persona.nombre, persona.nif FROM persona, alumno_se_matricula_asignatura INNER JOIN asignatura ON alumno_se_matricula_asignatura.id_asignatura = asignatura.id INNER JOIN curso_escolar ON alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.id WHERE persona.nif = '26902806M';

-- 8.Retorna un llistat amb el nom de tots els departaments que tenen professors/es que imparteixen alguna assignatura en el Grau en Enginyeria Informàtica (Pla 2015).

-- 9.Retorna un llistat amb tots els alumnes que s'han matriculat en alguna assignatura durant el curs escolar 2018/2019.
SELECT DISTINCT persona.nombre, persona.apellido1, persona.apellido2, id_curso_escolar FROM persona INNER JOIN alumno_se_matricula_asignatura on persona.id = alumno_se_matricula_asignatura.id_alumno INNER JOIN curso_escolar on alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.id WHERE curso_escolar.id = 5;

-- Resol les 6 següents consultes utilitzant les clàusules LEFT JOIN i RIGHT JOIN.

-- 1.Retorna un llistat amb els noms de tots els professors/es i els departaments que tenen vinculats. El llistat també ha de mostrar aquells professors/es que no tenen cap departament associat. El llistat ha de retornar quatre columnes, nom del departament, primer cognom, segon cognom i nom del professor/a. El resultat estarà ordenat alfabèticament de menor a major pel nom del departament, cognoms i el nom.
SELECT departamento.nombre, persona.apellido1, persona.apellido2, persona.nombre FROM persona LEFT JOIN profesor ON profesor.id_profesor = persona.id LEFT JOIN departamento ON profesor.id_departamento = departamento.id ORDER BY departamento.nombre DESC, persona.apellido1 DESC, persona.nombre DESC;

-- 2.Retorna un llistat amb els professors/es que no estan associats a un departament.
SELECT persona.apellido1, persona.apellido2, persona.nombre FROM persona LEFT JOIN profesor ON profesor.id_profesor = persona.id LEFT JOIN departamento ON profesor.id_departamento = departamento.id WHERE departamento.nombre IS NULL;

-- 3.Retorna un llistat amb els departaments que no tenen professors/es associats.
SELECT departamento.nombre FROM departamento LEFT JOIN profesor ON departamento.id = profesor.id_departamento WHERE profesor.id_departamento IS NULL;  

-- 4.Retorna un llistat amb els professors/es que no imparteixen cap assignatura.
SELECT DISTINCT persona.nombre, asignatura.id, asignatura.nombre FROM persona, profesor LEFT JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor WHERE  asignatura.id_profesor IS NULL;

-- 5.Retorna un llistat amb les assignatures que no tenen un professor/a assignat.
SELECT asignatura.nombre, profesor.id_profesor FROM asignatura LEFT JOIN profesor ON asignatura.id_profesor = profesor.id_profesor WHERE profesor.id_profesor IS NULL;

-- 6.Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar.

-- Consultes resum:

-- 1.Retorna el nombre total d'alumnes que hi ha.
SELECT count(persona.nombre) FROM persona WHERE tipo = 'alumno';

-- 2.Calcula quants alumnes van néixer en 1999.
SELECT count(persona.nombre) FROM persona WHERE tipo = 'alumno' AND fecha_nacimiento BETWEEN '1999-01-01' AND '1999-12-31';

-- 3.Calcula quants professors/es hi ha en cada departament. El resultat només ha de mostrar dues columnes, una amb el nom del departament i una altra amb el nombre de professors/es que hi ha en aquest departament. El resultat només ha d'incloure els departaments que tenen professors/es associats i haurà d'estar ordenat de major a menor pel nombre de professors/es.
SELECT count(profesor.id_profesor), departamento.nombre FROM departamento INNER JOIN profesor ON departamento.id = profesor.id_departamento GROUP BY profesor.id_departamento ORDER BY count(profesor.id_profesor) DESC, departamento.nombre; 

-- 4.Retorna un llistat amb tots els departaments i el nombre de professors/es que hi ha en cadascun d'ells. Tingui en compte que poden existir departaments que no tenen professors/es associats. Aquests departaments també han d'aparèixer en el llistat.

-- 5.Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun. Tingues en compte que poden existir graus que no tenen assignatures associades. Aquests graus també han d'aparèixer en el llistat. El resultat haurà d'estar ordenat de major a menor pel nombre d'assignatures.
SELECT count(asignatura.id_grado), grado.nombre FROM asignatura INNER JOIN grado ON asignatura.id_grado = grado.id GROUP BY grado.id; -- amb COUNT() utilitzem GROUP BY per agrupa els resultats, amb MAX(), MIN(), SUM(), AVG() també

-- 6.Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun, dels graus que tinguin més de 40 assignatures associades.
SELECT count(asignatura.id_grado), grado.nombre FROM asignatura INNER JOIN grado ON asignatura.id_grado = grado.id GROUP BY grado.id HAVING count(grado.id) > 40; -- si a la consulta utilitzem GROUP BY possarem HAVING

-- 7.Retorna un llistat que mostri el nom dels graus i la suma del nombre total de crèdits que hi ha per a cada tipus d'assignatura. El resultat ha de tenir tres columnes: nom del grau, tipus d'assignatura i la suma dels crèdits de totes les assignatures que hi ha d'aquest tipus.
SELECT DISTINCT sum(asignatura.creditos), grado.nombre, asignatura.tipo FROM asignatura INNER JOIN grado ON asignatura.id_grado = grado.id GROUP BY grado.nombre;

-- 8.Retorna un llistat que mostri quants alumnes s'han matriculat d'alguna assignatura en cadascun dels cursos escolars. El resultat haurà de mostrar dues columnes, una columna amb l'any d'inici del curs escolar i una altra amb el nombre d'alumnes matriculats.

-- 9.Retorna un llistat amb el nombre d'assignatures que imparteix cada professor/a. El llistat ha de tenir en compte aquells professors/es que no imparteixen cap assignatura. El resultat mostrarà cinc columnes: id, nom, primer cognom, segon cognom i nombre d'assignatures. El resultat estarà ordenat de major a menor pel nombre d'assignatures.

-- 10.Retorna totes les dades de l'alumne/a més jove.
SELECT id, nif, nombre, apellido1, apellido2, ciudad, direccion, telefono, max(fecha_nacimiento), sexo, tipo  FROM persona;

-- 11.Retorna un llistat amb els professors/es que tenen un departament associat i que no imparteixen cap assignatura.