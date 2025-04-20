/* ------------------------------ Option class ------------------------------ */

class CRsenseNoticeboardHighlightOption extends IRsenseHighlightOption
{
	default xmlId = 'noticeboardHighlight';

	protected /* override */ function IsSupportedEntity( entity : CGameplayEntity ) : bool
	{
		return (W3NoticeBoard)entity;
	}
}

/* ------------------------------ Option getter ----------------------------- */

// Used for highlight functionality
@addMethod( W3NoticeBoard ) protected /* override */ function GetHighlightOptionIndex() : int
{
	return RSHO_NOTICEBOARD;
}

/* ------------------------------ Registration ------------------------------ */

// Duplicate, noticeboards don't call super
@wrapMethod( W3NoticeBoard ) function OnSpawned( spawnData : SEntitySpawnData )
{
	return OnSpawned_HighlightHook( wrappedMethod( spawnData ) );
}
