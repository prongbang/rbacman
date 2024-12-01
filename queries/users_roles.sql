
-- name: CreateUserRole :exec
INSERT INTO users_roles (user_id, role_id) VALUES (?, ?);

-- name: UpdateUserRole :exec
UPDATE users_roles
SET
    user_id = COALESCE(?, user_id),
    role_id = COALESCE(?, role_id)
WHERE id = ?
  AND (COALESCE(?, user_id) != user_id
         OR COALESCE(?, role_id) != role_id);

-- name: GetUserRolesByUserID :many
SELECT * FROM users_roles WHERE user_id = ?;

-- name: DeleteUserRole :exec
DELETE FROM users_roles WHERE user_id = ? AND role_id = ?;
