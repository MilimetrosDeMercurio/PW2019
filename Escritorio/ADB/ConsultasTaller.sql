
--1. mostrar los alumnos de parvularia

select * from alumno where edad between 4 and 6;

--2. mostrar los alumnos de bachillerato

select * from alumno where edad between 16 and 17;

--3. mostrar los alumnos de segundo año b y ordenarlos en orden alfabetico

select a.nie,a.nombre, a.apellido, s.grado, s.letra
from alumno a, seccion s
where edad = 17
order by nombre asc;	

--4. mostrar los profesores y al edificio a que pertenece

select pr.dui_docente pr.nombre, e.edificio
from profesor pr, edifcio e;

--5. Liste los alumnos (todos sus atributos) y muestre los alumnos con
-- mensualidad de 110

SELECT a.nie, a.nombre, t.tipo, t.numero
FROM alumno a, talonario t
WHERE t.numero = 110
ORDER BY a.nombre asc;

--6. ¿Cuál es el descuento mínimo al que puede ser acreedor un alumno? ¿Cuál es el máximo?

Select min(numero) as descuento_minimo, max(numero) as descuento_maximo from subvencion

--7. ¿Cuántos alumnos hay en total en el colegio?

select count(a.nie) as total_alumnos from alumno a

--8.¿Cuales son los diferentes precios de mensualidad que pueden ser aplicados a los estudiantes?

Select * from pago


