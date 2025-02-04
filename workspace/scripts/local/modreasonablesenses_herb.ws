/* ------------------------------ Option class ------------------------------ */

class CRsenseHerbGlowOption extends IRsenseGlowOption
{
	default xmlId = 'herbsGlow';
	default defaultValue = "false";

	protected /* override */ function IsSupportedEntity( entity : CGameplayEntity ) : bool
	{
		return (W3Herb)entity;
	}

	protected /* override */ function ApplyToEntity_Impl( entity : CGameplayEntity )
	{
		((W3Herb)entity).RequestUpdateContainer(); // UpdateContainer updates focus visibility among other things
	}
}

/* ------------------------------ Registration ------------------------------ */

@wrapMethod( W3Herb ) function OnSpawned( spawnData : SEntitySpawnData )
{
	theGame.GetRsenseConfig().herbGlowOption.RegisterEntity( this );
	wrappedMethod( spawnData );
}

/* -------------------------- Visibility injection -------------------------- */

// Required for most herbs, links to the new SRTs
@wrapMethod( CSwitchableFoliageComponent ) function SetAndSaveEntry( entryName : name )
{
	if( entryName == 'full' && (W3Herb)GetEntity() && !theGame.GetRsenseConfig().herbGlowOption.currentValue )
	{
		entryName = 'fullnoglow';
	}

	wrappedMethod( entryName );
}

// Used in _container
// Helper func needed because W3Container has its own logic
@addMethod( W3Herb ) protected /* override */ function GetInteractiveFocusModeVisibility() : EFocusModeVisibility
{
	if( !theGame.GetRsenseConfig().herbGlowOption.currentValue )
	{
		return FMV_None;
	}
	else
	{
		return FMV_Interactive;
	}
}
