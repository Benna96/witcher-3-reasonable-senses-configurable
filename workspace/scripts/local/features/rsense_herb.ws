/* ------------------------------ Option class ------------------------------ */

class CRsenseHerbGlowOption extends IRsenseGlowOption
{
	default xmlId = 'herbGlow';
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

/* ------------------------------ Option getter ----------------------------- */

// Used in _container, some visibility done through there
@addMethod( W3Herb ) protected /* override */ function GetRelevantGlowOption() : IRsenseGlowOption
{
	return theGame.GetRsenseConfig().herbGlowOption;
}

/* ------------------------------ Registration ------------------------------ */

// Usually done through _container, but herbs don't call super.OnSpawned
@wrapMethod( W3Herb ) function OnSpawned( spawnData : SEntitySpawnData )
{
	GetRelevantGlowOption().RegisterEntity( this );
	wrappedMethod( spawnData );
}

/* -------------------------- Visibility injection -------------------------- */

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
