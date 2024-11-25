-- name: CreateUserOrganization :exec
INSERT INTO `users_organizations` (user_id, organization_id)
VALUES ($1, $2);

-- name: GetUserOrganizationsByUserID :many
SELECT * FROM `users_organizations` WHERE user_id = $1;

-- name: UpdateUserOrganization :exec
UPDATE users_organizations
SET
    user_id = COALESCE($2, user_id),
    organization_id = COALESCE($3, organization_id)
WHERE id = $1
  AND (COALESCE($2, user_id) != user_id
         OR COALESCE($3, organization_id) != organization_id);

-- name: DeleteUserOrganization :exec
DELETE FROM `users_organizations` WHERE user_id = $1 AND organization_id = $2;