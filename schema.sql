CREATE TABLE `audit_logs`
(
    `id`        varchar(100) NOT NULL DEFAULT uuid(),
    `user_id`   varchar(100) NOT NULL,
    `action`    varchar(50)  NOT NULL,
    `resource`  varchar(100) NOT NULL,
    `timestamp` timestamp    NOT NULL DEFAULT current_timestamp(),
    PRIMARY KEY (`id`),
    KEY `user_id` (`user_id`),
    CONSTRAINT `audit_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci;

CREATE TABLE `groups`
(
    `id`   varchar(100) NOT NULL DEFAULT uuid(),
    `name` varchar(50)           DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci;

CREATE TABLE `groups_permissions`
(
    `id`            int(11) NOT NULL AUTO_INCREMENT,
    `group_id`      varchar(100) DEFAULT NULL,
    `resource_id`   int(11)      DEFAULT NULL,
    `permission_id` int(11)      DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `resource_id` (`resource_id`) USING BTREE,
    UNIQUE KEY `permission_id` (`permission_id`) USING BTREE,
    UNIQUE KEY `group_id` (`group_id`) USING BTREE,
    CONSTRAINT `groups_permissions_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`),
    CONSTRAINT `groups_permissions_ibfk_2` FOREIGN KEY (`resource_id`) REFERENCES `resources` (`id`),
    CONSTRAINT `groups_permissions_ibfk_3` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci;

CREATE TABLE `organizations`
(
    `id`        int(11) NOT NULL AUTO_INCREMENT,
    `name`      varchar(50) DEFAULT NULL,
    `parent_id` int(11)     DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `parent_id` (`parent_id`) USING BTREE,
    CONSTRAINT `organizations_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `organizations` (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci;

CREATE TABLE `permissions`
(
    `id`   int(11) NOT NULL AUTO_INCREMENT,
    `name` varchar(50)  DEFAULT NULL,
    `code` varchar(100) DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci;

CREATE TABLE `resources`
(
    `id`   int(11) NOT NULL AUTO_INCREMENT,
    `name` varchar(50)  DEFAULT NULL,
    `code` varchar(100) DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci;

CREATE TABLE `roles`
(
    `id`    varchar(100) NOT NULL DEFAULT uuid(),
    `name`  varchar(50)           DEFAULT NULL,
    `level` int(1)                DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci;

CREATE TABLE `users`
(
    `id`         varchar(100) NOT NULL DEFAULT uuid(),
    `first_name` varchar(50)           DEFAULT '',
    `last_name`  varchar(50)           DEFAULT '',
    `username`   varchar(50)           DEFAULT '',
    `email`      varchar(50)           DEFAULT '',
    `password`   varchar(255)          DEFAULT '',
    `avatar`     varchar(255)          DEFAULT '',
    `created_at` timestamp    NULL     DEFAULT current_timestamp(),
    `updated_at` timestamp    NULL     DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    `active`     tinyint(4)            DEFAULT 1,
    `flag`       int(1)                DEFAULT 1,
    PRIMARY KEY (`id`),
    UNIQUE KEY `username_idx` (`username`) USING BTREE,
    UNIQUE KEY `email_idx` (`email`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci;

CREATE TABLE `users_groups`
(
    `id`       int(11) NOT NULL AUTO_INCREMENT,
    `user_id`  varchar(100) DEFAULT NULL,
    `group_id` varchar(100) DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `user_id` (`user_id`) USING BTREE,
    KEY `group_id` (`group_id`) USING BTREE,
    CONSTRAINT `users_groups_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
    CONSTRAINT `users_groups_ibfk_2` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci;

CREATE TABLE `users_organizations`
(
    `id`              int(11) NOT NULL AUTO_INCREMENT,
    `user_id`         varchar(100) DEFAULT NULL,
    `organization_id` int(11)      DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `organization_id` (`organization_id`),
    KEY `user_id` (`user_id`) USING BTREE,
    CONSTRAINT `users_organizations_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
    CONSTRAINT `users_organizations_ibfk_2` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci;

CREATE TABLE `users_permissions`
(
    `id`            int(11)      NOT NULL AUTO_INCREMENT,
    `user_id`       varchar(100) NOT NULL,
    `resource_id`   int(11)      NOT NULL,
    `permission_id` int(11)      NOT NULL,
    PRIMARY KEY (`id`),
    KEY `user_id` (`user_id`),
    KEY `resource_id` (`resource_id`),
    KEY `permission_id` (`permission_id`),
    CONSTRAINT `users_permissions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
    CONSTRAINT `users_permissions_ibfk_2` FOREIGN KEY (`resource_id`) REFERENCES `resources` (`id`),
    CONSTRAINT `users_permissions_ibfk_3` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci;

CREATE TABLE `users_roles`
(
    `id`      int(11) NOT NULL AUTO_INCREMENT,
    `user_id` varchar(100) DEFAULT NULL,
    `role_id` varchar(100) DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `user_id` (`user_id`) USING BTREE,
    KEY `role_id` (`role_id`) USING BTREE,
    CONSTRAINT `users_roles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
    CONSTRAINT `users_roles_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 6
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci;
