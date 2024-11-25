
-- name: CreateUserGroup :exec
INSERT INTO users_groups (user_id, group_id) VALUES ($1, $2);

-- name: UpdateUserGroup :exec
UPDATE users_groups
SET
    user_id = COALESCE($2, user_id),
    group_id = COALESCE($3, group_id)
WHERE id = $1
  AND (COALESCE($2, user_id) != user_id
         OR COALESCE($3, group_id) != group_id);

-- name: GetUserGroupsByUserID :many
SELECT * FROM users_groups WHERE user_id = $1;

-- name: DeleteUserGroup :exec
DELETE FROM users_groups WHERE user_id = $1 AND group_id = $2;
