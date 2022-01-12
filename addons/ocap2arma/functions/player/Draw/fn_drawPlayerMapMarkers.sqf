/*
  Function that updates the markers based on the currently frame

  input:
    Frame
  output:
    none
*/

_frame = localNamespace getvariable ["O2A_PLAYER_Frame",0];
private _markers = mapMarkers;

{
  _marker = _markers get _x;
  _id = str _x;
  _marker params [
	"_markerType",
	"_markerText",
	"_startFrame",
	"_endFrame",
	"_placerID",
	"_color",
	"_side",// side of placer (-1 for GLOBAL)
	"_positions",
	/*
	  [
		  frame,(number)
		  posAGL,
		  markerDir, (0-360)
		  markerAlpha, (number)
	  ]
	*/
	"_markerSize",
	"_markerShape",
	"_markerBrush"
  ];
	//Switch for player markers
	if ( !(localNamespace getVariable ["O2A_VAR_showPlayerMarkers",true]) && _placerID isnotequalto -1) then {deleteMarker _id;continue};
  if (_frame > _endFrame || _frame < _startFrame) then {deleteMarker _id;continue;};
	if !(_id in allMapMarkers) then {createMarker [_id,[0,0,0]]};
  //Color Fix

  //Select the desired position in positions array
  /*reverse _positions;
  _idx = _positions findif {_x#0 >= _frame};
  if (_idx isEqualto -1 ) exitwith { systemChat "esto no deberia dar -1 :D"};
  _position = _positions select _idx;
  */
  _position = _positions select 0;

  _position params [
			  "",//frame,(number)
			  "_mkpos",//posAGL,
			  "_mkdir",//markerDir, (0-360)
			  "_mkAlpha"//markerAlpha, (number)
  ];

  _id setmarkerType _markerType;
  _id setmarkertext _markerText;
	if (localNamespace getvariable ["O2A_VAR_sidedMarkerColors",true] ) then {
		_id setmarkercolor (_color#1);
	} else{
		_id setmarkercolor (_color#0);
	};

	if (_markerShape in ["RECTANGLE","ELLIPSE"]) then {

		_id setMarkerSize  _markerSize;
		_id setMarkerShape _markerShape;
		_id setMarkerBrush _markerBrush;
	};

  if (_markerShape isequalto "POLYLINE") then {
	_poly = [];
	{_poly append _x} foreach _mkpos;
	_id setMarkerPolyline _poly;
  }else{
		if ( _mkpos findif {!( _x isEqualType 0 )} isequalto -1 ) then {
			_id setmarkerpos _mkpos select [0,2];
		}else{
			_id setmarkerpos (_mkpos#0) select [0,2];
			//systemchat str [_id,_positions];
		};

  };
  _id setmarkerdir _mkdir;
  _id setMarkerAlpha _mkAlpha;

  if (_markerShape isnotequalto "") then {
	_id setMarkerSize  _markerSize;
	_id setMarkerShape _markerShape;
	_id setMarkerBrush _markerBrush;
  };

}foreach _markers;
