// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.27.0
// source: organizations.sql

package db

import (
	"context"
)

const createOrganization = `-- name: CreateOrganization :exec
INSERT INTO organizations (id, name, parent_id) VALUES ($1, $2, $3)
`

func (q *Queries) CreateOrganization(ctx context.Context) error {
	_, err := q.db.ExecContext(ctx, createOrganization)
	return err
}

const deleteOrganization = `-- name: DeleteOrganization :exec
DELETE FROM organizations WHERE id = $1
`

func (q *Queries) DeleteOrganization(ctx context.Context) error {
	_, err := q.db.ExecContext(ctx, deleteOrganization)
	return err
}

const getOrganizationByID = `-- name: GetOrganizationByID :one
SELECT id, name, parent_id FROM organizations WHERE id = $1
`

func (q *Queries) GetOrganizationByID(ctx context.Context) (Organization, error) {
	row := q.db.QueryRowContext(ctx, getOrganizationByID)
	var i Organization
	err := row.Scan(&i.ID, &i.Name, &i.ParentID)
	return i, err
}

const updateOrganization = `-- name: UpdateOrganization :exec
UPDATE organizations
SET
    name = COALESCE($2, name),
    parent_id = COALESCE($3, parent_id)
WHERE id = $1
  AND (COALESCE($2, name) != name
         OR COALESCE($3, parent_id) != parent_id)
`

func (q *Queries) UpdateOrganization(ctx context.Context) error {
	_, err := q.db.ExecContext(ctx, updateOrganization)
	return err
}