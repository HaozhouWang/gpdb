/*-------------------------------------------------------------------------
 *
 * pg_diskquota.h
 *	  definition of the "diskquota" system catalog (pg_diskquota)
 *
 *
 * Portions Copyright (c) 1996-2018, PostgreSQL Global Development Group
 * Portions Copyright (c) 1994, Regents of the University of California
 *
 * src/include/catalog/pg_diskquota.h
 *
 * NOTES
 *	  The Catalog.pm module reads this file and derives schema
 *	  information.
 *
 *-------------------------------------------------------------------------
 */
#ifndef PG_DISKQUOTA_H
#define PG_DISKQUOTA_H

#include "catalog/genbki.h"

/* ----------------
 *	pg_diskquota definition.  cpp turns this into
 *	typedef struct FormData_pg_diskquota
 * ----------------
 */

typedef enum DiskQuotaType
{
	DISKQUOTA_TYPE_UNKNOWN = -1,

	DISKQUOTA_TYPE_TABLE = 0,

	DISKQUOTA_TYPE_SCHEMA = 1,

	DISKQUOTA_TYPE_DATABASE = 3,

	DISKQUOTA_TYPE_ROLE = 2,

} DiskQuotaType;

#define DiskQuotaRelationId 5522

CATALOG(pg_diskquota,5522)
{
	NameData	quotaname;		/* diskquota name */
	int16		quotatype;		/* diskquota type name */
	Oid			quotatargetoid;	/* diskquota target db object oid*/
	int32		quotalimit;		/* diskquota size limit in MB*/
	int32		quotaredzone;	/* diskquota redzone in MB*/
} FormData_pg_diskquota;

#define Anum_pg_diskquota_quotaname 1
#define Anum_pg_diskquota_quotatype 2
#define Anum_pg_diskquota_quotatargetoid 3
#define Anum_pg_diskquota_quotalimit 4
#define Anum_pg_diskquota_quotaredzone 5

#define Natts_pg_diskquota 5

/* ----------------
 *	Form_pg_diskquota corresponds to a pointer to a tuple with
 *	the format of pg_diskquota relation.
 * ----------------
 */
typedef FormData_pg_diskquota *Form_pg_diskquota;

#endif							/* PG_DISKQUOTA_H */
