/* -------------------------------------------------------------------------
 *
 * auth_delay.c
 *
 * Copyright (C) 2010-2011, PostgreSQL Global Development Group
 *
 * IDENTIFICATION
 *		contrib/auth_delay/auth_delay.c
 *
 * -------------------------------------------------------------------------
 */
#include "postgres.h"

#include "cdb/cdbbufferedappend.h"
#include "utils/elog.h"

void	_PG_init(void);
void	_PG_fini(void);

static void
report_ao(BufferedAppend *ba)
{
	RelFileNode *node = &ba->relFileNode.node;
	elog(LOG, "ao active relation: (%d, %d, %d)", node->dbNode, node->spcNode, node->relNode);

	// report_active_table_helper(&ba->relFileNode);
}
/*
 * Module Load Callback
 */
void
_PG_init(void)
{
	dqao_report_hook = report_ao;
	elog(LOG, "register dqao_report_hook = %p\n", report_ao);
}

void
_PG_fini(void)
{
	elog(LOG, "unregister dqao_report_hook = %p\n", report_ao);
	dqao_report_hook = NULL;
}
