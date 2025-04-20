/* ------------------------------ Option class ------------------------------ */

class CRsenseHerbHighlightOption extends IRsenseHighlightOption
{
	default xmlId = 'herbHighlight';
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

// Used for highlight functionality
@addMethod( W3Herb ) protected /* override */ function GetHighlightOptionIndex() : int
{
	return RSHO_HERB;
}

/* ------------------------------ Registration ------------------------------ */

// Duplicate, herbs don't call super
@wrapMethod( W3Herb ) function OnSpawned( spawnData : SEntitySpawnData )
{
	return OnSpawned_HighlightHook( wrappedMethod( spawnData ) );
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

	if( entryName == 'full' && herb && herb.GetHighlightOption().shouldDisableHighlight )
	{
		entryName = 'full_nohighlight';
	}

	wrappedMethod( entryName );

	// Instead of introducing a cached field like with FocusModeVisibility funcs,
	// use the one that already exists in vanilla game & is used by GetEntry.
	currEntryName = cachedEntryName;
}
