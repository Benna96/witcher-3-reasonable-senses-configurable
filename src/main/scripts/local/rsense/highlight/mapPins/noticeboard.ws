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

// Used in _entities
@addMethod( W3NoticeBoard ) protected /* override */ function GetHighlightOptionIndex() : int
{
	return RSHO_NOTICEBOARD;
}

/* ------------------------------ Registration ------------------------------ */

// Usually done in _entities, but noticeboards don't call super.OnSpawned
@wrapMethod( W3NoticeBoard ) function OnSpawned( spawnData : SEntitySpawnData )
{
	var returnVal : bool;

	returnVal = wrappedMethod( spawnData );
	GetHighlightOption().RegisterEntity( this );
	return returnVal;
}
