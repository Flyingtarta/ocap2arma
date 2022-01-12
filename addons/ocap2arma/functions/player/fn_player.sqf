/*
  Ocap2Arma player main loop
*/


params [ ["_skipPreload",true] ];
waituntil {!isnull (findDisplay 46) };
_BUFFER_SIZE = localNamespace getvariable ["O2A_VAR_BUFFER_SIZE",200];
//Deletes all mission content
{if !(isplayer _x) then {deleteVehicle _x} } foreach allunits;
{deletevehicle _x} foreach vehicles;
{deletemarker _x } foreach allMapMarkers;

//Vars of player control
hint "O2A player inicializated... ";
if (isnil {profilenamespace getvariable "temporalFile"}) then {
    _mapLoaded = [] call O2A_FNC_player_preLoad;
    if !(_mapLoaded) exitwith {["OCAP2ARMA FAILED","SELECTED MAP NOT LOEADED"] CALL bis_fnc_error;profilenamespace setvariable ["temporalFile",nil];};
}else{
    systemchat str "Loading data...";
    file = profilenamespace getvariable "temporalFile";
    profilenamespace setvariable ["temporalFile",nil];
    ["ocap2arma.cleanVariables", [] ] call py3_fnc_callExtension;
};

localNamespace setvariable ["O2A_PLAYER_Frame",0];
localNamespace setvariable ["O2A_PLAYER_paused",false];
localNamespace setvariable ["O2A_PLAYER_reverse",false];
localNamespace setvariable ["O2A_PLAYER_speed",10];

player hideObject true;
//sleep 3;
//Load all the data
[] call O2A_fnc_loadData;

["Initialize", [player]] call BIS_fnc_EGSpectator;
//call of all Draw functions
[] call O2A_fnc_drawNames3d;
//drawing of shots
[] call O2A_fnc_drawShots;
//draw map markers
[] call O2A_fnc_mapMarkers;
//
[] call O2A_fnc_draw_groupMarkers;

//Variables we gonna use
MarcadoresFisicos = createHashMap; // ID as key the object (vehicle or unit) created
camera = allMissionObjects "CamCurator"#0; //camera from spetcator
nameToClass = createHashMap; // hasmap where all name to classname are stored


_missionMetaData = metaData;
_missionMetaData params [
    "_name",        //(str) Mission name
    "_endFrame",    //(int) Total Frames
    "_wolrdName",   //(str) Map
    "_author",      //(str) Editor who created the mission
    "_timeStart",   //(str) time Data when the mission starts
    "_timeMultiply" //(str) Time aceleration
];

_startTime = time; //saves when the mission has started because simultion issues

//Change to the time of the day at the start of the mission
_time = _timeStart;
_dateArray = [];
_time = _time splitString "-";
_dateArray pushback (parseNumber (_time deleteat 0));
_dateArray pushback (parseNumber (_time deleteat 0));
_time = _time#0 splitString "T";
_dateArray pushback (parseNumber (_time deleteat 0));
_dateArray append ( (_time#0 splitString ":" ) apply {parseNumber _x});
setdate (_dateArray select [0,5]);
setTimeMultiplier (_timeMultiply*10);

while {true} do {
    _O2AFrame = localNamespace getvariable ["O2A_PLAYER_Frame",0];
    if (!isNull findDisplay 1314) then {
        //metaData params ["_name","_totalFrames","_wolrdName","_author","_timeStart","_timeMultiply"];
        _slider = findDisplay 1314 displayCtrl 1900;
        _slider sliderSetRange [0,_missionMetaData select 1];
        _slider sliderSetPosition _O2AFrame;

        _aceleration = findDisplay 1314 displayCtrl 1001;
        _aceleration ctrlSetText format ["Speed x%1",localNamespace getvariable ["O2A_PLAYER_speed",10]];

        _timer = findDisplay 1314 displayCtrl 1000;
        _timer ctrlSetText format [" %1 | %2 - %3", _O2AFrame , [((_O2AFrame)/60)+.01,"HH:MM"] call BIS_fnc_timetostring,[((_missionMetaData select 1)/60)+.01,"HH:MM"] call BIS_fnc_timetostring];
        
    };
    waitUntil {
      if (time > _startTime + 10) then {setAccTime 0.1};
      setTimeMultiplier 0;
      !(localNamespace getvariable ["O2A_PLAYER_paused",false])
    };


    if (localNamespace getVariable ["O2A_TIMEACEL_ENABLED",FALSE]) then {
        _playerSpeed = localNamespace getvariable ["O2A_PLAYER_speed",10];
        setTimeMultiplier  (_playerSpeed * _timeMultiply);
    };


    if (time > (_startTime + 10) ) then {setAccTime (localNamespace getvariable ["O2A_PLAYER_speed",10])};
    //select buffer based on frame
    _O2AFrame = localNamespace getvariable ["O2A_PLAYER_Frame",0];
    _bufferSelect = floor (_O2AFrame/_BUFFER_SIZE);
    _buffer = (entityPositionalData select _bufferSelect);
    //_entitiesData = (  _buffer select {_x#0 isequalto _O2AFrame } ) select 0 select 1;
    _entitiesData = _buffer get _O2AFrame;

    //Draws the markers in that frame
    [_O2AFrame] spawn O2A_fnc_drawPlayerMapMarkers;

    //Moves all objects than area used to representate the objects
    {
        _x spawn O2A_fnc_fisicalMarkers;
    }foreach _entitiesData;

    //explosivos:
    /*
        #0 classname
        #1 startFrame
        #2 EndFrame
        #3 Direction
        #4 Positions 1 or 3 values : calculate parabola (?
    */

    //Draw the explocives, smoke grandes, etc
    _explo = explosiveData getOrDefault [_O2AFrame,[]];
    if (_explo isNotEqualTo []) then {
        {
            _x spawn O2A_fnc_drawExplotion;
        }foreach _explo;
    };

    //player settings
    _speed = localNamespace getvariable ["O2A_PLAYER_speed",10];
    sleep (1/_speed);
    _reversed = localNamespace getvariable ["O2A_PLAYER_reverse",false];
    _O2AFrame = localNamespace getvariable ["O2A_PLAYER_Frame",0];
    if (_reversed) then {
        localNamespace setvariable ["O2A_PLAYER_Frame",_O2AFrame - 1]; //esto no va aca
        if (_O2AFrame < 1) then {
            localNamespace setvariable ["O2A_PLAYER_Frame",0]; //esto no va aca
        };
    }else{
        localNamespace setvariable ["O2A_PLAYER_Frame",_O2AFrame + 1]; //esto no va aca
        if (_O2AFrame > _endFrame-1) then {
            localNamespace setvariable ["O2A_PLAYER_Frame",_endFrame-1]; //esto no va aca
        };
    };

};
