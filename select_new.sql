'Количество исполнителей в каждом жанре.'
select count(*), style_id from musicians m, musician_styles ms where m.musician_id = ms.musician_id group by style_id

'Количество треков, вошедших в альбомы 2019–2020 годов.'
select count(*), ct.collection_id, year from collection_tracks ct , collection cwhere ct.collection_id = c.collection_id and c.year >= ('2018-01-01') and c.year <= ('2019-12-31')group by ct.collection_id, year 


'Средняя продолжительность треков по каждому альбому.'
select avg(duration), t.albom from tracks t group by albom 


'Все исполнители, которые не выпустили альбомы в 2020 году.'
select name from musicians where musician_id in (select musician_id from musicians_alboms where alboms_id in (select alboms_id from alboms where year < ('2020-01-01') or  year > ('2020-12-31')))


'Названия сборников, в которых присутствует конкретный исполнитель (выберите его сами).'
'Делаем поиск по имени Артист 1'
select name from collection where collection_id in 
(select collection_id from collection_tracks where tracks_id in 
(select tracks_id from tracks where albom in 
(select alboms_id from musicians_alboms where musician_id in 
(select musician_id from musicians where name = 'Артист 1'))))



'Названия альбомов, в которых присутствуют исполнители более чем одного жанра.'
'Музыкант Артист 1 работает в двух жанрах'
select distinct name from collection where collection_id in 
(select collection_id from collection_tracks where tracks_id in 
(select tracks_id from tracks where albom in 
(select alboms_id from musicians_alboms where musician_id in 
(select musician_id from musician_styles GROUP BY  musician_id having count(musician_id) >1 ))))



'Наименования треков, которые не входят в сборники.'
select name from tracks t where tracks_id not in (select tracks_id from collection_tracks) 


'Исполнитель или исполнители, написавшие самый короткий по продолжительности трек, — теоретически таких треков может быть несколько.'
select name from musicians m where musician_id in (select musician_id  from musicians_alboms ma where alboms_id in (select albom from tracks t where duration in (select min(duration) from tracks)))

'Названия альбомов, содержащих наименьшее количество треков.'
'Выводим три альбома, в которых меньше всего треков'

select name from alboms a where alboms_id in (select albom from tracks GROUP by tracks.albom order by count(*) limit 3)
