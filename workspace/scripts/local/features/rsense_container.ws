/* ------------------------------ Option class ------------------------------ */

class CRsenseContainerGlowOption extends IRsenseGlowOption
{
	default xmlId = 'containerGlow';
	default defaultValue = "false";

	protected /* override */ function IsSupportedEntity( entity : CGameplayEntity ) : bool
	{
		return (W3Container)entity;
	}
}

/* ------------------------------ Option getter ----------------------------- */

// Various container classes have their own options
// Through this helper, code can largely be shared between them
@addMethod( W3Container ) protected function GetRelevantGlowOption() : IRsenseGlowOption
{
	return theGame.GetRsenseConfig().containerGlowOption;
}

/* ------------------------------ Registration ------------------------------ */

@wrapMethod( W3Container ) function OnSpawned( spawnData : SEntitySpawnData )
{
	GetRelevantGlowOption().RegisterEntity( this );
	wrappedMethod( spawnData );
}

/* -------------------------- Visibility injection -------------------------- */

// Depends on gamePlayEntity.ws making FocusModeVisibility funcs overrideable
@addField( W3Container )
private var cachedFocusModeVisiblity : EFocusModeVisibility;
@addMethod( W3Container ) /* override */ function SetFocusModeVisibility( focusModeVisibility : EFocusModeVisibility, optional persistent : bool, optional force : bool )
{
	cachedFocusModeVisiblity = focusModeVisibility;
	focusModeVisibility = Rsense_MaybeNoVisibility( focusModeVisibility, GetRelevantGlowOption() );
	super.SetFocusModeVisibility( focusModeVisibility, persistent, force );
}
@addMethod( W3Container ) /* override */ function GetFocusModeVisibility() : EFocusModeVisibility
{
	return Rsense_SuperOrCachedVisibility( super.GetFocusModeVisibility(), cachedFocusModeVisiblity );
}
