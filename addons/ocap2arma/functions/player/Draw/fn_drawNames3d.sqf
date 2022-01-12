/*
	Draws the name of the each unit and when its too far, only a dot, so its easy to see the infantery movements

*/


addMissionEventHandler ["draw3D",
	{
		{
			_id = _x;
			_obj = MarcadoresFisicos get _id;
			_unitNamesViewDistance = localNamespace getvariable ["unitNamesViewDistance",viewDistance*1.5];
			_vehiclesNamesViewDistance = localNamespace getvariable ["vehiclesNamesViewDistance",viewDistance*1.5];
			_data = (EntitiesListData get _id);
			if ( count (EntitiesListData get _id) isnotequalto 4 ) then {
				_distance = camera distance _obj;
				if (_distance > _unitNamesViewDistance) exitWith {};
				if (isnil "_data") exitwith {};
				_data params [
				  "_name",
				  "_group",
				  "_isplayer",
				  "_rol",
				  "_side",
				  "_type"
			  ];
				_color = [1,1,1,1];
				_pos = getPosatl _obj;
				if (_side isequalto "WEST") then {_color = [0.2,0.5,0.8,1]  };
				if (_side isequalto "EAST") then {_color = [0.7,0.2,0.2,1]	};
				if (_side isequalto "GUER") then {_color = [0.2,0.7,0.2,1]  };
				if (_side isequalto "CIV")  then {_color = [0.6,0.2,0.7,1]	};
				_playerData = _obj getVariable ["frameData",[]];
				_icon = "";
				_playerData params [
									"_id",
									"_position",
									"_direction",
									"_firing",
									"_posFired",
									"_alive",
									"_invehicle"
							];
				if (_invehicle && _alive) exitwith {};
				_text = _name;
				if (_distance > 300) then { _text = "",_icon = "\A3\ui_f\data\map\markers\handdrawn\dot_CA.paa"};
				if (_playerData isNotEqualTo [] ) then {
					if (_firing) then {
						_color = [1,1,1,0.8];
					}else{
						if !(_alive) then {
							_color = [0.4,0.4,0.4,1];
							_icon = "\a3\Ui_F_Curator\Data\CfgMarkers\kia_ca.paa";
						};
					};
				};
				_pos = getPos _obj;
				_dis = camera distance _pos;
				_k = 10/_dis;
				_size = linearconversion [_vehiclesNamesViewDistance,100,_dis,0.5,1,true];
				drawIcon3D[
					_icon,
					_color,
					_pos,
					_size,
					_size,
					0,
					_text,
					2,
					0.03,
					"RobotoCondensed",
					"center",
					false,
					0,
					-0.5*_k
				];
			}else{//its a vehicle
				if (camera distance _obj > _vehiclesNamesViewDistance) exitWith {};
				_data params [
					"_name",
					"_clase",
					"_type",
					"_classname"
				];

				_pos = getPosatl _obj vectorAdd [0,0,3];
				_dataobj = _obj getvariable ["FrameData",[]];
				_dataobj params[
					"_id",
					"_position",
					"_direction",
					"_crew",
					"_alive"
				];
				_side = sideUnknown;
				_text = "";
				if (camera distance _obj < 300) then {_text = format ["%1 | (%2)",_name,count(_crew)]};
				_icon = gettext (configof _obj >> "icon");
				_dis = camera distance _pos;

				_color = [1,1,1,1];
				_crew = ((_obj getVariable "frameData") select 3);
				if (_crew isNotEqualTo []) then {
						_side = (EntitiesListData get (_crew select 0)) select 4;
						if (_side isequalto "WEST") then {_color = [0.2,0.5,0.8,1]	};
						if (_side isequalto "EAST") then {_color = [0.7,0.2,0.2,1]	};
						if (_side isequalto "GUER") then {_color = [0.2,0.7,0.2,1]	};
						if (_side isequalto "CIV")  then {_color = [0.6,0.2,0.7,1]	};
				};
				_dis = camera distance _pos;
				_k = 10/_dis;
				_size = linearconversion [_vehiclesNamesViewDistance,100,_dis,0.5,1,true];
				drawIcon3D [
					_icon,
					_color,
					_pos,
					_size,
					_size,
					0,
					_text,
					2,
					0.03,
					"RobotoCondensed",
					"center",
					false,
					0,
					-0.5*_k
				];
			};
	  }foreach MarcadoresFisicos;
	}];
