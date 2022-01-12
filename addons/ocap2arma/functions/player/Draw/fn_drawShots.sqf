/*
  Draws a line of shots 

*/
addMissionEventHandler ["Draw3D",{

        _O2AFrame = localNamespace getvariable ["O2A_PLAYER_Frame",0];
        _BUFFER_SIZE = localNamespace getvariable ["O2A_VAR_BUFFER_SIZE",200];
        _buffer = floor (_O2AFrame/_BUFFER_SIZE);
        _framesData = entityPositionalData select _buffer;
        _frameInfo = _framesData get _O2AFrame;

        {

                _entityData = _x;
                if ( count (EntitiesListData get (_x#0)) isnotequalto 4 ) then {

                        _entityData params [
                            "_id",
                            "_position",
                            "_direction",
                            "_firing",
                            "_posFired",
                            "_alive",
                            "_invehicle"
                        ];
                        (EntitiesListData get _id) params [
                            "_name",
                            "_group",
                            "_isplayer",
                            "_rol",
                            "_side",
                            "_type"
                        ];
                        if (_firing) then { //if is firing
                                _posE = (asltoagl _position) vectoradd [0,0,1.5]; //simulate weapon hight
                                _posF = asltoagl _posFired;
                                if ( _side isequalto "EAST" ) then { drawLine3D [_posE , _posF , [0.8,0,0,0.6] ] };
                                if ( _side isequalto "WEST" ) then { drawLine3D [_posE , _posF , [0,0,0.8,0.6] ] };
                                if ( _side isequalto "GUER" ) then { drawLine3D [_posE , _posF , [0.8,0,1,0.6] ] };
                        };
                };

        }foreach _frameInfo;//entities data
}];



/*
if (_firing) then { //if is firing
        _posE = (asltoagl _position) vectoradd [0,0,1.5]; //simulate weapon hight
        _posFinal = asltoagl _posFired;
        _color = [0.8,0,0,0.6];
        if ( _side isequalto "EAST" ) then { _color = [0.8,0,0,0.6]};
        if ( _side isequalto "WEST" ) then { _color = [0,0,0.8,0.6]};
        if ( _side isequalto "GUER" ) then { _color = [0.8,0,1,0.6]};
        [_position,_posFinal,_color] spawn {
                params ["_position","_posFinal","_color"];

                for "_i" from 0 to 5 do {
                        _posE = (asltoagl _position) vectoradd [0,0,1.5]; //simulate weapon hight
                        _posF = vectorLinearConversion [0,5,_i,_posE,_posFinal];
                        drawLine3D [_posE , _posF ,  _color ];
                };
        };

};
*/
