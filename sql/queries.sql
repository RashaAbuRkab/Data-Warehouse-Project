-- Q1: "What is the total number and percentage of home and away wins across all teams for each season?"
SELECT 
    season, 
    COUNT(CASE WHEN location = 'h' AND result_ = 'W' THEN 1 END) AS home_wins,
    COUNT(CASE WHEN location = 'h' AND result_ = 'W' THEN 1 END) * 100.0 / NULLIF(COUNT(DISTINCT gameID), 0) AS home_win_percentage,
    COUNT(CASE WHEN location = 'a' AND result_ = 'W' THEN 1 END) AS away_wins,
    COUNT(CASE WHEN location = 'a' AND result_ = 'W' THEN 1 END) * 100.0 / NULLIF(COUNT(DISTINCT gameID), 0) AS away_win_percentage
FROM dw.fact_teamstats
GROUP BY season
ORDER BY season;

-- Q2: "How many home and away wins did each team achieve in each season, and what are their respective win percentages?"
SELECT 
    ts.season, 
    t.teamID, 
	t.name,
    COUNT(CASE WHEN location = 'h' AND result_ = 'W' THEN 1 END) AS home_wins,
    COUNT(CASE WHEN location = 'h' AND result_ = 'W' THEN 1 END) * 100.0 / NULLIF(COUNT(CASE WHEN location = 'h' THEN 1 END), 0) AS home_win_percentage,
    COUNT(CASE WHEN location = 'a' AND result_ = 'W' THEN 1 END) AS away_wins,
    COUNT(CASE WHEN location = 'a' AND result_ = 'W' THEN 1 END) * 100.0 / NULLIF(COUNT(CASE WHEN location = 'a' THEN 1 END), 0) AS away_win_percentage
FROM dw.fact_teamstats ts
JOIN
	dw.dim_teams t ON ts.teamID = t.teamID
GROUP BY ts.season, t.teamID
ORDER BY ts.season, t.teamID;

-- Q3: "What is the average total number of goals scored per game in each league?"
---It gives a quick overview of the offensive nature of games in each league, helping assess whether some leagues have higher-scoring games than others.---
SELECT
	g.leagueID,
	l.name AS league_name,
	AVG(g.homeGoals + g.awayGoals) AS avg_total_goals
FROM
	dw.dim_games g
JOI
	dw.dim_leagues l ON g.leagueID = l.leagueID
GROUP BY
	g.leagueID, l.name;
	
-- Q4: "Who are the top 10 players with the highest total goals, and what are their ranks based on goal scoring?"
--- 1. Identifying Star Performers
	-- The query highlights the top 10 goal-scoring players, which can help businesses (e.g., sports teams, leagues, or advertisers) identify the most impactful players.
	-- These players can be prioritized for promotions, endorsements, or contract negotiations.
--- 2. Fan Engagement and Marketing
	-- Knowing the most prolific goal-scorers allows the business to market these players to fans, boosting ticket sales, merchandise, and overall fan engagement.
WITH PlayerGoals AS (
	SELECT a.playerID, pl.name, SUM(a.goals) AS total_goals
FROM
	dw.fact_appearances a
JOIN
	dw.dim_players pl ON a.playerID = pl.playerID
GROUP BY
	a.playerID, pl.name
)
SELECT
	playerID,
	name,
	total_goals,
	RANK() OVER (ORDER BY total_goals DESC) AS player_rank
FROM PlayerGoals
LIMIT 10;

-- Q5: "What are the key statistics and probabilities for games played between FC Barcelona and Real Madrid (El Clásico)?"
--- Historic Performance Tracking: It allows businesses to analyze historical performance and trends in one of the most-watched football rivalries.
--- Marketing Campaigns: Insights from this data can fuel targeted campaigns or content marketing (e.g., promoting historical rivalries, hyping upcoming matches).
--- Fan Experiences: Enhanced storytelling for fans by presenting in-depth stats, like probabilities and outcomes.
SELECT * FROM dw.dim_teams
WHERE name LIKE 'Bar%' OR name LIKE '%Real M%';
CREATE VIEW el_classico AS
SELECT
 ts.*,
 t.name,
 g.homeProbability,
 g.drawProbability,
 g.awayProbability
FROM dw.fact_teamstats ts
NATURAL JOIN dw.dim_teams t
JOIN dw.dim_games g ON ts.gameID = g.gameID
WHERE (g.homeTeamID = 148 AND g.awayTeamID = 150) 
OR (g.homeTeamID = 150 AND g.awayTeamID = 148);


SELECT * FROM el_classico;

-- Q6: "How many wins were achieved by each team in El Clásico matches with game ID 1510?"
SELECT
	name,
	SUM(CASE WHEN result_ = 'W' THEN 1 ELSE 0 END) AS win_count
FROM el_classico
WHERE gameID = 1510
GROUP BY name;

-- Q7: "In El Clásico matches, how often did a team win despite having a lower pre-game probability of winning compared to their opponent?"
SELECT *
FROM el_classico
WHERE
 (location = 'h' AND result_ = 'W' AND awayProbability >
homeProbability)
 OR
 (location = 'a' AND result_ = 'W' AND homeProbability >
awayProbability);
