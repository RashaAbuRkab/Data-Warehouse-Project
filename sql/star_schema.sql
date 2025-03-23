CREATE TABLE dw.dim_leagues (
    leagueID INT PRIMARY KEY,  -- Primary key
    name VARCHAR(100) NOT NULL,  -- League name (e.g., Premier League)
    understatNotation VARCHAR(50) NOT NULL -- League notation (e.g., EPL)
);

CREATE TABLE dw.dim_players (
    playerID INT PRIMARY KEY,  -- Primary key
    name VARCHAR(100) NOT NULL-- Player's name
);

CREATE TABLE dw.dim_teams (
    teamID INT PRIMARY KEY,  -- Primary key
    name VARCHAR(100) NOT NULL-- Team name (e.g., Manchester United)
);

CREATE TABLE dw.dim_games (
    gameID INT PRIMARY KEY,  -- Primary key
    leagueID INT REFERENCES dw.dim_leagues(leagueID) NOT NULL,  -- Foreign key to leagues table
    season VARCHAR(50),  -- Season (e.g., 2015-2016)
    date_ timestamp,  -- Date and time of the game
    homeTeamID INT REFERENCES dw.dim_teams(teamID) NOT NULL,  -- Foreign key to home team
    awayTeamID INT REFERENCES dw.dim_teams(teamID) NOT NULL,  -- Foreign key to away team
    homeGoals INT,  -- Goals scored by the home team
    awayGoals INT,  -- Goals scored by the away team
    homeProbability FLOAT,  -- Probability of home team winning
    drawProbability FLOAT,  -- Probability of a draw
    awayProbability FLOAT,  -- Probability of away team winning
    homeGoalsHalfTime INT,  -- Home team goals at half-time
    awayGoalsHalfTime INT,  -- Away team goals at half-time
    B365H FLOAT,  -- Bet365 odds for home win
    B365D FLOAT,  -- Bet365 odds for draw
    B365A FLOAT,  -- Bet365 odds for away win
    BWH FLOAT,  -- BetWin odds for home win
    BWD FLOAT,  -- BetWin odds for draw
    BWA FLOAT,  -- BetWin odds for away win
    IWH FLOAT,  -- Interwetten odds for home win
    IWD FLOAT,  -- Interwetten odds for draw
    IWA FLOAT,  -- Interwetten odds for away win
    PSH FLOAT,  -- Pinnacle odds for home win
    PSD FLOAT,  -- Pinnacle odds for draw
    PSA FLOAT,  -- Pinnacle odds for away win
    WHH FLOAT,  -- William Hill odds for home win
    WHD FLOAT,  -- William Hill odds for draw
    WHA FLOAT,  -- William Hill odds for away win
    VCH FLOAT,  -- VC Bet odds for home win
    VCD FLOAT,  -- VC Bet odds for draw
    VCA FLOAT,  -- VC Bet odds for away win
    PSCH FLOAT,  -- Pinnacle closing odds for home win
    PSCD FLOAT,  -- Pinnacle closing odds for draw
    PSCA FLOAT -- Pinnacle closing odds for away win
);

CREATE TABLE dw.fact_appearances (
    gameID INT REFERENCES dw.dim_games(gameID) NOT NULL,  -- Foreign key to games table
    playerID INT REFERENCES dw.dim_players(playerID) NOT NULL,  -- Foreign key to players table
    goals INT,  -- Number of goals
    ownGoals INT,  -- Number of own goals
    shots INT,  -- Number of shots
    xGoals FLOAT,  -- Expected goals (xG)
    xGoalsChain FLOAT,  -- Expected goals chain
    xGoalsBuildup FLOAT,  -- Expected goals buildup
    assists INT,  -- Number of assists
    keyPasses INT,  -- Key passes
    xAssists FLOAT,  -- Expected assists (xA)
    position VARCHAR(10),  -- Player position (e.g., GK, DR, DC)
    positionOrder INT,  -- Position order
    yellowCard INT,  -- Number of yellow cards
    redCard INT,  -- Number of red cards
    time_ INT,  -- Minutes played
    substituteIn VARCHAR(10),  -- Substitute in time
    substituteOut VARCHAR(10),  -- Substitute out time
    leagueID INT REFERENCES dw.dim_leagues(leagueID) NOT NULL,  -- Foreign key to leagues table
    PRIMARY KEY (gameID, playerID)  -- Composite primary key
);

CREATE TABLE dw.fact_shots (
    gameID INT REFERENCES dw.dim_games(gameID) NOT NULL,  -- Foreign key to games table
    shooterID INT REFERENCES dw.dim_players(playerID) NOT NULL,  -- Foreign key to shooter (player)
    assisterID INT REFERENCES dw.dim_players(playerID) NOT NULL,  -- Foreign key to assister (player, can be NULL)
    minute_ INT,  -- Minute of the shot
    situation VARCHAR(50),  -- Situation (e.g., OpenPlay, SetPiece)
    lastAction VARCHAR(50),  -- Last action (e.g., Pass, Tackle)
    shotType VARCHAR(50),  -- Type of shot (e.g., LeftFoot, RightFoot)
    shotResult VARCHAR(50),  -- Result of the shot (e.g., BlockedShot, MissedShots)
    xGoal FLOAT,  -- Expected goal (xG) value
    positionX FLOAT,  -- X coordinate of the shot
    positionY FLOAT,  -- Y coordinate of the shot
    PRIMARY KEY (gameID, shooterID)  -- Composite primary key
);

CREATE TABLE dw.fact_teamstats (
    gameID INT REFERENCES dw.dim_games(gameID) NOT NULL,  -- Foreign key to games table
    teamID INT REFERENCES dw.dim_teams(teamID) NOT NULL,  -- Foreign key to teams table
    season VARCHAR(50),  -- Season (e.g., 2015-2016)
    date_ timestamp,  -- Date of the game
    location VARCHAR(1),  -- Location (h = home, a = away)
    goals INT,  -- Goals scored
    xGoals FLOAT,  -- Expected goals (xG)
    shots INT,  -- Total shots
    shotsOnTarget INT,  -- Shots on target
    deep INT,  -- Deep passes/completions
    ppda FLOAT,  -- PPDA (Passes per Defensive Action)
    fouls INT,  -- Number of fouls
    corners INT,  -- Number of corners
    yellowCards INT,  -- Number of yellow cards
    redCards INT,  -- Number of red cards
    result_ VARCHAR(1),  -- Result (W = Win, L = Loss, D = Draw)
    PRIMARY KEY (gameID, teamID)  -- Composite primary key
);
-------------export data from raw_tables.leagues to dw.dim_leagues-----------
INSERT INTO dw.dim_leagues (leagueID, name, understatNotation)
SELECT leagueID, name, understatNotation
FROM raw_tables.leagues;

-------------export data from raw_tables.players to dw.dim_players-----------
INSERT INTO dw.dim_players (playerID, name)
SELECT playerID, name
FROM raw_tables.players;

-------------export data from raw_tables.teams to dw.dim_teams-----------
INSERT INTO dw.dim_teams (teamID, name)
SELECT teamID, name
FROM raw_tables.teams;

-------------export data from raw_tables.games to dw.dim_games-----------
INSERT INTO dw.dim_games (gameID, leagueID, season, date_, homeTeamID, awayTeamID, homeGoals, awayGoals,
						 homeProbability, drawProbability, awayProbability, homeGoalsHalfTime, awayGoalsHalfTime,
						 B365H, B365D, B365A, BWH, BWD, BWA, IWH, IWD, IWA, PSH, PSD, PSA, WHH, WHD, WHA, VCH,
						 VCD, VCA, PSCH, PSCD, PSCA)
SELECT gameID, leagueID, season, date_, homeTeamID, awayTeamID, homeGoals, awayGoals,
						 homeProbability, drawProbability, awayProbability, homeGoalsHalfTime, awayGoalsHalfTime,
						 B365H, B365D, B365A, BWH, BWD, BWA, IWH, IWD, IWA, PSH, PSD, PSA, WHH, WHD, WHA, VCH,
						 VCD, VCA, PSCH, PSCD, PSCA
FROM raw_tables.games;

-------------export data from raw_tables.appearances to dw.fact_appearances-----------
INSERT INTO dw.fact_appearances (gameID, playerID, goals, ownGoals, shots, xGoals, xGoalsChain, xGoalsBuildup,
								assists, keyPasses, xAssists, position, positionOrder, yellowCard, redCard,
								time_, substituteIn, substituteOut, leagueID)
SELECT a.gameID, a.playerID, a.goals, a.ownGoals, a.shots, a.xGoals, a.xGoalsChain, a.xGoalsBuildup,
								a.assists, a.keyPasses, a.xAssists, a.position, a.positionOrder, a.yellowCard, a.redCard,
								a.time_, a.substituteIn, a.substituteOut, a.leagueID
FROM raw_tables.appearances a
JOIN raw_tables.games g ON a.gameID = g.gameID
JOIN raw_tables.players p ON a.playerID = p.playerID
JOIN raw_tables.leagues l ON a.leagueID = l.leagueID;

-------------export data from raw_tables.shots to dw.fact_shots-----------
INSERT INTO dw.fact_shots (gameID, shooterID, assisterID, minute_, situation, lastAction, shotType, shotResult,
						  xGoal, positionX, positionY)
SELECT s.gameID, s.shooterID, s.assisterID, s.minute_, s.situation, s.lastAction, s.shotType, s.shotResult,
						  s.xGoal, s.positionX, s.positionY
FROM raw_tables.shots s
JOIN raw_tables.games g ON s.gameID = g.gameID;

-------------export data from raw_tables.teamstats to dw.fact_teamstats-----------
INSERT INTO dw.fact_teamstats (gameID, teamID, season, date_, location, goals, xGoals, shots, shotsOnTarget, deep,
						 ppda, fouls, corners, yellowCards, redCards, result_)
SELECT ts.gameID, ts.teamID, ts.season, ts.date_, ts.location, ts.goals, ts.xGoals, ts.shots, ts.shotsOnTarget, ts.deep,
						 ts.ppda, ts.fouls, ts.corners, ts.yellowCards, ts.redCards, ts.result_
FROM raw_tables.teamstats ts
JOIN raw_tables.games g ON ts.gameID = g.gameID
JOIN raw_tables.teams t ON ts.teamID = t.teamID;