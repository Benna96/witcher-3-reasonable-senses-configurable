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
@addMethod( W3NoticeBoard ) protected /* override */ function GetHighlightOption() : IRsenseHighlightOption
{
	return theGame.GetRsenseConfig().noticeboardHighlightOption;
}

/* ------------------------------ Registration ------------------------------ */

// Usually done in _entities, but noticeboards don't call super.OnSpawned
@wrapMethod( W3NoticeBoard ) function OnSpawned( spawnData : SEntitySpawnData )
{
	wrappedMethod( spawnData );
	GetHighlightOption().RegisterEntity( this );
}
