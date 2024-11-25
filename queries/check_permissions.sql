-- name: CheckUserPermission :one
SELECT COUNT(*) FROM users_permissions
WHERE user_id = $1 AND resource_id = $2 AND permission_id = $3
LIMIT 1;