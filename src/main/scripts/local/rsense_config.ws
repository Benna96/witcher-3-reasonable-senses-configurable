/* ------------------------------ Config class ------------------------------ */

class CRsenseConfig
{
	public var options : array< IRsenseOption >;
	public var signpostHighlightOption : CRsenseSignpostHighlightOption;
	public var noticeboardHighlightOption : CRsenseNoticeboardHighlightOption;
	public var buffStationHighlightOption : CRsenseBuffStationHighlightOption;
	public var clueHighlightOption : CRsenseClueHighlightOption;
	public var posterHighlightOption : CRsensePosterHighlightOption;
	public var stashHighlightOption : CRsenseStashHighlightOption;
	public var herbHighlightOption : CRsenseHerbHighlightOption;
	public var beehiveHighlightOption : CRsenseBeehiveHighlightOption;
	public var containerHighlightOption : CRsenseContainerHighlightOption;
	public var doorHighlightOption : CRsenseDoorHighlightOption;
	public var corpseHighlightOption : CRsenseCorpseHighlightOption;
	public var explosiveBarrelHighlightOption : CRsenseExplosiveBarrelHighlightOption;

	public function Init()
	{
		var i : int;

		signpostHighlightOption = new CRsenseSignpostHighlightOption in this;
		noticeboardHighlightOption = new CRsenseNoticeboardHighlightOption in this;
		buffStationHighlightOption = new CRsenseBuffStationHighlightOption in this;
		clueHighlightOption = new CRsenseClueHighlightOption in this;
		posterHighlightOption = new CRsensePosterHighlightOption in this;
		stashHighlightOption = new CRsenseStashHighlightOption in this;
		herbHighlightOption = new CRsenseHerbHighlightOption in this;
		beehiveHighlightOption = new CRsenseBeehiveHighlightOption in this;
		containerHighlightOption = new CRsenseContainerHighlightOption in this;
		doorHighlightOption = new CRsenseDoorHighlightOption in this;
		corpseHighlightOption = new CRsenseCorpseHighlightOption in this;
		explosiveBarrelHighlightOption = new CRsenseExplosiveBarrelHighlightOption in this;

		options.PushBack( signpostHighlightOption );
		options.PushBack( noticeboardHighlightOption );
		options.PushBack( buffStationHighlightOption );
		options.PushBack( clueHighlightOption );
		options.PushBack( posterHighlightOption );
		options.PushBack( stashHighlightOption );
		options.PushBack( herbHighlightOption );
		options.PushBack( beehiveHighlightOption );
		options.PushBack( containerHighlightOption );
		options.PushBack( doorHighlightOption );
		options.PushBack( corpseHighlightOption );
		options.PushBack( explosiveBarrelHighlightOption );
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
