USE homer3;

DELIMITER //
DROP PROCEDURE IF EXISTS homer3.add_player //
CREATE PROCEDURE add_player(
  in_firstName VARCHAR(20),
  in_lastName VARCHAR(20),
  in_teamId INT,
  in_keeperTeamId INT,
  in_salary INT,
  in_keeperSeason INT,
  in_season INT,
  in_isMinorLeaguer TINYINT(1),
  in_mlbTeam VARCHAR(3),
  in_positionId INT,
  in_fantasyPositionId INT
)
READS SQL DATA
  BEGIN

    SET @in_name = CONCAT(in_firstName, ' ', in_lastName);

    SELECT id INTO @mlbTeam FROM ref_mlb_team WHERE in_mlbTeam = abbreviation;

    SELECT UNIX_TIMESTAMP(now()) INTO @now;

    IF NOT EXISTS (select 1 FROM player where name = @in_name) THEN
        INSERT INTO player (name, firstName, lastName, mlbTeamId, positionId, createdDateUtc, updatedDateUtc)
        VALUES
        (@in_name, in_firstName, in_lastName, @mlbTeam, in_positionId, @now, @now);

        SET @id = LAST_INSERT_ID();
    END IF;

    INSERT INTO player_season (season, playerId, teamId, keeperTeamId, positionId, keeperSeason, salary, isMinorLeaguer, createdDateUTC, updatedDateUTC)
    VALUES
        (in_season, @id, in_teamId, in_keeperTeamId, in_fantasyPositionId, in_keeperSeason, in_salary, in_isMinorLeaguer, @now, @now);
  END //
DELIMITER ;

CALL add_player('Joey', 'Votto', 1, 1, 38, 1, 2016, 0, 'CIN', 3, 3);
CALL add_player('Francisco', 'Lindor', 1, 1, 3, 1, 2016, 0, 'CLE', 6, 6);
CALL add_player('Gregory', 'Polanco', 1, 1, 6, 2, 2016, 0, 'PIT', 7, 7);
CALL add_player('Michael', 'Conforto', 1, 1, 3, 1, 2016, 0, 'NYM', 7, 7);
CALL add_player('Jacob', 'DeGrom', 1, 1, 6, 2, 2016, 0, 'NYM', 1, 1);
CALL add_player('Andrew', 'Miller', 1, 1, 3, 1, 2016, 0, 'NYY', 9, 1);
CALL add_player('Jeurys', 'Familia', 1, 1, 3, 1, 2016, 0, 'NYM', 9, 1);
CALL add_player('Lance', 'McCullers', 1, 1, 3, 1, 2016, 0, 'HOU', 1, 1);
CALL add_player('Mark', 'Melancon', 1, 1, 6, 2, 2016, 0, 'PIT', 9, 1);
CALL add_player('Marcus', 'Stroman', 1, 1, 6, 2, 2016, 0, 'TOR', 1, 1);
CALL add_player('Yasmani', 'Grandal', 1, null, 15, 0, 2016, 0, 'LAD', 2, 2);
CALL add_player('Wilson', 'Ramos', 1, null, 5, 0, 2016, 0, 'WAS', 2, 2);
CALL add_player('Jose', 'Altuve', 1, null, 53, 0, 2016, 0, 'HOU', 4, 4);
CALL add_player('Adrian', 'Beltre', 1, null, 25, 0, 2016, 0, 'TEX', 5, 5);
CALL add_player('Anthony', 'Rendon', 1, null, 19, 0, 2016, 0, 'WAS', 5, 10);
CALL add_player('Freddie', 'Freeman', 1, null, 37, 0, 2016, 0, 'ATL', 3, 11);
CALL add_player('Mike', 'Trout', 1, null, 66, 0, 2016, 0, 'LAA', 7, 7);
CALL add_player('Franklin', 'Gutierrez', 1, null, 1, 0, 2016, 0, 'SEA', 7, 7);
CALL add_player('Matt', 'Holliday', 1, null, 3, 0, 2016, 0, 'STL', 7, 7);
CALL add_player('Danny', 'Valencia', 1, null, 1, 0, 2016, 0, 'OAK', 5, 12);
CALL add_player('Doug', 'Fister', 1, null, 1, 0, 2016, 0, 'HOU', 1, 1);
CALL add_player('Jesse', 'Hahn', 1, null, 3, 0, 2016, 0, 'OAK', 1, 1);
CALL add_player('Rick', 'Porcello', 1, null, 1, 0, 2016, 0, 'BOS', 1, 1);

CALL add_player('Brian', 'Mccann', 2, 2, 28, 1, 2016, 0, 'NYY', 2, 2);
CALL add_player('Jonathon', 'Schoop', 2, 2, 3, 1, 2016, 0, 'BAL', 4, 10);
CALL add_player('Billy', 'Hamilton', 2, 2, 6, 2, 2016, 0, 'CIN', 7, 7);
CALL add_player('Luis', 'Severino', 2, 2, 3, 1, 2016, 0, 'NYY', 1, 1);
CALL add_player('Rougned', 'Odor', 2, 2, 6, 1, 2016, 0, 'TEX', 4, 4);
CALL add_player('Kenley', 'Jansen', 2, 2, 12, 3, 2016, 0, 'LAD', 9, 1);
CALL add_player('Jon', 'Lester', 2, 2, 18, 2, 2016, 0, 'CHC', 1, 1);
CALL add_player('Danny', 'Salazar', 2, 2, 14, 1, 2016, 0, 'CLE', 1, 1);
CALL add_player('Aaron', 'Nola', 2, 2, 3, 1, 2016, 0, 'PHI', 1, 1);
CALL add_player('Wade', 'Davis', 2, 2, 3, 1, 2016, 0, 'KC', 9, 1);
CALL add_player('Nick', 'Hundley', 2, null, 5, 0, 2016, 0, 'COL', 2, 2);
CALL add_player('Brandon', 'Belt', 2, null, 14, 0, 2016, 0, 'SF', 3, 3);
CALL add_player('Nick', 'Castellanos', 2, null, 3, 0, 2016, 0, 'DET', 5, 5);
CALL add_player('Ian', 'Desmond', 2, null, 10, 0, 2016, 0, 'TEX', 7, 6);
CALL add_player('Jake', 'Lamb', 2, null, 1, 0, 2016, 0, 'ARI', 5, 11);
CALL add_player('Justin', 'Upton', 2, null, 35, 0, 2016, 0, 'DET', 7, 7);
CALL add_player('Jason', 'Heyward', 2, null, 27, 0, 2016, 0, 'CHC', 7, 7);
CALL add_player('Odubel', 'Herrera', 2, null, 1, 0, 2016, 0, 'PHI', 7, 7);
CALL add_player('Stephen', 'Piscotty', 2, null, 1, 0, 2016, 0, 'STL', 7, 7);
CALL add_player('Alex', 'Gordon', 2, null, 8, 0, 2016, 0, 'KC', 7, 12);
CALL add_player('Joe', 'Ross', 2, null, 5, 0, 2016, 0, 'WAS', 1, 1);
CALL add_player('Alex', 'Cobb', 2, null, 1, 0, 2016, 0, 'TB', 1, 1);
CALL add_player('Brett', 'Cecil', 2, null, 1, 0, 2016, 0, 'TOR', 1, 1);

CALL add_player('Russell', 'Martin', 3, 3, 9, 2, 2016, 0, 'TOR', 2, 2);
CALL add_player('Francisco', 'Cervelli', 3, 3, 3, 1, 2016, 0, 'PIT', 2, 2);
CALL add_player('Alex', 'Rodriguez', 3, 3, 8, 1, 2016, 0, 'NYY', 8, 12);
CALL add_player('Corey', 'Dickerson', 3, 3, 6, 2, 2016, 0, 'TB', 7, 7);
CALL add_player('Ken', 'Giles', 3, 3, 4, 1, 2016, 0, 'HOU', 9, 1);
CALL add_player('Zack', 'Greinke', 3, 3, 35, 2, 2016, 0, 'ARI', 1, 1);
CALL add_player('Carlos', 'Rodon', 3, 3, 3, 1, 2016, 0, 'CHW', 1, 1);
CALL add_player('Michael', 'Wacha', 3, 3, 9, 3, 2016, 0, 'STL', 1, 1);
CALL add_player('Eduardo', 'Rodriguez', 3, 3, 3, 1, 2016, 0, 'BOS', 1, 1);
CALL add_player('Albert', 'Pujols', 3, null, 21, 0, 2016, 0, 'STL', 3, 3);
CALL add_player('Ben', 'Zobrist', 3, null, 9, 0, 2016, 0, 'CHC', 4, 4);
CALL add_player('Justin', 'Turner', 3, null, 1, 0, 2016, 0, 'LAD', 5, 5);
CALL add_player('Troy', 'Tulowitzki', 3, null, 25, 0, 2016, 0, 'TOR', 6, 6);
CALL add_player('Daniel', 'Murphy', 3, null, 6, 0, 2016, 0, 'WAS', 4, 10);
CALL add_player('David', 'Wright', 3, null, 1, 0, 2016, 0, 'NYM', 5, 11);
CALL add_player('Wil', 'Myers', 3, null, 9, 0, 2016, 0, 'SD', 7, 7);
CALL add_player('Dexter', 'Fowler', 3, null, 5, 0, 2016, 0, 'CHC', 7, 7);
CALL add_player('Josh', 'Reddick', 3, null, 3, 0, 2016, 0, 'OAK', 7, 7);
CALL add_player('Rajai', 'Davis', 3, null, 1, 0, 2016, 0, 'TOR', 7, 7);
CALL add_player('Felix', 'Hernandez', 3, null, 29, 0, 2016, 0, 'SEA', 1, 1);
CALL add_player('James', 'Shields', 3, null, 10, 0, 2016, 0, 'SD', 1, 1);
CALL add_player('Gio', 'Gonzalez', 3, null, 6, 0, 2016, 0, 'WAS', 1, 1);
CALL add_player('Jonathan', 'Papelbon', 3, null, 10, 0, 2016, 0, 'WAS', 9, 1);

CALL add_player('Jonathan', 'Lucroy', 4, 4, 19, 3, 2016, 0, 'MIL', 2, 2);
CALL add_player('Kolten', 'Wong', 4, 4, 6, 2, 2016, 0, 'STL', 4, 4);
CALL add_player('Hector', 'Olivera', 4, 4, 3, 0, 2016, 0, 'ATL', 5, 5);
CALL add_player('Yasmany', 'Tomas', 4, 4, 3, 1, 2016, 0, 'ARI', 7, 7);
CALL add_player('Billy', 'Burns', 4, 4, 3, 1, 2016, 0, 'OAK', 7, 7);
CALL add_player('Devin', 'Mesoraco', 4, 4, 15, 2, 2016, 0, 'CIN', 2, 2);
CALL add_player('Julio', 'Teheran', 4, 4, 9, 3, 2016, 0, 'ATL', 1, 1);
CALL add_player('Carlos', 'Martinez', 4, 4, 15, 1, 2016, 0, 'STL', 1, 1);
CALL add_player('Kevin', 'Gausman', 4, 4, 14, 1, 2016, 0, 'BAL', 1, 1);
CALL add_player('Ketel', 'Marte', 4, 10, 3, 1, 2016, 0, 'SEA', 6, 6);
CALL add_player('Mark', 'Trumbo', 4, null, 5, 0, 2016, 0, 'BAL', 3, 3);
CALL add_player('Brad', 'Miller', 4, null, 1, 0, 2016, 0, 'TB', 6, 10);
CALL add_player('Kyle', 'Seager', 4, null, 30, 0, 2016, 0, 'SEA', 5, 1);
CALL add_player('Bryce', 'Harper', 4, null, 67, 0, 2016, 0, 'WAS', 7, 7);
CALL add_player('Adam', 'Jones', 4, null, 35, 0, 2016, 0, 'BAL', 7, 7);
CALL add_player('Hyun Soo', 'Kim', 4, null, 1, 0, 2016, 0, 'BAL', 7, 7);
CALL add_player('Justin', 'Bour', 4, null, 3, 0, 2016, 0, 'MIA', 7, 12);
CALL add_player('Craig', 'Kimbrel', 4, null, 19, 0, 2016, 0, 'BOS', 9, 1);
CALL add_player('Shelby', 'Miller', 4, null, 8, 0, 2016, 0, 'ARI', 1, 1);
CALL add_player('Jake', 'Odorizzi', 4, null, 8, 0, 2016, 0, 'TB', 1, 1);
CALL add_player('Hisashi', 'Iwakuma', 4, null, 4, 0, 2016, 0, 'SEA', 1, 1);
CALL add_player('Steve', 'Cishek', 4, null, 4, 0, 2016, 0, 'SEA', 9, 1);
CALL add_player('R.A.', 'Dickey', 4, null, 1, 0, 2016, 0, 'TOR', 1, 1);

CALL add_player('Blake', 'Swihart', 5, 5, 3, 1, 2016, 0, 'BOS', 2, 2);
CALL add_player('Josh', 'Donaldson', 5, 5, 9, 3, 2016, 0, 'TOR', 5, 5);
CALL add_player('Xander', 'Bogaerts', 5, 5, 6, 2, 2016, 0, 'BOS', 6, 6);
CALL add_player('Nolan', 'Arenado', 5, 5, 11, 2, 2016, 0, 'COL', 5, 11);
CALL add_player('Christian', 'Yelich', 5, 5, 9, 3, 2016, 0, 'MIA', 7, 7);
CALL add_player('Charlie', 'Blackmon', 5, 5, 15, 1, 2016, 0, 'COL', 7, 7);
CALL add_player('Noah', 'Syndergaard', 5, 5, 3, 1, 2016, 0, 'NYM', 1, 1);
CALL add_player('Matt', 'Wieters', 5, null, 13, 0, 2016, 0, 'BAL', 2, 2);
CALL add_player('Carlos', 'Santana', 5, null, 17, 0, 2016, 0, 'CLE', 3, 3);
CALL add_player('Robinson', 'Cano', 5, null, 30, 0, 2016, 0, 'SEA', 4, 4);
CALL add_player('Joe', 'Panik', 5, null, 1, 0, 2016, 0, 'SF', 4, 10);
CALL add_player('Andrew', 'McCutchen', 5, null, 45, 0, 2016, 0, 'PIT', 7, 7);
CALL add_player('Yoenis', 'Cespedes', 5, null, 35, 0, 2016, 0, 'NYM', 7, 7);
CALL add_player('Jackie Jr.', 'Bradley', 5, null, 4, 0, 2016, 0, 'BOS', 7, 7);
CALL add_player('Evan', 'Gattis', 5, null, 1, 0, 2016, 0, 'HOU', 8, 12);
CALL add_player('Clayton', 'Kershaw', 5, null, 50, 0, 2016, 0, 'LAD', 1, 1);
CALL add_player('Adam', 'Wainwright', 5, null, 17, 0, 2016, 0, 'STL', 1, 1);
CALL add_player('Huston', 'Street', 5, null, 8, 0, 2016, 0, 'LAA', 9, 1);
CALL add_player('James', 'Paxton', 5, null, 1, 0, 2016, 0, 'SEA', 1, 1);
CALL add_player('Rich', 'Hill', 5, null, 3, 0, 2016, 0, 'OAK', 1, 1);
CALL add_player('Homer', 'Bailey', 5, null, 3, 0, 2016, 0, 'CIN', 1, 1);
CALL add_player('Jason', 'Grilli', 5, null, 1, 0, 2016, 0, 'ATL', 9, 1);
CALL add_player('Tyler', 'Skaggs', 5, null, 1, 0, 2016, 0, 'LAA', 1, 1);

CALL add_player('Stephen', 'Vogt', 6, 6, 3, 1, 2016, 0, 'OAK', 2, 2);
CALL add_player('Mike', 'Moustakas', 6, 6, 3, 1, 2016, 0, 'KC', 5, 5);
CALL add_player('Jung Ho', 'Kang', 6, 6, 5, 1, 2016, 0, 'PIT', 5, 6);
CALL add_player('Michael', 'Brantley', 6, 6, 7, 2, 2016, 0, 'CLE', 7, 7);
CALL add_player('Lorenzo', 'Cain', 6, 6, 4, 1, 2016, 0, 'KC', 7, 7);
CALL add_player('Mark', 'Teixeira', 6, 6, 3, 1, 2016, 0, 'NYY', 3, 3);
CALL add_player('Sonny', 'Gray', 6, 6, 9, 3, 2016, 0, 'OAK', 1, 1);
CALL add_player('Matt', 'Harvey', 6, 6, 6, 2, 2016, 0, 'NYM', 1, 1);
CALL add_player('Aaron', 'Sanchez', 6, 6, 3, 1, 2016, 0, 'TOR', 9, 1);
CALL add_player('Adam', 'Ottavino', 6, 6, 3, 1, 2016, 0, 'COL', 9, 13);
CALL add_player('Curt', 'Casali,', 6, null, 1, 0, 2016, 0, 'TB', 2, 2);
CALL add_player('Jason', 'Kipnis,', 6, null, 22, 0, 2016, 0, 'CLE', 4, 4);
CALL add_player('Jedd', 'Gyorko,', 6, null, 1, 0, 2016, 0, 'STL', 4, 10);
CALL add_player('Anthony', 'Rizzo,', 6, null, 48, 0, 2016, 0, 'CHC', 3, 11);
CALL add_player('Hanley', 'Ramirez,', 6, null, 17, 0, 2016, 0, 'BOS', 3, 7);
CALL add_player('Randal', 'Grichuk,', 6, null, 5, 0, 2016, 0, 'STL', 7, 7);
CALL add_player('Gerardo', 'Parra,', 6, null, 1, 0, 2016, 0, 'COL', 7, 7);
CALL add_player('Byung Ho', 'Park,', 6, null, 20, 0, 2016, 0, 'MIN', 3, 12);
CALL add_player('Madison', 'Bumgarner,', 6, null, 37, 0, 2016, 0, 'SF', 1, 1);
CALL add_player('Yordano', 'Ventura,', 6, null, 13, 0, 2016, 0, 'KC', 1, 1);
CALL add_player('Francisco', 'Liriano,', 6, null, 14, 0, 2016, 0, 'PIT', 1, 1);
CALL add_player('Drew', 'Smyly,', 6, null, 10, 0, 2016, 0, 'TB', 1, 1);
CALL add_player('Glen', 'Perkins,', 6, null, 7, 0, 2016, 0, 'MIN', 9, 1);
CALL add_player('Santiago', 'Casilla,', 6, null, 3, 0, 2016, 0, 'SF', 9, 1);

CALL add_player('Pablo', 'Sandoval', 7, 7, 19, 1, 2016, 0, 'BOS', 5, 5);
CALL add_player('Adrian', 'Gonzalez', 7, 7, 28, 1, 2016, 0, 'LAD', 3, 3);
CALL add_player('Matt', 'Kemp', 7, 7, 26, 2, 2016, 0, 'SD', 7, 7);
CALL add_player('Melky', 'Cabrera', 7, 7, 6, 2, 2016, 0, 'CHW', 7, 7);
CALL add_player('Jacoby', 'Ellsbury', 7, 7, 36, 3, 2016, 0, 'NYY', 7, 7);
CALL add_player('Dustin', 'Pedroia', 7, 7, 23, 1, 2016, 0, 'BOS', 4, 4);
CALL add_player('Justin', 'Verlander', 7, 7, 9, 1, 2016, 0, 'DET', 1, 1);
CALL add_player('Trevor', 'Rosenthal', 7, 7, 14, 1, 2016, 0, 'STL', 9, 1);
CALL add_player('Yan', 'Gomes', 7, null, 7, 0, 2016, 0, 'CLE', 2, 2);
CALL add_player('A.J.', 'Pierzynski', 7, null, 2, 0, 2016, 0, 'ATL', 2, 2);
CALL add_player('Alexei', 'Ramirez', 7, null, 1, 0, 2016, 0, 'SD', 6, 6);
CALL add_player('Brett', 'Lawrie', 7, null, 3, 0, 2016, 0, 'CWS', 5, 10);
CALL add_player('Chris', 'Carter', 7, null, 1, 0, 2016, 0, 'MIL', 3, 11);
CALL add_player('Khris', 'Davis', 7, null, 11, 0, 2016, 0, 'OAK', 7, 7);
CALL add_player('Brett', 'Gardner', 7, null, 7, 0, 2016, 0, 'NYY', 7, 7);
CALL add_player('Kole', 'Calhoun', 7, null, 10, 0, 2016, 0, 'LAA', 7, 12);
CALL add_player('Jordan', 'Zimmermann', 7, null, 17, 0, 2016, 0, 'DET', 1, 1);
CALL add_player('Zach', 'Britton', 7, null, 12, 0, 2016, 0, 'BAL', 9, 1);
CALL add_player('Cody', 'Allen', 7, null, 10, 0, 2016, 0, 'CLE', 9, 1);
CALL add_player('Masahiro', 'Tanaka', 7, null, 15, 0, 2016, 0, 'NYY', 1, 1);
CALL add_player('John', 'Lackey', 7, null, 5, 0, 2016, 0, 'CHC', 1, 1);
CALL add_player('Clay', 'Buchholz', 7, null, 1, 0, 2016, 0, 'BOS', 1, 1);
CALL add_player('J.J.', 'Hoover', 7, null, 1, 0, 2016, 0, 'CIN', 9, 1);

CALL add_player('Welington', 'Castillo', 8, 8, 3, 1, 2016, 0, 'CHC', 2, 2);
CALL add_player('Maikel', 'Franco', 8, 8, 3, 1, 2016, 0, 'PHI', 5, 5);
CALL add_player('Addison', 'Russell', 8, 8, 3, 1, 2016, 0, 'CHC', 6, 4);
CALL add_player('Carlos', 'Correa', 8, 8, 3, 1, 2016, 0, 'HOU', 6, 6);
CALL add_player('Eric', 'Hosmer', 8, 8, 10, 1, 2016, 0, 'KC', 3, 3);
CALL add_player('Jorge', 'Soler', 8, 8, 3, 1, 2016, 0, 'CHC', 7, 7);
CALL add_player('Yasiel', 'Puig', 8, 8, 9, 3, 2016, 0, 'LAD', 7, 7);
CALL add_player('Tyson', 'Ross', 8, 8, 7, 2, 2016, 0, 'SD', 1, 1);
CALL add_player('Gerrit', 'Cole', 8, 8, 9, 3, 2016, 0, 'PIT', 1, 1);
CALL add_player('Jose', 'Fernandez', 8, 8, 9, 3, 2016, 0, 'MIA', 1, 1);
CALL add_player('Derek', 'Norris', 8, null, 9, 0, 2016, 0, 'SD', 2, 2);
CALL add_player('Josh', 'Harrison', 8, null, 4, 0, 2016, 0, 'PIT', 5, 10);
CALL add_player('Edwin', 'Encarnacion', 8, null, 40, 0, 2016, 0, 'TOR', 3, 12);
CALL add_player('Carlos', 'Gomez', 8, null, 32, 0, 2016, 0, 'HOU', 7, 7);
CALL add_player('Carlos', 'Gonzalez', 8, null, 29, 0, 2016, 0, 'COL', 7, 7);
CALL add_player('Shin-Soo', 'Choo', 8, null, 11, 0, 2016, 0, 'TEX', 7, 7);
CALL add_player('Matt', 'Duffy', 8, null, 10, 0, 2016, 0, 'SF', 5, 11);
CALL add_player('Dellin', 'Betances', 8, null, 2, 0, 2016, 0, 'NYY', 9, 1);
CALL add_player('David', 'Price', 8, null, 35, 0, 2016, 0, 'BOS', 1, 1);
CALL add_player('Jose', 'Quintana', 8, null, 11, 0, 2016, 0, 'CWS', 1, 1);
CALL add_player('Hector', 'Rondon', 8, null, 10, 0, 2016, 0, 'CHC', 9, 1);
CALL add_player('Brad', 'Boxberger', 8, null, 7, 0, 2016, 0, 'TB', 9, 1);
CALL add_player('Alex', 'Wood', 8, null, 1, 0, 2016, 0, 'LAD', 1, 1);

CALL add_player('Travis', 'd\'Arnaud', 9, 9, 6, 2, 2016, 0, 'NYM', 2, 2);
CALL add_player('Lucas', 'Duda', 9, 9, 6, 2, 2016, 0, 'NYM', 3, 3);
CALL add_player('Todd', 'Frazier', 9, 9, 9, 2, 2016, 0, 'CHW', 5, 11);
CALL add_player('A.J.', 'Pollock', 9, 9, 13, 1, 2016, 0, 'ARI', 7, 7);
CALL add_player('Joc', 'Pederson', 9, 9, 3, 1, 2016, 0, 'LAD', 7, 7);
CALL add_player('Kris', 'Bryant', 9, 9, 3, 1, 2016, 0, 'CHC', 5, 5);
CALL add_player('Chris', 'Archer', 9, 9, 9, 3, 2016, 0, 'TB', 1, 1);
CALL add_player('Yadier', 'Molina', 9, null, 2, 0, 2016, 0, 'STL', 2, 2);
CALL add_player('Neil', 'Walker', 9, null, 5, 0, 2016, 0, 'NYM', 4, 4);
CALL add_player('Starlin', 'Castro', 9, null, 4, 0, 2016, 0, 'NYY', 4, 6);
CALL add_player('Erick', 'Aybar', 9, null, 1, 0, 2016, 0, 'LAA', 6, 10);
CALL add_player('Giancarlo', 'Stanton', 9, null, 46, 0, 2016, 0, 'MIA', 7, 7);
CALL add_player('Jose', 'Bautista', 9, null, 43, 0, 2016, 0, 'TOR', 7, 7);
CALL add_player('Curtis', 'Granderson', 9, null, 10, 0, 2016, 0, 'NYM', 7, 7);
CALL add_player('Evan', 'Longoria', 9, null, 10, 0, 2016, 0, 'TB', 5, 12);
CALL add_player('Max', 'Scherzer', 9, null, 39, 0, 2016, 0, 'WAS', 1, 1);
CALL add_player('Stephen', 'Strasburg', 9, null, 33, 0, 2016, 0, 'WAS', 1, 1);
CALL add_player('Scott', 'Kazmir', 9, null, 4, 0, 2016, 0, 'LAD', 1, 1);
CALL add_player('Mike', 'Fiers', 9, null, 2, 0, 2016, 0, 'HOU', 1, 1);
CALL add_player('Collin', 'McHugh', 9, null, 4, 0, 2016, 0, 'HOU', 1, 1);
CALL add_player('Hyun Jin', 'Ryu', 9, null, 2, 0, 2016, 0, 'LAD', 1, 1);
CALL add_player('Jason', 'Hammel', 9, null, 2, 0, 2016, 0, 'CHC', 1, 1);
CALL add_player('Francisco', 'Rodriguez', 9, null, 7, 0, 2016, 0, 'DET', 9, 1);

CALL add_player('Miguel', 'Sano', 10, 10, 3, 1, 2016, 0, 'MIN', 5, 12);
CALL add_player('Dee', 'Gordon', 10, 10, 8, 2, 2016, 0, 'MIA', 4, 4);
CALL add_player('George', 'Springer', 10, 10, 6, 2, 2016, 0, 'HOU', 7, 7);
CALL add_player('Delino', 'Deshields', 10, 10, 3, 1, 2016, 0, 'TEX', 7, 7);
CALL add_player('Mookie', 'Betts', 10, 10, 6, 2, 2016, 0, 'BOS', 7, 7);
CALL add_player('Jaime', 'Garcia', 10, 10, 3, 1, 2016, 0, 'STL', 1, 1);
CALL add_player('Corey', 'Kluber', 10, 10, 12, 2, 2016, 0, 'CLE', 1, 1);
CALL add_player('Carlos', 'Carrasco', 10, 10, 6, 2, 2016, 0, 'CLE', 1, 1);
CALL add_player('Buster', 'Posey', 10, null, 41, 0, 2016, 0, 'SF', 2, 2);
CALL add_player('Miguel', 'Montero', 10, null, 1, 0, 2016, 0, 'CHC', 2, 2);
CALL add_player('Paul', 'Goldschmidt', 10, null, 56, 0, 2016, 0, 'ARI', 3, 3);
CALL add_player('Trevor', 'Plouffe', 10, null, 1, 0, 2016, 0, 'MIN', 5, 5);
CALL add_player('Marcus', 'Semien', 10, null, 4, 0, 2016, 0, 'OAK', 6, 6);
CALL add_player('Howie', 'Kendrick', 10, null, 1, 0, 2016, 0, 'LAD', 4, 10);
CALL add_player('Chris', 'Davis', 10, null, 38, 0, 2016, 0, 'BAL', 3, 11);
CALL add_player('Domingo', 'Santana', 10, null, 1, 0, 2016, 0, 'MIL', 7, 7);
CALL add_player('Jay', 'Bruce', 10, null, 7, 0, 2016, 0, 'CIN', 7, 7);
CALL add_player('David', 'Robertson', 10, null, 9, 0, 2016, 0, 'CWS', 9, 1);
CALL add_player('Johnny', 'Cueto', 10, null, 28, 0, 2016, 0, 'SF', 1, 1);
CALL add_player('Drew', 'Storen', 10, null, 1, 0, 2016, 0, 'WAS', 9, 1);
CALL add_player('Wei-Yin', 'Chen', 10, null, 13, 0, 2016, 0, 'MIA', 1, 1);
CALL add_player('Sean', 'Doolittle', 10, null, 1, 0, 2016, 0, 'OAK', 9, 1);
CALL add_player('Anibal', 'Sanchez', 10, null, 1, 0, 2016, 0, 'DET', 1, 1);

CALL add_player('J.T.', 'Realmuto', 11, 11, 3, 1, 2016, 0, 'MIA', 2, 2);
CALL add_player('Nelson', 'Cruz', 11, 11, 20, 2, 2016, 0, 'SEA', 7, 7);
CALL add_player('Jose', 'Abreu', 11, 11, 34, 2, 2016, 0, 'CHW', 3, 3);
CALL add_player('Starling', 'Marte', 11, 11, 16, 3, 2016, 0, 'PIT', 7, 7);
CALL add_player('David', 'Ortiz', 11, 11, 22, 1, 2016, 0, 'BOS', 8, 12);
CALL add_player('Jake', 'Arrieta', 11, 11, 6, 2, 2016, 0, 'CHC', 1, 1);
CALL add_player('Patrick', 'Corbin', 11, 11, 4, 1, 2016, 0, 'ARI', 1, 1);
CALL add_player('A.J.', 'Ramos', 11, 11, 3, 1, 2016, 0, 'MIA', 9, 1);
CALL add_player('J.D.', 'Martinez', 11, 11, 6, 2, 2016, 0, 'DET', 7, 7);
CALL add_player('Yu', 'Darvish', 11, 11, 6, 1, 2016, 0, 'TEX', 1, 13);
CALL add_player('Taijuan', 'Walker', 11, 10, 3, 1, 2016, 0, 'SEA', 1, 1);
CALL add_player('Salvador', 'Perez', 11, null, 18, 0, 2016, 0, 'KC', 2, 2);
CALL add_player('Ian', 'Kinsler', 11, null, 7, 0, 2016, 0, 'DET', 4, 4);
CALL add_player('Manny', 'Machado', 11, null, 46, 0, 2016, 0, 'BAL', 5, 5);
CALL add_player('Alcides', 'Escobar', 11, null, 1, 0, 2016, 0, 'KC', 6, 6);
CALL add_player('Elvis', 'Andrus', 11, null, 7, 0, 2016, 0, 'TEX', 6, 10);
CALL add_player('Miguel', 'Cabrera', 11, null, 39, 0, 2016, 0, 'DET', 3, 11);
CALL add_player('Ryan', 'Braun', 11, null, 23, 0, 2016, 0, 'MIL', 7, 7);
CALL add_player('Ben', 'Revere', 11, null, 8, 0, 2016, 0, 'WAS', 7, 7);
CALL add_player('Chris', 'Sale', 11, null, 45, 0, 2016, 0, 'CWS', 1, 1);
CALL add_player('Aroldis', 'Chapman', 11, null, 12, 0, 2016, 0, 'NYY', 9, 1);
CALL add_player('Michael', 'Pineda', 11, null, 16, 0, 2016, 0, 'NYY', 1, 1);
CALL add_player('Kyle', 'Hendricks', 11, null, 1, 0, 2016, 0, 'CHC', 1, 1);
CALL add_player('Ian', 'Kennedy', 11, null, 1, 0, 2016, 0, 'KC', 1, 1);

CALL add_player('Brian', 'Dozier', 12, 12, 16, 2, 2016, 0, 'MIN', 4, 4);
CALL add_player('Brandon', 'Crawford', 12, 12, 3, 1, 2016, 0, 'SF', 6, 6);
CALL add_player('DJ', 'LeMahieu', 12, 12, 3, 1, 2016, 0, 'COL', 4, 10);
CALL add_player('Adam', 'Eaton', 12, 12, 3, 1, 2016, 0, 'CWS', 7, 7);
CALL add_player('Dallas', 'Keuchel', 12, 12, 6, 1, 2016, 0, 'HOU', 1, 1);
CALL add_player('Shawn', 'Tolleson', 12, 12, 3, 1, 2016, 0, 'TEX', 9, 1);
CALL add_player('Raisel', 'Iglesias', 12, 12, 3, 1, 2016, 0, 'CIN', 1, 1);
CALL add_player('Andrew', 'Heaney', 12, 12, 3, 1, 2016, 0, 'LAA', 1, 1);
CALL add_player('Kyle', 'Schwarber', 12, 12, 3, 1, 2016, 0, 'CHC', 2, 2);
CALL add_player('Garret', 'Richards', 12, 12, 6, 2, 2016, 0, 'LAA', 1, 1);
CALL add_player('James', 'McCann', 12, null, 1, 0, 2016, 0, 'DET', 2, 2);
CALL add_player('Logan', 'Forsythe', 12, null, 1, 0, 2016, 0, 'TB', 4, 3);
CALL add_player('Matt', 'Carpenter', 12, null, 27, 0, 2016, 0, 'STL', 5, 5);
CALL add_player('Martin', 'Prado', 12, null, 1, 0, 2016, 0, 'MIA', 5, 11);
CALL add_player('Hunter', 'Pence', 12, null, 11, 0, 2016, 0, 'SF', 7, 7);
CALL add_player('David', 'Peralta', 12, null, 12, 0, 2016, 0, 'ARI', 7, 7);
CALL add_player('Kevin', 'Kiermaier', 12, null, 1, 0, 2016, 0, 'TB', 7, 7);
CALL add_player('Ender', 'Inciarte', 12, null, 1, 0, 2016, 0, 'ARI', 7, 7);
CALL add_player('Prince', 'Fielder', 12, null, 18, 0, 2016, 0, 'TEX', 8, 12);
CALL add_player('Jeff', 'Samardzija', 12, null, 21, 0, 2016, 0, 'SF', 1, 1);
CALL add_player('Cole', 'Hamels', 12, null, 25, 0, 2016, 0, 'TEX', 1, 1);
CALL add_player('Brad', 'Ziegler', 12, null, 1, 0, 2016, 0, 'ARI', 9, 1);
CALL add_player('Lance', 'Lynn', 12, null, 1, 0, 2016, 0, 'STL', 1, 1);