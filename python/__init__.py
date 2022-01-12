
import gzip
import json
import math
import os

class Mission():

    def __init__(self,path):
        self.path = path
        self.ocapData = self.loader()
        name,totalFrames,wolrdName,author,timeStart,timeMultiply = self.MissionMetaData()
        self.name = name
        self.totalFrames = totalFrames
        self.wolrdName = wolrdName
        self.author = author

    def loader(self):
        try:

            return(globals()['ocapDataGLOBAL'])
            #frameTotales = globals()['framesTotalesGLOBAL']
        except:
            with gzip.open(self.path,"r") as data:
                ocapData = json.load(data)
                global ocapDataGLOBAL
                ocapDataGLOBAL = ocapData

                return(ocapDataGLOBAL)

    def MissionMetaData(self):
        """
            output:
                #0 mission name
                #1 Total Frames
                #2 Map
                #3 Author
                #4 time Start
                #5 timerMultiply
        """
        nombre = self.ocapData["missionName"]
        totalFrames = self.ocapData["endFrame"]
        wolrdName =self. ocapData['worldName']
        author = self.ocapData['missionAuthor']
        timeStart = self.ocapData["times"][0]["date"]
        timeMultiply = self.ocapData["times"][0]['timeMultiplier']
        return([nombre,totalFrames,wolrdName,author,timeStart,timeMultiply])

    def clean():
        try:
            global ocapDataGLOBAL
            del ocapDataGLOBAL
            return(True)
        except:
            return(False)


class ocap2Arma():
    def __init__(self,path):
        self.ocapData = Mission(path).ocapData
        self.path = path
        self.entitiesListData = self.EntityListData()
        self.entitiesPositionalData = self.entitiesPositionalData()
        self.ExplosivesData= self.ExplosivesData()
        #self.markerData = self.MarkersData()

    #def MarkerData():
    #    retunr([])

    def EntityListData(self):
        '''
            if unit:

            id,
            [          #0 ocapid
                name,       #0 EName
                gurpo,      #1 EGroup
                isplayer,   #2 EIsPlayer
                rol,        #3 ERol
                side,       #4 ESide
                type       #5 EType
            ]

            if vehicle:
                id,
                [
                    name,
                    class,
                    type
                ]


        '''
        ocapData = self.ocapData
        entities = ocapData["entities"]
        entityData = []
        for entity in entities:
            #if "isPlayer" in list(entity.keys()):

            if entity["type"]== "unit":
                id   =  entity["id"]
                name= entity["name"]
                group= entity["group"]
                isplayer= (entity["isPlayer"] == 1)
                rol= entity["role"]
                side= entity["side"]
                type =entity["type"]
                entityData.append([id,[name,group,isplayer,rol,side,type]])
            if entity["type"] == "vehicle":
                id   =  entity["id"]
                name= entity["name"]
                type = entity["type"]
                clase = entity["class"]
                entityData.append([id,[name,clase,type]])
        return(entityData)

    def entitiesPositionalData(self):
        #startFrame,endFrame = rangeFrames
        '''
        return:
            Array of arrays, one array per frame recorded
            [
                [
                    frame,[
                        [

                            id          #1 ocap id
                            position,   #2 Epos
                            direction   #3 Edir
                            firing,     #4 EFiring
                            posFired    #5 EPosFired
                            alive       #6 Ealive
                            invehicle   #7 EInVehicle
                        ]
                    ]
                ]
            ]
        '''
        try:
            return(globals()["entitiesPositionalData"])
        except:
            pass
        dataoutput = []
        framesTotales = Mission(self.path).totalFrames
        #if endFrame>framesTotales:
        #    endFrame=frameTotales

        for frame in range(0,framesTotales):
            EntityFramedData = [];
            for entity in self.ocapData["entities"]:
                startFrame = entity["startFrameNum"]
                isvehicle = ('vehicle' == entity["type"])

                if frame>=startFrame:
                    EName = entity["name"]
                    id = entity["id"]
                    EIsPlayer = False
                    Eside = ""
                    if not isvehicle:
                        EGroup = entity["group"]
                        #is player?
                        if entity["isPlayer"]>0:
                            Eisplayer = True
                        ERol = entity["role"]
                        ESide = entity["side"]
                        EType = entity["type"]
                        Edir = -1
                        if frame>=startFrame:
                            if frame < (len(entity["positions"])+startFrame):
                                Epos = entity["positions"][frame-startFrame-1][0]
                                Edir = entity["positions"][frame-startFrame-1][1]

                                Ealive = True
                                if entity["positions"][frame-startFrame-1][4] == "":
                                    Ealive = False

                                EInVehicle = False
                                if entity["positions"][frame-startFrame-1][3] == 1:
                                    EInVehicle = True
                            else:
                                Epos = [0,0,0]
                        else:
                            Epos = [0,0,0]

                        EFiring = False
                        EPosFired = []
                        #search for frame fired in fired array
                        for shot in entity["framesFired"]:
                            if shot[0] == frame:
                                EFiring = True
                                EPosFired = shot[1]

                        EntityData = [id,Epos,Edir,EFiring,EPosFired,Ealive,EInVehicle]
                        EntityFramedData.append(EntityData)
                    else:
                        #find current state in current frame
                        data = []
                        for posData in entity["positions"]:
                            beg,end = posData[-1]
                            if frame >= beg and frame <= end:
                                data = posData
                                break
                        if not data == []:
                            Epos, Edir,alive,crew,positionsFrame = data
                            Ealive = (alive > 0)
                            entityData = [id,Epos,Edir,crew,Ealive]
                            EntityFramedData.append(entityData)
            dataoutput.append([frame,EntityFramedData])

        global entitiesPositionalData
        entitiesPositionalData = dataoutput
        return(globals()["entitiesPositionalData"])

    def ExplosivesData(self):
        '''
        classname,startFrame,endFrame,direction,finalPositions


            return:
                #0 classname
                #1 startFrame
                #2 EndFrame
                #3 Direction
                #4 Positions 1 or 3 values
        '''
        def selectMaxZ(positions):

            max = [0,0,0]
            for pos in positions:
                posarr = pos[1]

                if len(posarr) ==2: #if its has no Z
                    return(pos[0])

                if posarr[2] > max [2]:
                    max = pos[1]
            return(max)

        ocapData = self.ocapData
        ExplosivesData = []
        for marker in ocapData["Markers"]:
            if not marker[1] == "" and "magIcons" in marker[0]:

                classname = marker[0].split("/")[1][:-4]
                startFrame = marker[2]
                endFrame = marker[3]
                positions = marker[7]

                direction = positions[0][2] #direction

                #process positions to make a parabola or just the end position
                startpos = positions[0]
                endpos = positions[-1]
                #print(marker)
                maxz = selectMaxZ(positions)
                if maxz ==startpos:
                    finalPositions = [endpos[1]]
                else:
                    finalPositions = [startpos[1],maxz,endpos[1]]

                ExplosivesData.append([classname,startFrame,endFrame,direction,finalPositions])

        return(ExplosivesData)

    def mapMarkersData(self):
        ocapData = self.ocapData
        '''
            array of arrays
            markerlist:
                ["MarkerId",
                    [
                        markerType,
                        markerText,
                        startFrame,
                        endFrame,
                        placerID,
                        color,
                        side,// side of placer (-1 for GLOBAL)
                        [ //positions
                            [
                                frame,(number)
                                posAGL,
                                markerDir, (0-360)
                                markerAlpha, (number)
                            ]
                        ],
                        markerSize (array [a,b]),
                        markerShape,
                        markerBrush
                    ]
                ]
        '''
        markerid = 1000
        markersData = []
        for mkdata in ocapData["Markers"]:

            if not ("magIcons" in mkdata[0] or 'triangle' in mkdata[0]):
                print(mkdata[0])
                markersData.append([markerid,mkdata])
                markerid = markerid +1
        return(markersData)

    def prepare2Export(arr):
        #subdivides the arrays so can be managed with pythia
        """
        preset = [1000,500,250,100]
        buffer = [[]]
        index = 0
        for idx, data in enumerate(arr):

            if len( str ( buffer[index] + data) ) < 9999900:
                buffer[index].append(data)
            else:
                buffer.append([])
                index = index + 1
                buffer[index].append(data)

        return(buffer)
        """

    def cleanVariables():
        pass

class preLoad():
    def __init__(self,path):
        self.path = path
        self.listGZ = self.listGzFiles()

    def listGzFiles(self):
        missionPath = self.path
        return(os.listdir(missionPath))




def entitiesListData(filename):
    """
    Description:
        Returns the entity list and fixed data from them

    input:
        filename
    output:
        array of arrays (one for each entity)
        [
            id          #0 ocapid
            name,       #1 EName
            gurpo,      #2 EGroup
            isplayer,   #3 EIsPlayer
            rol,        #4 ERol
            side,       #5 ESide
            type,       #6 EType
        ]

    """
    return( ocap2Arma(filename).entitiesListData)

def EntityPositionalData(filename,rangeFrames):
    '''
        input:
            startframe
            endframe


        return:
            [Array of Arrays] one Array per frame [frame number, [data] ]

            [
                [
                    frame, #number
                    [
                        [

                            id          #1 (number) ocap id
                            position,   #2 (array) Epos
                            direction   #3 (number)Edir
                            firing,     #4 (bool)EFiring
                            posFired    #5 (array) PosASL Fired
                            alive       #6 (bool) Ealive
                            invehicle   #7 (bool) EInVehicle
                        ]
                    ]
                ]
            ]
    '''

    start,end = rangeFrames
    return(ocap2Arma(filename).entitiesPositionalData[start:end])

def ExplosivesData(filename):
    '''
        classname,startFrame,endFrame,direction,finalPositions


        return:
            #0 classname
            #1 startFrame
            #2 EndFrame
            #3 Direction
            #4 Positions 1 or 3 values : calculate parabola (?
    '''

    return( (ocap2Arma(filename).ExplosivesData))

def missionMetaData(filename):
    '''
        output:
            #0 mission name
            #1 Total Frames
            #2 Map
            #3 Author
            #4 time Start
            #5 timerMultiply
    '''
    return(Mission(filename).MissionMetaData())

def mapMarkers(filename):
    return(ocap2Arma(filename).mapMarkersData())

def listJsonFiles(path): #chance to select the mission with a ui

    #try:
    gzs = []

    for f in preLoad(path).listGZ:
        if f.endswith(".gz"):
            gzs.append(f)
    return(gzs)
    #except:
    #    return([])

def cleanVariables():
    return(Mission.clean())




#pene = "C:\Users\Guido\Documents\Arma 3 - Other Profiles\Tarta\missions\TCAP\oseatiaParte2.cup_chernarus_A3"
#pene = raw(pene)
#print(listJsonFiles(peneErecto))
