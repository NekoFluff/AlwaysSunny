
-- Always Sunny Mod
selectedTimeIndex = 2 -- Default Daytime
local times = {"SunRiseDelay", "DayTimeDelay", "SunSetDelay", "NightTimeDelay"}


function SteamDetails()

  -- Setting of Steam details

  ModBase.SetSteamWorkshopDetails("Always Sunny", [[
    It's always sunny! Make sure to put on sunscreen!

    You can also  make it always night or always sunset or always sunrise. 
    Change the default time of day from Main Menu -> Mods -> Options

   (Due to modding limitations, this mod actually just makes the duration of the selected time really long and the duration of the other times really short. It shouldn't really be noticable though.)

    1 = Sunrise
    2 = Day time
    3 = Sunset
    4 = Night time

    Feel free to reach out
    Discord: TruthOrLie#6974
    
  ]], {"sunny", "time"}, "sun.png")
  
end


-- I wanted to be able to press L and change the time of day in-game, but because I can only set corresponding variables once
-- in the function BeforeLoad(), this is currently not possible. Hence the registration for input presses is commented out.
function Expose()

	-- Exposed variables
  -- ModBase.RegisterForInputPress(InputCallback)
  ModBase.ExposeVariable("Time of Day", selectedTimeIndex, TimeOfDayCallback, 1, 4)

end


function TimeOfDayCallback( param )

  if param == nil then
    -- ModDebug.Log("Param nil")
  else
    -- ModDebug.Log("Param not nil ", param)
    selectedTimeIndex = math.floor(param)
  end

end


-- When the period button is pressed, change the time of day
function InputCallback( param )

  -- ModDebug.Log("Always Sunny - InputCallback ", param)
  if (param == "L") then 
    -- ModDebug.Log("Always Sunny - Update")
    selectedTimeIndex = (selectedTimeIndex % #times) + 1
    SetTime()
  end
  
end


function BeforeLoad()

  SetTime()  

end


-- Changes the time of day.
function SetTime() 
  ModDebug.Log("Always Sunny - Set time to ", selectedTimeIndex, " or ", times[selectedTimeIndex])
  for index=1, #times do
    
    if index == selectedTimeIndex then
      -- ModDebug.Log("Time Enabled ", index)
      ModVariable.SetVariable(times[index], 99999999) -- Enable
    else
      -- ModDebug.Log("Time Disabled ", index)
      ModVariable.SetVariable(times[index], 0) -- Disable
    end
  end

end