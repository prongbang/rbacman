
-- name: CreateGroup :exec
INSERT INTO `groups` (id, name) VALUES (?, ?);

-- name: GetGroupByID :one
SELECT * FROM `groups` WHERE id = ?;

-- name: UpdateGroup :exec
UPDATE `groups`
SET
    name = COALESCE(?, name)
WHERE id = ?
  AND COALESCE(?, name) != name;

-- name: DeleteGroup :exec
DELETE FROM `groups` WHERE id = ?;
