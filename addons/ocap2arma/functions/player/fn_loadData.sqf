/*
Description:
  Funcntion who call all loader functions to create the needed vars:

    metaData (array):
      ["_name",       //(str) Mission name
      "_wolrdName",   //(str) Map
      "_totalFrames", //(str) Total Frames
      "_author",      //(str) Editor who created the mission
      "_timeStart",   //(str) time Data when the mission starts
      "_timeMultiply" //(str) Time aceleration
      ];

      EntitiesListData

      entityPositionalData

      explosiveData (array of arrays):
          #0 classname
          #1 startFrame
          #2 EndFrame
          #3 Direction
          #4 Positions 1 or 3 values : calculate parabola (?


      mapMarkers

*/

_BUFFER_SIZE = localNamespace getvariable ["O2A_VAR_BUFFER_SIZE",200];
systemchat format ["loading data from %1",file];
//get all metadata from the mission
metaData = ["ocap2arma.missionMetaData", [file] ] call py3_fnc_callExtension;
//if ( (metadata select 1) isNotEqualTo worldName) then { [] call O2A_FNC_player_preLoad}; // metaData = ["ocap2arma.missionMetaData", [file] ] call py3_fnc_callExtension; };

startLoadingScreen ["Loading data"];


/*
---------------------------------------
      Entities Data
---------------------------------------
*/
//load data in buffers to not exed 10M string length;

[] call O2A_fnc_loader_entities;

/*
---------------------------------------
      Explosives Data
---------------------------------------
*/
[] call O2A_fnc_loader_explosives;


progressLoadingScreen 0.66;

/*
---------------------------------------
      Map Markers Data
---------------------------------------
*/
[] call O2A_fnc_loader_mapMarkers;

progressLoadingScreen 1;
endLoadingScreen;
