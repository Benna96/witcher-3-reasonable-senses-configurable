/* ------------------------------ Option class ------------------------------ */

class CRsenseHerbGlowOption extends IRsenseGlowOption
{
	default xmlId = 'herbsGlow';
	default defaultValue = "false";

	protected /* override */ function IsSupportedEntity( entity : CGameplayEntity ) : bool
	{
		return (W3Herb)entity;
	}

	// Most herbs' visibility depends on foliageComponent
	protected /* override */ function ApplyToEntity( entity : CGameplayEntity )
	{
		var foliageComponent : CSwitchableFoliageComponent;

		super.ApplyToEntity( entity );

		foliageComponent = (CSwitchableFoliageComponent)entity.GetComponentByClassName( 'CSwitchableFoliageComponent' );
		if( foliageComponent )
		{
			foliageComponent.SetAndSaveEntry( foliageComponent.GetEntry() );
		}
	}
}

/* ------------------------------ Registration ------------------------------ */

@wrapMethod( W3Herb ) function OnSpawned( spawnData : SEntitySpawnData )
{
	theGame.GetRsenseConfig().herbGlowOption.RegisterEntity( this );
	wrappedMethod( spawnData );
}

/* -------------------------- Visibility injection -------------------------- */

// Used in _container
// Helper func needed because various container classes have their own options
@addMethod( W3Herb ) protected /* override */ function GetRelevantGlowOption() : IRsenseGlowOption
{
	return theGame.GetRsenseConfig().herbGlowOption;
}

// Most herbs use foliage's entry instead of focusModeVisibility
@wrapMethod( CSwitchableFoliageComponent ) function SetAndSaveEntry( entryName : name )
{
	var cachedEntryName : name;

	cachedEntryName = entryName;

	if( entryName == 'full' && (W3Herb)GetEntity() && !theGame.GetRsenseConfig().herbGlowOption.currentValue )
	{
		entryName = 'fullnoglow';
		LogChannel('ReasonableSenses', "herb full SetAndSaveEntry called");
	}

	wrappedMethod( entryName );
	currEntryName = cachedEntryName; // To return the "set" visibility from GetEntry
}
