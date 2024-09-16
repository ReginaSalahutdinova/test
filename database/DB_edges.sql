CREATE TABLE `edges` (
	`id` int(10) NOT NULL AUTO_INCREMENT,
	`figure_id` int(10) NOT NULL,
	`point_one_id` int(10) NOT NULL,
	`point_two_id` int(10) NOT NULL,
	PRIMARY KEY (`id`),
	CONSTRAINT `edges_figure_id` FOREIGN KEY (`figure_id`) REFERENCES `figures` (`id`) ON DELETE CASCADE
);