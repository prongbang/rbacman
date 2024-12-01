package rbacman

import (
	"context"
	"database/sql"
	"github.com/prongbang/rbacman/internal/db"
	"log/slog"
)

type DataSource interface {
	CreateAuditLog(ctx context.Context, arg db.CreateAuditLogParams) error
	GetAllAuditLogs(ctx context.Context) ([]db.AuditLog, error)
	GetAuditLogsByUserID(ctx context.Context, userID string) ([]db.AuditLog, error)
	UpdateAuditLog(ctx context.Context, arg db.UpdateAuditLogParams) error

	CreateGroup(ctx context.Context, arg db.CreateGroupParams) error
	DeleteGroup(ctx context.Context, id string) error
	GetGroupByID(ctx context.Context, id string) (db.Group, error)
	UpdateGroup(ctx context.Context, arg db.UpdateGroupParams) error

	CreateOrganization(ctx context.Context, arg db.CreateOrganizationParams) error
	DeleteOrganization(ctx context.Context, id int32) error
	GetOrganizationByID(ctx context.Context, id int32) (db.Organization, error)
	UpdateOrganization(ctx context.Context, arg db.UpdateOrganizationParams) error

	CreatePermission(ctx context.Context, arg db.CreatePermissionParams) error
	DeletePermission(ctx context.Context, id int32) error
	GetPermissionByID(ctx context.Context, id int32) (db.Permission, error)
	UpdatePermission(ctx context.Context, arg db.UpdatePermissionParams) error

	CreateResource(ctx context.Context, arg db.CreateResourceParams) error
	DeleteResource(ctx context.Context, id int32) error
	GetResourceByID(ctx context.Context, id int32) (db.Resource, error)
	UpdateResource(ctx context.Context, arg db.UpdateResourceParams) error

	CreateRole(ctx context.Context, arg db.CreateRoleParams) error
	DeleteRole(ctx context.Context, id string) error
	GetRoleByID(ctx context.Context, id string) (db.Role, error)
	UpdateRole(ctx context.Context, arg db.UpdateRoleParams) error

	CreateUser(ctx context.Context, arg db.CreateUserParams) error
	DeleteUser(ctx context.Context, id string) error
	GetUserByID(ctx context.Context, id string) (db.User, error)
	UpdateUser(ctx context.Context, arg db.UpdateUserParams) error

	CreateUserGroup(ctx context.Context, arg db.CreateUserGroupParams) error
	DeleteUserGroup(ctx context.Context, arg db.DeleteUserGroupParams) error
	GetUserGroupsByUserID(ctx context.Context, userID sql.NullString) ([]db.UsersGroup, error)
	UpdateUserGroup(ctx context.Context, arg db.UpdateUserGroupParams) error

	CreateUserPermission(ctx context.Context, arg db.CreateUserPermissionParams) error
	DeleteUserPermission(ctx context.Context, arg db.DeleteUserPermissionParams) error
	GetUserPermissionsByUserID(ctx context.Context, userID string) ([]db.UsersPermission, error)
	UpdateUserPermission(ctx context.Context, arg db.UpdateUserPermissionParams) error
	CheckPermissionsHighLevelByUserID(ctx context.Context, id string) (int64, error)
	CheckPermissionsUserLevelByUserID(ctx context.Context, arg db.CheckPermissionsUserLevelByUserIDParams) (int64, error)
	CheckPermissionsByUserID(ctx context.Context, arg CheckPermissionsUserIDParams) string

	CreateUserRole(ctx context.Context, arg db.CreateUserRoleParams) error
	DeleteUserRole(ctx context.Context, arg db.DeleteUserRoleParams) error
	GetUserRolesByUserID(ctx context.Context, userID sql.NullString) ([]db.UsersRole, error)
	UpdateUserRole(ctx context.Context, arg db.UpdateUserRoleParams) error
}

type dataSource struct {
	Queries *db.Queries
}

func (d *dataSource) CheckPermissionsByUserID(ctx context.Context, arg CheckPermissionsUserIDParams) string {
	foundHl, hlErr := d.CheckPermissionsHighLevelByUserID(ctx, arg.ID)
	if foundHl > 0 && hlErr == nil {
		return HighLevel
	}
	if hlErr != nil {
		slog.Error("check high level", "message", hlErr.Error())
	}

	foundUl, ulErr := d.CheckPermissionsUserLevelByUserID(ctx, db.CheckPermissionsUserLevelByUserIDParams(arg))
	if foundUl > 0 && ulErr == nil {
		return UserLevel
	}
	if ulErr != nil {
		slog.Error("check user level", "message", hlErr.Error())
	}

	return BlockLevel
}

func (d *dataSource) CheckPermissionsHighLevelByUserID(ctx context.Context, id string) (int64, error) {
	return d.Queries.CheckPermissionsHighLevelByUserID(ctx, id)
}

func (d *dataSource) CheckPermissionsUserLevelByUserID(ctx context.Context, arg db.CheckPermissionsUserLevelByUserIDParams) (int64, error) {
	return d.Queries.CheckPermissionsUserLevelByUserID(ctx, arg)
}

func (d *dataSource) CreateAuditLog(ctx context.Context, arg db.CreateAuditLogParams) error {
	return d.Queries.CreateAuditLog(ctx, arg)
}

func (d *dataSource) GetAllAuditLogs(ctx context.Context) ([]db.AuditLog, error) {
	return d.Queries.GetAllAuditLogs(ctx)
}

func (d *dataSource) GetAuditLogsByUserID(ctx context.Context, userID string) ([]db.AuditLog, error) {
	return d.Queries.GetAuditLogsByUserID(ctx, userID)
}

func (d *dataSource) UpdateAuditLog(ctx context.Context, arg db.UpdateAuditLogParams) error {
	return d.Queries.UpdateAuditLog(ctx, arg)
}

func (d *dataSource) CreateGroup(ctx context.Context, arg db.CreateGroupParams) error {
	return d.Queries.CreateGroup(ctx, arg)
}

func (d *dataSource) DeleteGroup(ctx context.Context, id string) error {
	return d.Queries.DeleteGroup(ctx, id)
}

func (d *dataSource) GetGroupByID(ctx context.Context, id string) (db.Group, error) {
	return d.Queries.GetGroupByID(ctx, id)
}

func (d *dataSource) UpdateGroup(ctx context.Context, arg db.UpdateGroupParams) error {
	return d.Queries.UpdateGroup(ctx, arg)
}

func (d *dataSource) CreateOrganization(ctx context.Context, arg db.CreateOrganizationParams) error {
	return d.Queries.CreateOrganization(ctx, arg)
}

func (d *dataSource) DeleteOrganization(ctx context.Context, id int32) error {
	return d.Queries.DeleteOrganization(ctx, id)
}

func (d *dataSource) GetOrganizationByID(ctx context.Context, id int32) (db.Organization, error) {
	return d.Queries.GetOrganizationByID(ctx, id)
}

func (d *dataSource) UpdateOrganization(ctx context.Context, arg db.UpdateOrganizationParams) error {
	return d.Queries.UpdateOrganization(ctx, arg)
}

func (d *dataSource) CreatePermission(ctx context.Context, arg db.CreatePermissionParams) error {
	return d.Queries.CreatePermission(ctx, arg)
}

func (d *dataSource) DeletePermission(ctx context.Context, id int32) error {
	return d.Queries.DeletePermission(ctx, id)
}

func (d *dataSource) GetPermissionByID(ctx context.Context, id int32) (db.Permission, error) {
	return d.Queries.GetPermissionByID(ctx, id)
}

func (d *dataSource) UpdatePermission(ctx context.Context, arg db.UpdatePermissionParams) error {
	return d.Queries.UpdatePermission(ctx, arg)
}

func (d *dataSource) CreateResource(ctx context.Context, arg db.CreateResourceParams) error {
	return d.Queries.CreateResource(ctx, arg)
}

func (d *dataSource) DeleteResource(ctx context.Context, id int32) error {
	return d.Queries.DeleteResource(ctx, id)
}

func (d *dataSource) GetResourceByID(ctx context.Context, id int32) (db.Resource, error) {
	return d.Queries.GetResourceByID(ctx, id)
}

func (d *dataSource) UpdateResource(ctx context.Context, arg db.UpdateResourceParams) error {
	return d.Queries.UpdateResource(ctx, arg)
}

func (d *dataSource) CreateRole(ctx context.Context, arg db.CreateRoleParams) error {
	return d.Queries.CreateRole(ctx, arg)
}

func (d *dataSource) DeleteRole(ctx context.Context, id string) error {
	return d.Queries.DeleteRole(ctx, id)
}

func (d *dataSource) GetRoleByID(ctx context.Context, id string) (db.Role, error) {
	return d.Queries.GetRoleByID(ctx, id)
}

func (d *dataSource) UpdateRole(ctx context.Context, arg db.UpdateRoleParams) error {
	return d.Queries.UpdateRole(ctx, arg)
}

func (d *dataSource) CreateUser(ctx context.Context, arg db.CreateUserParams) error {
	return d.Queries.CreateUser(ctx, arg)
}

func (d *dataSource) DeleteUser(ctx context.Context, id string) error {
	return d.Queries.DeleteUser(ctx, id)
}

func (d *dataSource) GetUserByID(ctx context.Context, id string) (db.User, error) {
	return d.Queries.GetUserByID(ctx, id)
}

func (d *dataSource) UpdateUser(ctx context.Context, arg db.UpdateUserParams) error {
	return d.Queries.UpdateUser(ctx, arg)
}

func (d *dataSource) CreateUserGroup(ctx context.Context, arg db.CreateUserGroupParams) error {
	return d.Queries.CreateUserGroup(ctx, arg)
}

func (d *dataSource) DeleteUserGroup(ctx context.Context, arg db.DeleteUserGroupParams) error {
	return d.Queries.DeleteUserGroup(ctx, arg)
}

func (d *dataSource) GetUserGroupsByUserID(ctx context.Context, userID sql.NullString) ([]db.UsersGroup, error) {
	return d.Queries.GetUserGroupsByUserID(ctx, userID)
}

func (d *dataSource) UpdateUserGroup(ctx context.Context, arg db.UpdateUserGroupParams) error {
	return d.Queries.UpdateUserGroup(ctx, arg)
}

func (d *dataSource) CreateUserPermission(ctx context.Context, arg db.CreateUserPermissionParams) error {
	return d.Queries.CreateUserPermission(ctx, arg)
}

func (d *dataSource) DeleteUserPermission(ctx context.Context, arg db.DeleteUserPermissionParams) error {
	return d.Queries.DeleteUserPermission(ctx, arg)
}

func (d *dataSource) GetUserPermissionsByUserID(ctx context.Context, userID string) ([]db.UsersPermission, error) {
	return d.Queries.GetUserPermissionsByUserID(ctx, userID)
}

func (d *dataSource) UpdateUserPermission(ctx context.Context, arg db.UpdateUserPermissionParams) error {
	return d.Queries.UpdateUserPermission(ctx, arg)
}

func (d *dataSource) CreateUserRole(ctx context.Context, arg db.CreateUserRoleParams) error {
	return d.Queries.CreateUserRole(ctx, arg)
}

func (d *dataSource) DeleteUserRole(ctx context.Context, arg db.DeleteUserRoleParams) error {
	return d.Queries.DeleteUserRole(ctx, arg)
}

func (d *dataSource) GetUserRolesByUserID(ctx context.Context, userID sql.NullString) ([]db.UsersRole, error) {
	return d.Queries.GetUserRolesByUserID(ctx, userID)
}

func (d *dataSource) UpdateUserRole(ctx context.Context, arg db.UpdateUserRoleParams) error {
	return d.Queries.UpdateUserRole(ctx, arg)
}

func NewDataSource(queries *db.Queries) DataSource {
	return &dataSource{
		Queries: queries,
	}
}
