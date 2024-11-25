
-- name: CreateRole :exec
INSERT INTO roles (id, name) VALUES ($1, $2);

-- name: GetRoleByID :one
SELECT * FROM roles WHERE id = $1;

-- name: UpdateRole :exec
UPDATE roles
SET
    name = COALESCE($2, name),
    level = COALESCE($3, level)
WHERE id = $1
  AND (COALESCE($2, name) != name
         OR COALESCE($3, level) != level);

-- name: DeleteRole :exec
DELETE FROM roles WHERE id = $1;
