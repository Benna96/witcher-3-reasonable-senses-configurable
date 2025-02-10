/* ------------------------------ Option class ------------------------------ */

class CRsenseNoticeboardGlowOption extends IRsenseGlowOption
{
	default xmlId = 'noticeboardGlow';
	default defaultValue = "true";

	protected /* override */ function IsSupportedEntity( entity : CGameplayEntity ) : bool
	{
		return (W3NoticeBoard)entity;
	}
}

/* ------------------------------ Option getter ----------------------------- */

// Used in _mapPinEntities
@addMethod( W3NoticeBoard ) protected /* override */ function GetGlowOption() : IRsenseGlowOption
{
	return theGame.GetRsenseConfig().noticeboardGlowOption;
}

/* ------------------------------ Registration ------------------------------ */

@wrapMethod( W3NoticeBoard ) function OnSpawned( spawnData : SEntitySpawnData )
{
	wrappedMethod( spawnData );
	GetGlowOption().RegisterEntity( this );
}
