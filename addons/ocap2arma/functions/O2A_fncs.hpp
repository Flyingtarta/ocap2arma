class O2A {
  tag = "O2A";
  class O2Aplayer_init {
    file = "ocap2arma\functions";
    class player_init {postinit = 1};
    class edenButton  {};
  };

  class ui_fncs {
    //file = "ocap2arma\function\ui_fncs";
    file = "ocap2arma\functions\player\ui_fncs";
    class ui_launcher;
  };

  class Draw {
    file = "ocap2arma\functions\player\Draw";
    class draw_groupMarkers     {};
    class drawExplotion         {};
    class drawNames3d           {};
    class drawPlayerMapMarkers  {};
    class drawShots             {};
    class fisicalMarkers        {};
  };

  class Loaders {
    file = "ocap2arma\functions\player\loader";
    class loader_entities   {};
    class loader_explosives {};
    class loader_mapMarkers {};
  };

  class O2A_player{
    file = "ocap2arma\functions\player";
    class ocap2arma             {};
    class loadData              {};
    class mapMarkers            {};
    class nameToClassName       {};
    class objInFov              {};
    class player_preLoad        {};
    class player                {};
    class pre_init              {preinit =1};
  };



};
