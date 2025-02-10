/* ------------------------------ Option class ------------------------------ */

class CRsenseStashGlowOption extends IRsenseGlowOption
{
	default xmlId = 'stashGlow';
	default defaultValue = "false";

	protected /* override */ function IsSupportedEntity( entity : CGameplayEntity ) : bool
	{
		return (W3Stash)entity;
	}
}

/* ------------------------------ Option getter ----------------------------- */

@addMethod( W3Stash ) protected function GetGlowOption() : IRsenseGlowOption
{
	return theGame.GetRsenseConfig().stashGlowOption;
}

/* ------------------------------ Registration ------------------------------ */

// W3Stash doesn't define OnSpawned to wrap, do it in InteractiveEntity instead
// Put this in its own class if I add more InteractiveEntity classes
@wrapMethod( CInteractiveEntity ) function OnSpawned( spawnData : SEntitySpawnData )
{
	wrappedMethod( spawnData );
	GetGlowOption().RegisterEntity( this );
}
