-- name: CreateUserOrganization :exec
INSERT INTO `users_organizations` (user_id, organization_id)
VALUES (?, ?);

-- name: GetUserOrganizationsByUserID :many
SELECT * FROM `users_organizations` WHERE user_id = ?;

-- name: UpdateUserOrganization :exec
UPDATE users_organizations
SET
    user_id = COALESCE(?, user_id),
    organization_id = COALESCE(?, organization_id)
WHERE id = ?
  AND (COALESCE(?, user_id) != user_id
         OR COALESCE(?, organization_id) != organization_id);

-- name: DeleteUserOrganization :exec
DELETE FROM `users_organizations` WHERE user_id = ? AND organization_id = ?;