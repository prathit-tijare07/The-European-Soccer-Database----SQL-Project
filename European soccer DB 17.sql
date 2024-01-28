use Soccer_db;
select * from asst_referee_mast;
select * from coach_mast;
select * from goal_details;
select * from match_captain;
select * from match_details;
select * from match_mast;
select * from penalty_gk;
select * from penalty_shootout;
select * from player_booked;
select * from player_in_out;
select * from player_mast;
select * from playing_position;
select * from referee_mast;
select * from soccer_city;
select * from soccer_country;
select * from soccer_team;	
select * from soccer_venue;
select * from team_coaches;

select sum(audience) from match_mast;

/*-- Q1 .Write a SQL query to find out where the final match
         of the EURO cup 2016 was played.Return venue name, city.*/
         
	select * from match_mast;
    select * from soccer_venue;
    select * from soccer_city;
    
    select venue_name,city
    from soccer_venue as a
    JOIN soccer_city as b
    ON a.city_id = b.city_id 
    JOIN Match_mast as c
    ON a.venue_id = c.venue_id 
    where play_stage = 'F';
 
 /* --Q2.Write a SQL query to find the number of goals scored by each team 
 in each match during normal play.
 Return match number, country name and goal score.*/ 
 
 select * from soccer_country;
select * from match_details;

select match_no,country_name,goal_score
 from match_details as a
 JOIN Soccer_country as b
 ON b.country_id = a.team_id
 where decided_by = 'N'
 Order by Match_no ASC;
 
 /*  Q3.	Write a SQL query to count the number of goals scored by each player within a normal play schedule.
 Group the result set on player name and country name and sorts the result-set according
 to the highest to the lowest scorer. Return player name, number of goals and country name.*/
 
 select * from goal_details;
 select * from player_mast;
  select * from soccer_country;

 select player_name,country_name,count(goal_id) as no_goals
 from goal_details as a
 JOIN player_mast as b
 ON a.player_id = b.player_id
 JOIN Soccer_country as c
 ON a.team_id = c.country_id
 where goal_schedule = 'NT'
 group by player_name,country_name
 order by no_goals DESC;
 
 /* Q4. write a SQL query to find out who scored the most goals in the 2016 Euro Cup.
 Return player name, country name and highest individual scorer.*/
 select * from goal_details;
select * from player_mast;
select * from soccer_country;

select player_name,country_name ,count(player_name) as c_playername
from goal_details as a
JOIN player_mast as b
ON a.player_id  = b.player_id 
JOIN soccer_country as c
ON a.team_id = c.country_id 
group by player_name,country_name
having c_playername >
(select player_name,country_name ,count(player_name)
from goal_details as a
JOIN player_mast as b
ON a.player_id  = b.player_id 
JOIN soccer_country as c
ON a.team_id = c.country_id 
group by player_name,country_name);


/* Q5. write a SQL query to find out who scored in the final of the 2016 Euro Cup.
Return player name, jersey number and country name.*/

select * from player_mast;
select * from soccer_country;
 select * from goal_details;

select player_name,jersey_no, country_name from
goal_details as a
JOIN player_mast as b
ON a.player_id= b.player_id
JOIN soccer_country as c
ON a.team_id = c.country_id 
where play_stage = 'F';


/* Q6. write a SQL query to find out which country hosted the 2016 Football EURO Cup. Return country name.*/
select * from soccer_country;
select * from soccer_venue;
select * from soccer_city;

select country_name from soccer_country as a
JOIN soccer_city as b
ON a.country_id = b.country_id
JOIN soccer_venue as C
ON b.city_id = c.city_id 
group by country_name;

/*Q7. From the match_details and soccer_country tables,find the teams played the first match of EURO cup 2016.
	Return match number, country name. */ 
        
        select * from match_details;
        select * from soccer_country;
        select match_no,country_name from match_details as a
        JOIN soccer_country as b
        ON a.team_id = b.country_id
        where match_no = 1;
        
/* Q8. write a SQL query to find out who scored the first goal
 of the 2016 European Championship. 
 Return player_name, jersey_no, country_name,
 goal_time, play_stage, goal_schedule, goal_half.*/
select * from player_mast;
select * from soccer_country;
select * from goal_details;


select player_name,jersey_no,country_name,goal_time,goal_time,goal_schedule,goal_half
from goal_details as a
JOIN player_mast as b
ON a.player_id = b.player_id 
JOIN soccer_country as c
ON a.team_id = c.country_id 
where goal_id  = 1;

/*Q9. write a SQL query to find the referee who managed 
the opening match. Return referee name, country name.*/

select * from referee_mast;
select * from soccer_country;
select * from match_mast;

select referee_name,country_name
from referee_mast as a
JOIN match_mast as b
ON a.referee_id = b.referee_id
JOIN soccer_country as c
ON a.country_id = c.country_id
where match_no =1;

-- Method 2-- with Natural JOIN-- 
select  b.referee_name, c.country_name 
from match_mast a
NATURAL JOIN referee_mast b 
NATURAL JOIN soccer_country c
where match_no=1;

/*Q10. write a SQL query to find the referee who managed 
the final match.
 Return referee name, country name. */

select * from referee_mast;
select * from soccer_country;
select * from match_mast;

select referee_name,country_name 
from referee_mast as a
JOIN match_mast as b
ON a.referee_id = b.referee_id 
JOIN soccer_country as c
ON a.country_id = c.country_id 
where play_stage = 'F';


select b.referee_name, c.country_name 
from match_mast a
NATURAL JOIN referee_mast b 
NATURAL JOIN soccer_country c
where play_stage='F';

 /*Q11. write a SQL query to find the referee who
 assisted the referee in the opening match. 
Return associated referee name, country name.*/


select * from soccer_country;
select * from asst_referee_mast;
select * from match_details;

select ass_ref_name,country_name from asst_referee_mast as a
JOIN soccer_country as b
ON a.country_id = b.country_id
JOIN match_details as c
ON a.ass_ref_id =c.ass_ref 
where match_no = 1;

/* -- Q12. write a SQL query to find the referee who 
assisted the referee in the final match.
 Return associated referee name, country name.*/ 
 
 select * from asst_referee_mast;
 select * from soccer_country;
 select * from match_details;
 
 select ass_ref_name,country_name
 from asst_referee_mast as a
 JOIN soccer_country as b
 ON a.country_id = b.country_id
 JOIN match_details as c
 ON a.ass_ref_id = c.ass_ref
 where play_stage = 'F';
 
 
/*Q13. write a SQL query to find the 
city where the opening match of EURO cup 2016 took place. 
Return venue name, city.*/

select * from soccer_venue;
select * from soccer_city;
select * from match_mast;

select venue_name,city from soccer_venue as a
JOIN soccer_city as b
ON a.city_id = b.city_id 
JOIN match_mast as c
ON a.venue_id = c.venue_id
where match_no = 1;

/*Q13. write a SQL query to find out which stadium hosted
 the final match of the 2016 Euro Cup.
 Return venue_name, city, aud_capacity, audience.*/

select * from soccer_venue;
select * from soccer_city;
select * from match_mast;

select venue_name,city,aud_capacity,audience 
from Soccer_venue as a
JOIN soccer_city as b
ON a.city_id = b.city_id
JOIN match_mast as c
ON a.venue_id = c.venue_id 
where play_stage = 'F';

/* Q14.	Write a SQL query to count the number of matches
 played at each venue. Sort the result-set on venue name.
 Return Venue name, city, and number of matches.*/
select * from soccer_venue;
select * from soccer_city;
select * from match_mast;

select venue_name,city, count(match_no) NO_of_matches
from soccer_venue as a
JOIN soccer_city as b
ON a.city_id = b.city_id 
JOIN match_mast as c
ON a.venue_id = c.venue_id
group by venue_name,city
order by venue_name;

/*Q15. write a SQL query to find the player who was the 
first player to be sent off at the tournament EURO cup 2016. 
Return match Number, country name and player name. */

select * from player_mast;
select * from soccer_country;
select * from player_booked;

select match_no,country_name,player_name, Jersey_no,playing_club
from player_booked as a
JOIN player_mast as b
ON a.player_id = b.player_id 
JOIN soccer_country as c
ON a.team_id = c.country_id 
where sent_off = 'Y'
AND match_no = (select Min(match_no) from player_booked)
order by match_no,play_schedule,play_half,booking_time;

-- Q16. From the match_details and soccer_country tables, find the teams played the first match of EURO cup 2016.
 -- Return match number, country name.
select * from match_details;
select * from soccer_country;
select match_no,country_name from match_details as a
JOIN soccer_country as b
ON a.team_id = b.country_id 
where match_no =1;

 -- Q17. From the soccer_country and match_details tables, find the winner of EURO cup 2016. 
 -- Return country name.
 select * from soccer_country;
 select * from match_details;
 
 select country_name from soccer_country as a
 JOIN match_details as b
 ON a.country_id = b.team_id 
 where play_stage = 'F' and win_lose = 'W';
 
 -- With Subquery --
 select country_name
from soccer_country
where country_id =(select team_id 
                    from match_details
                    where play_stage = 'F' AND win_lose = 'W');
 
 
 -- Q18.From the match_mast table, find the most watched match in the world. 
 -- Return match_no, play_stage, goal_score, audience.
 
 select * from match_mast;
select match_no,play_stage,goal_score,audience 
from match_mast
where audience = (select max(audience) from match_mast);

 /*-- Q10.From the goal_details, soccer_country, and player_mast tables, 
 find those players who scored number of goals in every match. 
 Group the result set on match number, country name and player name. 
 Sort the result-set in ascending order by match number.
 Return match number, country name, player name and number of matches.*/
 
 select * from goal_details;
 select * from soccer_country;
 select * from player_mast;

select match_no,country_name,player_name,count(match_no) from
goal_details as a
JOIN  player_mast as b
ON a.player_id = b.player_id 
JOIN soccer_country as c
ON a.team_id = c.country_id
group by match_no,country_name,player_name
order by match_no ASC;
 
 
 
 
 
 
 

