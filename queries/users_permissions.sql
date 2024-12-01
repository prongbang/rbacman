
-- name: CreateUserPermission :exec
INSERT INTO users_permissions (user_id, resource_id, permission_id) VALUES (?, ?, ?);

-- name: UpdateUserPermission :exec
UPDATE users_permissions
SET
    user_id = COALESCE(?, user_id),
    resource_id = COALESCE(?, resource_id),
    permission_id = COALESCE(?, permission_id)
WHERE id = ?
  AND (COALESCE(?, user_id) != user_id
         OR COALESCE(?, resource_id) != resource_id
         OR COALESCE(?, permission_id) != permission_id);

-- name: GetUserPermissionsByUserID :many
SELECT * FROM users_permissions WHERE user_id = ?;

-- name: DeleteUserPermission :exec
DELETE FROM users_permissions WHERE user_id = ? AND resource_id = ? AND permission_id = ?;

-- name: CheckPermissionsHighLevelByUserID :one
SELECT COUNT(u.id) AS total
FROM users u
INNER JOIN users_roles ur ON ur.user_id = u.id
INNER JOIN roles r ON r.id = ur.role_id AND r.level = 1
WHERE u.id = ?;

-- name: CheckPermissionsUserLevelByUserID :one
SELECT COUNT(p.id) AS total
FROM users u
INNER JOIN users_groups ug ON ug.user_id = u.id
INNER JOIN `groups` g ON g.id = ug.group_id
INNER JOIN groups_permissions gp ON gp.group_id = ug.group_id
INNER JOIN permissions p ON p.id = gp.permission_id
INNER JOIN resources r ON r.id = gp.resource_id
WHERE u.id = ? AND UPPER(CONCAT(r.code, '_', p.code)) = ?;