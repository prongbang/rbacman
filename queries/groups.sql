
-- name: CreateGroup :exec
INSERT INTO `groups` (id, name) VALUES ($1, $2);

-- name: GetGroupByID :one
SELECT * FROM `groups` WHERE id = $1;

-- name: UpdateGroup :exec
UPDATE `groups`
SET
    name = COALESCE($2, name)
WHERE id = $1
  AND COALESCE($2, name) != name;

-- name: DeleteGroup :exec
DELETE FROM `groups` WHERE id = $1;
