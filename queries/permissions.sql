
-- name: CreatePermission :exec
INSERT INTO permissions (id, name, code) VALUES (?, ?, ?);

-- name: GetPermissionByID :one
SELECT * FROM permissions WHERE id = ?;

-- name: UpdatePermission :exec
UPDATE permissions
SET
    name = COALESCE(?, name),
    code = COALESCE(?, code)
WHERE id = ?
  AND (COALESCE(?, name) != name
         OR COALESCE(?, code) != code);

-- name: DeletePermission :exec
DELETE FROM permissions WHERE id = ?;
