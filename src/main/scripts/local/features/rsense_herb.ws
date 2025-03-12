/* ------------------------------ Option class ------------------------------ */

class CRsenseHerbHighlightOption extends IRsenseHighlightOption
{
	default xmlId = 'herbHighlight';

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

// Used in _entities
@addMethod( W3Herb ) protected /* override */ function GetHighlightOption() : IRsenseHighlightOption
{
	return theGame.GetRsenseConfig().herbHighlightOption;
}

/* ------------------------------ Registration ------------------------------ */

// Usually done in _entities, but herbs don't call super.OnSpawned
@wrapMethod( W3Herb ) function OnSpawned( spawnData : SEntitySpawnData )
{
	if( wrappedMethod( spawnData ) == true )
		return true;

	GetHighlightOption().RegisterEntity( this );
}

/* -------------------------- Visibility injection -------------------------- */

// Most herbs use foliage's entry instead of focusModeVisibility
// (focusModeVisibility is handled by _lockableEntities)
@wrapMethod( CSwitchableFoliageComponent ) function SetAndSaveEntry( entryName : name )
{
	var cachedEntryName : name;
	var herb : W3Herb;

	cachedEntryName = entryName;
	herb = (W3Herb)GetEntity();

	if( entryName == 'full' && herb && !RSense_HasFlag( herb.GetHighlightOption().allowedVisibilities, FMV_Interactive ) )
	{
		entryName = 'full_nohighlight';
	}

	wrappedMethod( entryName );

	// Instead of introducing a cached field like with FocusModeVisibility funcs,
	// use the one that already exists in vanilla game & is used by GetEntry.
	currEntryName = cachedEntryName;
}
