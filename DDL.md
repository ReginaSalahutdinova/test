CREATE TABLE `figures` (
	`id` int(10) NOT NULL AUTO_INCREMENT,
	`color` varchar (10) NOT NULL DEFAULT '#FFFFFF',
	`layer` int(100) NOT NULL DEFAULT 0,
	PRIMARY KEY (`id`)
)

CREATE TABLE `edges` (
	`id` int(10) NOT NULL AUTO_INCREMENT,
	`figure_id` int(10) NOT NULL,
	`point_one_id` int(10) NOT NULL,
	`point_two_id` int(10) NOT NULL,
	PRIMARY KEY (`id`),
	CONSTRAINT `edges_figure_id` FOREIGN KEY (`figure_id`) REFERENCES `figures` (`id`) ON DELETE CASCADE
)

CREATE TABLE `points` (
	`id` int(10) NOT NULLT,
	`edges_id` int(10) NOT NULL,
	`x` float NOT NULL,
	`y` float NOT NULL,
	PRIMARY KEY (`id`,`edges_id`),
	CONSTRAINT `points_figure_id` FOREIGN KEY (`edges_id`) REFERENCES `edges` (`point_one_id`, `point_two_id`) ON DELETE CASCADE
)