/* -------------------------- Override mod values --------------------------- */
/*                             Used in _container                             */

@addMethod( W3Herb ) public function GetInteractiveFocusModeVisibility() : EFocusModeVisibility
{
	if ( !theGame.GetRsenseStorage().herbsGlow )
	{
		return FMV_None;
	}
	else
	{
		return FMV_Interactive;
	}
}

@addMethod( W3Herb ) public function GetFoliageFullEntry() : name
{
	if ( !theGame.GetRsenseStorage().herbsGlow )
	{
		return 'fullnoglow';
	}
	else
	{
		return 'full';
	}
}