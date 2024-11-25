// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.27.0
// source: users_roles.sql

package db

import (
	"context"
)

const createUserRole = `-- name: CreateUserRole :exec
INSERT INTO users_roles (user_id, role_id) VALUES ($1, $2)
`

func (q *Queries) CreateUserRole(ctx context.Context) error {
	_, err := q.db.ExecContext(ctx, createUserRole)
	return err
}

const deleteUserRole = `-- name: DeleteUserRole :exec
DELETE FROM users_roles WHERE user_id = $1 AND role_id = $2
`

func (q *Queries) DeleteUserRole(ctx context.Context) error {
	_, err := q.db.ExecContext(ctx, deleteUserRole)
	return err
}

const getUserRolesByUserID = `-- name: GetUserRolesByUserID :many
SELECT id, user_id, role_id FROM users_roles WHERE user_id = $1
`

func (q *Queries) GetUserRolesByUserID(ctx context.Context) ([]UsersRole, error) {
	rows, err := q.db.QueryContext(ctx, getUserRolesByUserID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []UsersRole
	for rows.Next() {
		var i UsersRole
		if err := rows.Scan(&i.ID, &i.UserID, &i.RoleID); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Close(); err != nil {
		return nil, err
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}

const updateUserRole = `-- name: UpdateUserRole :exec
UPDATE users_roles
SET
    user_id = COALESCE($2, user_id),
    role_id = COALESCE($3, role_id)
WHERE id = $1
  AND (COALESCE($2, user_id) != user_id
         OR COALESCE($3, role_id) != role_id)
`

func (q *Queries) UpdateUserRole(ctx context.Context) error {
	_, err := q.db.ExecContext(ctx, updateUserRole)
	return err
}