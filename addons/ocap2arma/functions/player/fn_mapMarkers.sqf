waitUntil {!isNull (findDisplay 60492)};

findDisplay  60492 displayCtrl 62609 ctrlAddEventHandler ["Draw",{
	{
	  params["_map"];
	  _entityData = entitiesListData get _x;
	  if (count _entityData isNotEqualTo 4) then {

			_entityData params [
				"_name",
				"_group",
				"_isplayer",
				"_rol",
				"_side",
				"_type"
			];
			_obj = marcadoresfisicos getOrDefault [_x,[]];
			if (_obj isequalto []) exitwith {};
			_dataobj = _obj getvariable ["frameData",[]];
			if (_dataobj isequalto []) exitwith {};
			_dataobj params [
				"_id",
				"_position",
				"_direction",
				"_firing",
				"_posFired",
				"_alive",
				"_invehicle"
			];

			if (_invehicle && _alive) exitwith {};
			//_icon = gettext (configof _obj >> "icon");
			_icon = "iconMan";
			_color = [1,1,1,1];
			_text = "";
			if (_side isequalto "WEST") then {_color = [0,0.3,0.5,1]  };
			if (_side isequalto "EAST") then {_color = [0.7,0.2,0.2,1]};
			if (_side isequalto "GUER") then {_color = [0.2,0.7,0.2,1] };
			if (_side isequalto "CIV")  then {_color = [0.6,0.2,0.7,1]};
			if (_firing) then {_color = [1,1,1,0.8]};
			if !(_alive) then {_color = [0.4,0.4,0.4,1];_icon = "\a3\Ui_F_Curator\Data\CfgMarkers\kia_ca.paa"};
			if (ctrlMapScale _map < 0.03) then {_text = _name};

			_map drawicon [
				_icon,
				_color,
				_position,
				20,
				20,
				_direction,
				_text,
				true
			];

		  }else{ // es un vehiculo
				_entityData params [
						  "_name",
						  "_clase",
						  "_type",
						  "_classname"
					  ];
				_obj = marcadoresfisicos getOrDefault [_x,[]];
				if (_obj isequalto []) exitwith {};
				_dataobj = _obj getvariable ["FrameData",[]];
				if (_dataobj isequalto []) exitwith {};
				_dataobj params[
				  "_id",
				  "_position",
				  "_direction",
				  "_crew",
				  "_alive"
				];

				_side = "";
				_text = "";
				//if (camera distance _obj < 100) then {_text = format ["%1 | (%2)",_name,count(_crew)]};
				_icon = gettext (configof _obj >> "icon");
				_color = [1,1,1,1];
				_crew = ((_obj getVariable "frameData") select 3);
				if (_crew isNotEqualTo []) then {
					_side = (EntitiesListData get (_crew select 0)) select 4;
					if (_side isequalto "WEST") then {_color = [0,0.3,0.5,1]  };
					if (_side isequalto "EAST") then {_color = [0.7,0.2,0.2,1]	};
					if (_side isequalto "GUER") then {_color = [0.2,0.7,0.2,1]	};
					if (_side isequalto "CIV")  then {_color = [0.6,0.2,0.7,1]	};
				};
				if !(_alive) then {_color = [0.4,0.4,0.4,1]};

				_map drawIcon [
					_icon,
					_color,
					_position,
					20,
					20,
					_direction,
					_name,
					true
				];
		 };

	} foreach entitiesListData;
}];

addMissionEventHandler ["EachFrame",{
	if (ctrlshown (findDisplay  60492 displayCtrl 62609)) then {
		if (isnull findDisplay 1314) then {createDialog "PlayerControls"};
	}else{
		if !(isnull findDisplay 1314) then {closeDialog 1314};
	};
}];
