
-- name: CreatePermission :exec
INSERT INTO permissions (id, name, code) VALUES ($1, $2, $3);

-- name: GetPermissionByID :one
SELECT * FROM permissions WHERE id = $1;

-- name: UpdatePermission :exec
UPDATE permissions
SET
    name = COALESCE($2, name),
    code = COALESCE($3, code)
WHERE id = $1
  AND (COALESCE($2, name) != name
         OR COALESCE($3, code) != code);

-- name: DeletePermission :exec
DELETE FROM permissions WHERE id = $1;
