
-- name: CreateUserPermission :exec
INSERT INTO users_permissions (user_id, resource_id, permission_id) VALUES ($1, $2, $3);

-- name: UpdateUserPermission :exec
UPDATE users_permissions
SET
    user_id = COALESCE($2, user_id),
    resource_id = COALESCE($3, resource_id),
    permission_id = COALESCE($4, permission_id)
WHERE id = $1
  AND (COALESCE($2, user_id) != user_id
         OR COALESCE($3, resource_id) != resource_id
         OR COALESCE($4, permission_id) != permission_id);

-- name: GetUserPermissionsByUserID :many
SELECT * FROM users_permissions WHERE user_id = $1;

-- name: DeleteUserPermission :exec
DELETE FROM users_permissions WHERE user_id = $1 AND resource_id = $2 AND permission_id = $3;
