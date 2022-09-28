--- URI Online Judge SQL
--- Copyright URI Online Judge
--- www.urionlinejudge.com.br
--- Problem 2988

CREATE TABLE teams (
    id integer PRIMARY KEY,
    name varchar(50)
);

GRANT SELECT ON teams TO sql_user;

CREATE TABLE matches  (
    id integer PRIMARY KEY,
    team_1 integer,
    team_2 integer,
    team_1_goals integer,
    team_2_goals integer,
    FOREIGN KEY (team_1) REFERENCES teams(id),
    FOREIGN KEY (team_2) REFERENCES teams(id)
);

GRANT SELECT ON matches TO sql_user;insert into teams
    (id, name)
values
    (1,'CEARA'),
    (2,'FORTALEZA'),
    (3,'GUARANY DE SOBRAL'),
    (4,'FLORESTA');

insert into  matches
    (id, team_1, team_2, team_1_goals, team_2_goals)
values
    (1,4,1,0,4),
    (2,3,2,0,1),
    (3,1,3,3,0),
    (4,3,4,0,1),
    (5,1,2,0,0),
    (6,2,4,2,1);

/* Execute this query to drop the table */
DROP TABLE matches;


SELECT teams.name, count(teams.name) as matches, 
count( CASE WHEN (team_1_goals > team_2_goals and teams.id = team_1) or (team_2_goals > team_1_goals and teams.id = team_2) then 1 end ) as victories, 
count( CASE WHEN (team_1_goals > team_2_goals and teams.id = team_2) or (team_2_goals > team_1_goals and teams.id = team_1) then 1 end ) as defeats, 
count( CASE WHEN (team_1_goals = team_2_goals and teams.id = team_1) or (team_1_goals = team_2_goals and teams.id = team_2) then 1 end) as draws, 

count( CASE WHEN (team_1_goals > team_2_goals and teams.id = team_1) or (team_2_goals > team_1_goals and teams.id = team_2) then 1 end )* 3 + 
count( CASE WHEN (team_1_goals < team_2_goals and teams.id = team_1) or (team_2_goals < team_1_goals and teams.id = team_2) then 1 end )* 0 + 
count( CASE WHEN team_1_goals = team_2_goals then 1 end) * 1 as score 

FROM teams INNER JOIN matches 
ON 
teams.id = matches.team_1 or teams.id = matches.team_2 
group by teams.id, teams.name
order by score DESC, name;
