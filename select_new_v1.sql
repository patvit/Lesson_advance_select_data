--Количество исполнителей в каждом жанре.'
select s.name, count(*)
from styles s 
LEFT join musician_styles ms on s.style_id = ms.style_id
group by s.style_id


--Количество треков, вошедших в альбомы 2019–2020 годов.'
select count(*) from tracks t 
join alboms a on a.alboms_id = t.albom 
where a."year" between '2019-01-01' and '2020-12-31'


--Средняя продолжительность треков по каждому альбому.'
select avg(duration), t.albom from tracks t group by albom 


--Все исполнители, которые не выпустили альбомы в 2020 году.'
select name from musicians where musician_id in (select musician_id from musicians_alboms where alboms_id in (select alboms_id from alboms where year < ('2020-01-01') or  year > ('2020-12-31')))


--Названия сборников, в которых присутствует конкретный исполнитель (выберите его сами).'
--Делаем поиск по имени Артист 1'
select distinct c.name from collection c
join collection_tracks ct on ct.collection_id = c.collection_id 
join tracks t on t.tracks_id = ct.tracks_id 
join alboms a on t.albom = a.alboms_id 
join musicians_alboms ma on ma.alboms_id = a.alboms_id 
join musicians m on m.musician_id = ma.musician_id 
where m.name = 'Артист 1'



--Названия альбомов, в которых присутствуют исполнители более чем одного жанра.'
select distinct a.name from alboms a 
join musicians_alboms ma on ma.alboms_id = a.alboms_id 
join musicians m on m.musician_id = ma.musician_id 
join musician_styles ms on ms.musician_id = m.musician_id 
group by a.name, ms.musician_id 
having (select count(ms.style_id) from musician_styles ms) >1



--Наименования треков, которые не входят в сборники.'
select name from tracks t where tracks_id not in (select tracks_id from collection_tracks) 


--Исполнитель или исполнители, написавшие самый короткий по продолжительности трек, — теоретически таких треков может быть несколько.'
select m.name from musicians m
join musicians_alboms ma on ma.musician_id = m.musician_id 
join alboms a on a.alboms_id = ma.alboms_id 
join tracks t on t.albom = a.alboms_id 
where t.duration = (select min(duration) from tracks)


--Названия альбомов, содержащих наименьшее количество треков.'
--Выводим три альбома, в которых меньше всего треков'

select a.name, count(t.tracks_id)
from alboms a
join tracks t on t.albom = a.alboms_id 
group by a.alboms_id 
having count (tracks_id) = (
select count(t2.tracks_id) from tracks t2 
group by t2.albom 
order by 1
limit 1)