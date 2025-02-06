/* ------------------------------ Option class ------------------------------ */

class CRsenseContainerGlowOption extends IRsenseGlowOption
{
	default xmlId = 'containersGlow';
	default defaultValue = "false";

	protected /* override */ function IsSupportedEntity( entity : CGameplayEntity ) : bool
	{
		return (W3Container)entity;
	}
}

/* ------------------------------ Registration ------------------------------ */

@wrapMethod( W3Container ) function OnSpawned( spawnData : SEntitySpawnData )
{
	theGame.GetRsenseConfig().containerGlowOption.RegisterEntity( this );
	wrappedMethod( spawnData );
}

/* -------------------------- Visibility injection -------------------------- */

// Depends on gamePlayEntity.ws making FocusModeVisibility funcs overrideable
@addField( W3Container )
private var cachedFocusModeVisiblity : EFocusModeVisibility;
@addMethod( W3Container ) function /* override */ SetFocusModeVisibility( focusModeVisibility : EFocusModeVisibility, optional persistent : bool, optional force : bool )
{
	cachedFocusModeVisiblity = focusModeVisibility;
	focusModeVisibility = Rsense_MaybeNoVisibility( focusModeVisibility, GetRelevantGlowOption() );
	super.SetFocusModeVisibility( focusModeVisibility, persistent, force );
}
@addMethod( W3Container ) function /* override */ GetFocusModeVisibility() : EFocusModeVisibility
{
	return Rsense_SuperOrCachedVisibility( super.GetFocusModeVisibility(), cachedFocusModeVisiblity );
}

// Helper func needed because various container classes have their own options
@addMethod( W3Container ) protected function GetRelevantGlowOption() : IRsenseGlowOption
{
	return theGame.GetRsenseConfig().containerGlowOption;
}
