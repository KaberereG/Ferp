-- database: ferp

CREATE TABLE `items`(
    `id` VARCHAR(16) NOT NULL,
    `name` VARCHAR(64) NOT NULL,
    `description` VARCHAR(256) NOT NULL,
    PRIMARY KEY(`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci

CREATE TABLE `properties`(
    `id` VARCHAR(16) NOT NULL,
    `title` VARCHAR(32) NOT NULL,
    `type` ENUM('integer', 'decimal', 'text', '') NOT NULL,
    PRIMARY KEY(`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci

CREATE TABLE `items_properties`(
    `id_item` VARCHAR(16) NOT NULL,
    `id_property` VARCHAR(16) NOT NULL,
    `value_int` INT NOT NULL,
    `value_decimal` DOUBLE NOT NULL,
    `value_text` VARCHAR(64) NOT NULL,
    PRIMARY KEY(`id_item`, `id_property`),
    KEY `properties_items_properties`(`id_property`),
    CONSTRAINT `items_items_properties` FOREIGN KEY(`id_item`) REFERENCES `items`(`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `properties_items_properties` FOREIGN KEY(`id_property`) REFERENCES `properties`(`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci