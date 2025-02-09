/* ------------------------------ Option class ------------------------------ */

class CRsenseNoticeboardGlowOption extends IRsenseGlowOption
{
	default xmlId = 'noticeboardGlow';
	default defaultValue = "false";

	protected /* override */ function IsSupportedEntity( entity : CGameplayEntity ) : bool
	{
		return (W3NoticeBoard)entity;
	}
}

/* ------------------------------ Registration ------------------------------ */

@wrapMethod( W3NoticeBoard ) function OnSpawned( spawnData : SEntitySpawnData )
{
	wrappedMethod( spawnData );
	theGame.GetRsenseConfig().noticeboardGlowOption.RegisterEntity( this );
}

/* -------------------------- Visibility injection -------------------------- */

// Depends on gamePlayEntity.ws making FocusModeVisibility funcs overrideable
@addField( W3NoticeBoard )
private var cachedFocusModeVisiblity : EFocusModeVisibility;
@addMethod( W3NoticeBoard ) /* override */ function SetFocusModeVisibility( focusModeVisibility : EFocusModeVisibility, optional persistent : bool, optional force : bool )
{
	cachedFocusModeVisiblity = focusModeVisibility;
	focusModeVisibility = Rsense_MaybeNoVisibility( focusModeVisibility, theGame.GetRsenseConfig().noticeboardGlowOption );
	super.SetFocusModeVisibility( focusModeVisibility, persistent, force );
}
@addMethod( W3NoticeBoard ) /* override */ function GetFocusModeVisibility() : EFocusModeVisibility
{
	return Rsense_SuperOrCachedVisibility( super.GetFocusModeVisibility(), cachedFocusModeVisiblity );
}
