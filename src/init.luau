--!strict

--[[
Copyright 2025, Judash399
TraditionalSave: Version 2.2.0

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”),
to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
]]

local TraditionalSave2 = {}

--Services
local RunService = game:GetService("RunService")

--Modules
local Store = require(script.Store)
local Types = require(script.Types)
local Error = require(script.Utils.Error)

if RunService:IsClient() then
	Error("TraditionalSave2 is server only! don't require it on the client!")
end

--Type Definitions
export type StoreConfig = Types.StoreConfig
export type Store = Types.Store
export type Loader<T> = Types.Loader<T>
export type Profile<Methods> = Types.Profile<Methods>
export type Error = Types.Error
export type PlayerProfiles<Methods> = Types.PlayerProfiles<Methods>
export type MethodMap = Types.MethodMap
export type FileKey = Types.FileKey

function TraditionalSave2.GetStore(StoreName: string, Config: Types.StoreConfig?): Types.Store
	return Store.New(StoreName, Config)
end

return TraditionalSave2