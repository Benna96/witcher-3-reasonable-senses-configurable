/* ------------------------------ Config class ------------------------------ */

// Using enums for indices, maps/dictionaries don't exist in WS
enum ERsenseOption
{
	RSHO_SIGNPOST,
	RSHO_NOTICEBOARD,
	RSHO_BUFFSTATION,
	RSHO_CLUE,
	RSHO_POSTER,
	RSHO_STASH,
	RSHO_HERB,
	RSHO_BEEHIVE,
	RSHO_CONTAINER,
	RSHO_DOOR,
	RSHO_CORPSE,
	RSHO_EXPLOSIVEBARREL,
}

class CRsenseConfig
{
	public var options : array< IRsenseOption >;

	public function Init()
	{
		var i : int;

		options.PushBack( new CRsenseSignpostHighlightOption in this );
		options.PushBack( new CRsenseNoticeboardHighlightOption in this );
		options.PushBack( new CRsenseBuffStationHighlightOption in this );
		options.PushBack( new CRsenseClueHighlightOption in this );
		options.PushBack( new CRsensePosterHighlightOption in this );
		options.PushBack( new CRsenseStashHighlightOption in this );
		options.PushBack( new CRsenseHerbHighlightOption in this );
		options.PushBack( new CRsenseBeehiveHighlightOption in this );
		options.PushBack( new CRsenseContainerHighlightOption in this );
		options.PushBack( new CRsenseDoorHighlightOption in this );
		options.PushBack( new CRsenseCorpseHighlightOption in this );
		options.PushBack( new CRsenseExplosiveBarrelHighlightOption in this );
		for( i = 0; i < options.Size(); i += 1 )
		{
			options[ i ].Init();
		}
	}
}

/* --------------------------------- Getter --------------------------------- */

@addField( CR4Game )
private var rsenseConfig : CRsenseConfig;
@addMethod( CR4Game ) public function GetRsenseConfig() : CRsenseConfig
{
	if( !rsenseConfig )
	{
		rsenseConfig = new CRsenseConfig in this;
		rsenseConfig.Init();
	}
	
	return rsenseConfig;
}
