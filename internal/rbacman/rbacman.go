package rbacman

import (
	"database/sql"
	"fmt"
)

const (
	HighLevel  = "HIGH_LEVEL"
	UserLevel  = "USER_LEVEL"
	BlockLevel = "BLOCK_LEVEL"

	PermissionRead   = "READ"
	PermissionCreate = "CREATE"
	PermissionUpdate = "Update"
	PermissionDelete = "DELETE"

	ResourceGroup            = "GROUP"
	ResourceGroupPermission  = "GROUP_PERMISSION"
	ResourceOrganization     = "ORGANIZATION"
	ResourcePermission       = "PERMISSION"
	ResourceResource         = "RESOURCE"
	ResourceRole             = "ROLE"
	ResourceUser             = "USER"
	ResourceUserGroup        = "USER_GROUP"
	ResourceUserOrganization = "USER_ORGANIZATION"
	ResourceUserPermission   = "USER_PERMISSION"
	ResourceUserRole         = "USER_ROLE"
	ResourceAuditLog         = "AUDIT_LOG"
	ResourceStore            = "STORE"
	ResourceStoreFormat      = "STORE_FORMAT"
	ResourceDevice           = "DEVICE"
	ResourceDeviceType       = "DEVICE_TYPE"
	ResourceDashboard        = "DASHBOARD"
)

func PermissionCode(resource, permission string) sql.NullString {
	return sql.NullString{String: fmt.Sprintf("%s_%s", resource, permission)}
}

type CheckPermissionsUserIDParams struct {
	ID   string
	Code sql.NullString
}
