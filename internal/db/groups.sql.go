// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.27.0
// source: groups.sql

package db

import (
	"context"
	"database/sql"
)

const createGroup = `-- name: CreateGroup :exec
INSERT INTO ` + "`" + `groups` + "`" + ` (id, name) VALUES (?, ?)
`

type CreateGroupParams struct {
	ID   string
	Name sql.NullString
}

func (q *Queries) CreateGroup(ctx context.Context, arg CreateGroupParams) error {
	_, err := q.db.ExecContext(ctx, createGroup, arg.ID, arg.Name)
	return err
}

const deleteGroup = `-- name: DeleteGroup :exec
DELETE FROM ` + "`" + `groups` + "`" + ` WHERE id = ?
`

func (q *Queries) DeleteGroup(ctx context.Context, id string) error {
	_, err := q.db.ExecContext(ctx, deleteGroup, id)
	return err
}

const getGroupByID = `-- name: GetGroupByID :one
SELECT id, name FROM ` + "`" + `groups` + "`" + ` WHERE id = ?
`

func (q *Queries) GetGroupByID(ctx context.Context, id string) (Group, error) {
	row := q.db.QueryRowContext(ctx, getGroupByID, id)
	var i Group
	err := row.Scan(&i.ID, &i.Name)
	return i, err
}

const updateGroup = `-- name: UpdateGroup :exec
UPDATE ` + "`" + `groups` + "`" + `
SET
    name = COALESCE(?, name)
WHERE id = ?
  AND COALESCE(?, name) != name
`

type UpdateGroupParams struct {
	Name   sql.NullString
	ID     string
	Name_2 sql.NullString
}

func (q *Queries) UpdateGroup(ctx context.Context, arg UpdateGroupParams) error {
	_, err := q.db.ExecContext(ctx, updateGroup, arg.Name, arg.ID, arg.Name_2)
	return err
}
