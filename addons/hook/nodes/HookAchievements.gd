# MIT License
#
# Copyright (c) 2018 Matías Muñoz Espinoza
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# HookAchievements.gd
#

tool
extends "Hook.gd"

var achievements = []

func create_achievement(name, description, reward, texture_path, is_complete = false):
	var achievement = new_void_achievement()
	
	achievement["Name"] = name
	achievement["Description"] = description
	achievement["Reward"] = reward
	achievement["TexturePath"] = texture_path
	achievement["IsCompleted"] = is_complete
	
	achievements.append(achievement)

func search_achievement_by_name(achievement_name):
	for i in achievements.size():
		if achievements[i]["Name"] == achievement_name:
			return achievements[i]

func new_void_achievement():
	return {
		"Name" : "",
		"Description" : "",
		"Reward" : "",
		"TexturePath" : "",
		"IsCompleted" : ""
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	