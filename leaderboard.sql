CREATE TABLE `leaderboard` (
	`identifier` VARCHAR(46) NULL DEFAULT NULL COLLATE 'utf8_general_ci',
	`name` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_general_ci',
	`kills` INT(11) NULL DEFAULT NULL,
	`deaths` INT(11) NULL DEFAULT NULL,
	`kd` FLOAT NULL DEFAULT NULL
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;
