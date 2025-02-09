// The affected class has 'Repair' in the name, but actually just buffs

/* ------------------------------ Option class ------------------------------ */

class CRsenseBuffStationGlowOption extends IRsenseGlowOption
{
	default xmlId = 'buffStationGlow';
	default defaultValue = "false";

	protected /* override */ function IsSupportedEntity( entity : CGameplayEntity ) : bool
	{
		return (W3ItemRepairObject)entity;
	}
}

/* ------------------------------ Registration ------------------------------ */

@addField( W3ItemRepairObject )
private var rsenseInitDone : bool;
@wrapMethod( W3ItemRepairObject ) function OnSpawned( spawnData : SEntitySpawnData )
{
	theGame.GetRsenseConfig().buffStationGlowOption.RegisterEntity( this );
	wrappedMethod( spawnData );
	SetFocusModeVisibility( GetFocusModeVisibility() ); // Without this, visibility is only set on engine side not script
}

/* -------------------------- Visibility injection -------------------------- */

// Depends on gamePlayEntity.ws making FocusModeVisibility funcs overrideable
@addField( W3ItemRepairObject )
private var cachedFocusModeVisiblity : EFocusModeVisibility;
@addMethod( W3ItemRepairObject ) /* override */ function SetFocusModeVisibility( focusModeVisibility : EFocusModeVisibility, optional persistent : bool, optional force : bool )
{
	cachedFocusModeVisiblity = focusModeVisibility;
	focusModeVisibility = Rsense_MaybeNoVisibility( focusModeVisibility, theGame.GetRsenseConfig().buffStationGlowOption );
	super.SetFocusModeVisibility( focusModeVisibility, persistent, force );
}
@addMethod( W3ItemRepairObject ) /* override */ function GetFocusModeVisibility() : EFocusModeVisibility
{
	return Rsense_SuperOrCachedVisibility( super.GetFocusModeVisibility(), cachedFocusModeVisiblity );
}
