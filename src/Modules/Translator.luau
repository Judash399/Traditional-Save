--!nocheck

--Modules
local Error = require(script.Parent.Modules.Utils.Error)

local Translator = {}

local Translations = {
    Vector3 = {
        Encode = function(Object: Vector3)
            return {X = Object.X, Y = Object.Y, Z = Object.Z}
        end,
        Decode = function(Data)
            return Vector3.new(Data.X, Data.Y, Data.Z)
        end
    },
    Vector2 = {
        Encode = function(Object: Vector2)
            return {X = Object.X, Y = Object.Y}
        end,
        Decode = function(Data)
            return Vector2.new(Data.X, Data.Y)
        end
    },
    CFrame = {
        Encode = function(Object: CFrame)
            local components = {Object:GetComponents()}
            return components
        end,
        Decode = function(Data)
            return CFrame.new(table.unpack(Data))
        end
    },
    BrickColor = {
        Encode = function(Object: BrickColor)
            return Object.Number
        end,
        Decode = function(Data)
            return BrickColor.palette(Data)
        end
    },
    Color3 = {
        Encode = function(Object: Color3)
            return {R = Object.R, G = Object.G, Object.B}
        end,
        Decode = function(Data)
            return Color3.new(Data.R, Data.G, Data.B)
        end
    },
    UDim = {
        Encode = function(Object: UDim)
            return {Object.Scale, Object.Offset}
        end,
        Decode = function(Data)
            return UDim.new(Data[1], Data[2])
        end
    },
    UDim2 = {
        Encode = function(Object: UDim2)
            return {X = {Object.X.Scale, Object.X.Offset}, Y = {Object.Y.Scale, Object.Y.Offset}}
        end,
        Decode = function(Data)
            return UDim2.new(Data.X[1], Data.X[2], Data.Y[1], Data.Y[2])
        end
    }
}

local function EncodeObject(Object): any
    local ObjectType = typeof(Object)

    local Translation = Translations[ObjectType]

    if not Translation then
        Error(`Attempt to save Roblox Object of type '{ObjectType}' which does not have a translation! If you belive this object should have a translation, make a issue on the github.`)
    end

    local data = Translation.Encode(Object)

    return {
        ___TranslatorTypeInfo = ObjectType,
        data = data
    }
end

local function DecodeObject(Object): any
    local ObjectType = Object.___TranslatorTypeInfo

    local Translation = Translations[ObjectType]

    if not Translation then
        Error(`Attempt to save Roblox Object of type '{ObjectType}' which does not have a translation! If you belive this object should have a translation, make a issue on the github.`)
    end

    return Translation.Decode(Object.data)
end

function Translator:Encode(Data: any)
    
end

function Translator:Decode(Data: any)
    
end

Translator = {}