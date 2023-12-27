MUSIC_STORE_DATAMUSIC_STORE_DATA--creting the database 
create database music_store_data
use music_store_data

--checking out some tables and their info
select * from album
select * from album2
select * from media_type
select * from invoice_line
select * from invoice
select * from playlist_track
select * from playlist
select * from genre
select * from customer

-- senior most employee based on the job title
select * from employee
select distinct(levels) from employee
select * from employee where levels='L7'
--madan mohan is the senior most employee who is the senior gm who doesn"t reports to anyone

--which countries have the most invoices?
select * from invoice

select sum(total) as total_invoices ,billing_country 
from invoice
group by 2
order by 1 desc

--usa has the most number of invoices with a total of 1051 followed by canada,brazil,france,germany,cech republic etc.

--what are the top 3 total values of invoices? answer - 1051,541,432 

--which city has the best customers ?we would like to throw a promotional music festival in the city we made the most money.write a query which returns one city that has the highest sum of invoice totals.return both the city name and the sum of the all invoice totals.

select * from customer
select * from invoice

select sum(total) as total_of_best_billing_city ,billing_city
from invoice
group by billing_city
order by 1 desc

select count(total) as total_of_best_billing_city ,billing_city
from invoice
group by billing_city
order by 1 desc

select count(billing_city) as total_of_best_billing_city ,billing_city
from invoice
group by billing_city
order by 1 desc

--prague is the city with the most number of invoices


--who is the best customer?the customer who has spend the most money will be declared the best customer.write a query that returns the person who has spent the most money.

select customer.customer_id,customer.first_name,customer.last_name, sum(invoice.total) as total_of_a_customer
from customer
join invoice on customer.customer_id = invoice.customer_id
group by customer.customer_id , customer.first_name,customer.last_name
order by 4 desc
limit 1


-- write query to return the MUSIC_STORE_DATA email,first name,last name, and genre of all rock music listeners.
-- return your list ordered alphabetically by email starting with A
select * from customer
select * from invoice
select * from invoice_line
select * from genre


select c.customer_id, c.email,c.first_name,c.last_name from customer as c 
left join invoice as i on c.customer_id = i.customer_id
left join invoice_line as il on i.invoice_id = il.invoice_id
left join track as t on il.track_id=t.track_id
left join genre as g where g.name = 'Rock'
group by c.customer_id,c.email,c.first_name,c.last_name
order by c.email


-- lets invite the artists who have written the most rock music in our dataset.
-- write a query that returns the artist name and total track count of the top 10 rock bands
-- artist artist_id,genre genre_id,track genre_id,track track_id,track album_id,album album_id,album artist_id

select ar.name,count(distinct(t.name)) as total_tracks_composed from artist as ar
left join album as al on ar.artist_id=al.artist_id
left join track as t on al.album_id=t.album_id
left join genre as g on t.genre_id=g.genre_id
where g.name = 'Rock'
group by ar.name
order by 2 desc
limit 10

--return all the track names that have a song length longer than the average song length. retun the name and milliseconds for each track. order by the song length with the longest songs listed first

select name ,milliseconds
from track
where milliseconds>(
        select avg(milliseconds) from track
)
order by milliseconds desc 

--find out how much amount spent by each customer on artists? write a query to return customer name,artist name and total spent
--customer& invoice customer_id,invoice and invoice_line invoice_id,album artist artist_id,track and album album_id

select concat(c.first_name,' ',c.last_name) as full_name , ar.name

where ar.name = 'Queen' and c.first_name='Wyatt'

select c.customer_id , concat(c.first_name,' ',c.last_name) as full_name , ar.name , sum(il.unit_price*il.quantity) as total_spent
from customer as c
inner join invoice as i on c.customer_id=i.customer_id
inner join invoice_line as il on i.invoice_id = il.invoice_id
inner join track as t on il.track_id = t.track_id
inner join album as al on t.album_id = al.album_id
inner join artist as ar on al.artist_id = ar.artist_id
group by 1,2,3
order by 4 desc


--we want to find out the most popular music genre for each country. we determine the most popular genre as the --genre with the highest amount of purchases . write a query that returns each country along with the top genre. for countries where the max number of purcases is shared retur all genres
--invoice invoice_line invoice_id,billing_country from invoice,invoice_line track track_id, track genre genre_id, invoice_line unit_price quantity , track unit_price


with popular_genre as (
    select count(invoice_line.quantity) as purchases,customer.country,genre.name,genre.genre_id,
    row_number() over(partition by customer.country order by count(invoice_line.quantity)desc) as row_no
    from invoice_line
    join invoice on invoice.invoice_id = invoice_line.invoice_id
    join customer on customer.customer_id = invoice.customer_id
    join track on track.track_id = invoice_line.track_id
    join genre on genre.genre_id = track.genre_id
    group by 2,3,4
    order by 2 asc , 2 desc
)
select * from popular_genre where row_no <=1







































select * from invoice as i
inner join invoice_line as il on i.invoice_id = il.invoice_id
inner join track as t on il.track_id = t.track_id
inner join genre as g on t.genre_id = g.genre_id
where 













--write a query that determines the customer that has spent the most on music for each country .
--write a query that returns the country along with the top customer and how much they spent. for countries where the top amount spent is shared , provide all customers who spent this amount.




