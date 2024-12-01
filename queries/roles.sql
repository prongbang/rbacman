
-- name: CreateRole :exec
INSERT INTO roles (id, name) VALUES (?, ?);

-- name: GetRoleByID :one
SELECT * FROM roles WHERE id = ?;

-- name: UpdateRole :exec
UPDATE roles
SET
    name = COALESCE(?, name),
    level = COALESCE(?, level)
WHERE id = ?
  AND (COALESCE(?, name) != name
         OR COALESCE(?, level) != level);

-- name: DeleteRole :exec
DELETE FROM roles WHERE id = ?;
