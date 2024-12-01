// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.27.0
// source: users_roles.sql

package db

import (
	"context"
	"database/sql"
)

const createUserRole = `-- name: CreateUserRole :exec
INSERT INTO users_roles (user_id, role_id) VALUES (?, ?)
`

type CreateUserRoleParams struct {
	UserID sql.NullString
	RoleID sql.NullString
}

func (q *Queries) CreateUserRole(ctx context.Context, arg CreateUserRoleParams) error {
	_, err := q.db.ExecContext(ctx, createUserRole, arg.UserID, arg.RoleID)
	return err
}

const deleteUserRole = `-- name: DeleteUserRole :exec
DELETE FROM users_roles WHERE user_id = ? AND role_id = ?
`

type DeleteUserRoleParams struct {
	UserID sql.NullString
	RoleID sql.NullString
}

func (q *Queries) DeleteUserRole(ctx context.Context, arg DeleteUserRoleParams) error {
	_, err := q.db.ExecContext(ctx, deleteUserRole, arg.UserID, arg.RoleID)
	return err
}

const getUserRolesByUserID = `-- name: GetUserRolesByUserID :many
SELECT id, user_id, role_id FROM users_roles WHERE user_id = ?
`

func (q *Queries) GetUserRolesByUserID(ctx context.Context, userID sql.NullString) ([]UsersRole, error) {
	rows, err := q.db.QueryContext(ctx, getUserRolesByUserID, userID)
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
    user_id = COALESCE(?, user_id),
    role_id = COALESCE(?, role_id)
WHERE id = ?
  AND (COALESCE(?, user_id) != user_id
         OR COALESCE(?, role_id) != role_id)
`

type UpdateUserRoleParams struct {
	UserID   sql.NullString
	RoleID   sql.NullString
	ID       int32
	UserID_2 sql.NullString
	RoleID_2 sql.NullString
}

func (q *Queries) UpdateUserRole(ctx context.Context, arg UpdateUserRoleParams) error {
	_, err := q.db.ExecContext(ctx, updateUserRole,
		arg.UserID,
		arg.RoleID,
		arg.ID,
		arg.UserID_2,
		arg.RoleID_2,
	)
	return err
}
