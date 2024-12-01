
-- name: CreateUserGroup :exec
INSERT INTO users_groups (user_id, group_id) VALUES (?, ?);

-- name: UpdateUserGroup :exec
UPDATE users_groups
SET
    user_id = COALESCE(?, user_id),
    group_id = COALESCE(?, group_id)
WHERE id = ?
  AND (COALESCE(?, user_id) != user_id
         OR COALESCE(?, group_id) != group_id);

-- name: GetUserGroupsByUserID :many
SELECT * FROM users_groups WHERE user_id = ?;

-- name: DeleteUserGroup :exec
DELETE FROM users_groups WHERE user_id = ? AND group_id = ?;
