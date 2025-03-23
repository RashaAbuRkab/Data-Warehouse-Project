-- appearances Table:
CREATE TABLE raw_tables.appearances (
    gameID INT,  -- Foreign key to games table
    playerID INT,  -- Foreign key to players table
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
    leagueID INT,  -- Foreign key to leagues table
    PRIMARY KEY (gameID, playerID)  -- Composite primary key
);

-- games Table
CREATE TABLE raw_tables.games (
    gameID INT PRIMARY KEY,  -- Primary key
    leagueID INT,  -- Foreign key to leagues table
    season VARCHAR(50),  -- Season (e.g., 2015-2016)
    date_ timestamp,  -- Date and time of the game
    homeTeamID INT,  -- Foreign key to home team
    awayTeamID INT,  -- Foreign key to away team
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

-- leagues Table

CREATE TABLE raw_tables.leagues (
    leagueID INT PRIMARY KEY,  -- Primary key
    name VARCHAR(100),  -- League name (e.g., Premier League)
    understatNotation VARCHAR(50)  -- League notation (e.g., EPL)
);

-- players Table
CREATE TABLE raw_tables.players (
    playerID INT PRIMARY KEY,  -- Primary key
    name VARCHAR(100)  -- Player's name
);

-- shots Table
CREATE TABLE raw_tables.shots (
    gameID INT,  -- Foreign key to games table
    shooterID INT,  -- Foreign key to shooter (player)
    assisterID INT,  -- Foreign key to assister (player, can be NULL)
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

-- teams Table:
CREATE TABLE raw_tables.teams (
    teamID INT PRIMARY KEY,  -- Primary key
    name VARCHAR(100)  -- Team name (e.g., Manchester United)
);

-- teamstats Table
CREATE TABLE raw_tables.teamstats (
    gameID INT,  -- Foreign key to games table
    teamID INT,  -- Foreign key to teams table
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
