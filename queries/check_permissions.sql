-- name: CheckUserPermission :one
SELECT COUNT(*) FROM users_permissions
WHERE user_id = ? AND resource_id = ? AND permission_id = ?
LIMIT 1;