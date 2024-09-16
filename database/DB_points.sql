CREATE TABLE `points` (
	`id` int(10) NOT NULL,
	`edges_id` int(10) NOT NULL,
	`x` float NOT NULL,
	`y` float NOT NULL,
	PRIMARY KEY (`id`,`edges_id`),
	CONSTRAINT `points_figure_id` FOREIGN KEY (`edges_id`) REFERENCES `edges` (`id`) ON DELETE CASCADE
);