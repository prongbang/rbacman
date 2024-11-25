
-- name: CreateUserRole :exec
INSERT INTO users_roles (user_id, role_id) VALUES ($1, $2);

-- name: UpdateUserRole :exec
UPDATE users_roles
SET
    user_id = COALESCE($2, user_id),
    role_id = COALESCE($3, role_id)
WHERE id = $1
  AND (COALESCE($2, user_id) != user_id
         OR COALESCE($3, role_id) != role_id);

-- name: GetUserRolesByUserID :many
SELECT * FROM users_roles WHERE user_id = $1;

-- name: DeleteUserRole :exec
DELETE FROM users_roles WHERE user_id = $1 AND role_id = $2;
