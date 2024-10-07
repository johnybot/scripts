-- Name: vblank
-- Author: Johnybot

-- This script gives a histogram of the vblank time utilization.
-- It also provides a utilization average and a count of lag frames
-- I find this useful to visualize how much of vblank you are using each frame
local consoleType = emu.getState()["consoleType"]
if consoleType ~= "Nes" then
  emu.displayMessage("Script", "This script only works on the NES.")
  return
end

-- Should be a power of 2
numberOfRecords = 64
-- Height of the chart
height = 50
chartColors = {
  0x44388E3C,
  0x44388E3C,
  0x44388E3C,
  0x44388E3C,
  0x44689F38,
  0x44AFB42B,
  0x44FBC02D,
  0x44FFA000,
}

width = 256 / numberOfRecords
nmiStartedCycle = nil
ppuCycleCount = nil
counts={}
lagFrames = 0

function ppuScrollCallback(address, value)
  -- Check if the NMI has started
  if (nmiStartedCycle)
  then
    -- Save the last update to the scroll value
    ppuCycleCount = emu.getState()["cpu.cycleCount"] - nmiStartedCycle
  end
end

function nmiCallback()
  -- record the start of the NMI
  nmiStartedCycle = emu.getState()["cpu.cycleCount"]
end

function frameCallback()
  emu.clearScreen()
  -- Grey background
  emu.drawRectangle(0, 0, 256, height, 0x44222222, true)
  -- Draw divider lines to help visually measure
  emu.drawLine(0, height/4, 256, height/4, 0xCCFFFFFF)
  emu.drawLine(0, height/2, 256, height/2, 0xCCFFFFFF)
  emu.drawLine(0, height/4*3, 256, height/4*3, 0xCCFFFFFF)
  emu.drawLine(0, height, 256, height, 0x44FFFFFF)
  -- Check for data before addding a record
  if (ppuCycleCount and nmiStartedCycle)
  then
    -- new frame - start of NMI = total time of vblank
      now = emu.getState()["cpu.cycleCount"]
      vblankTime = now - nmiStartedCycle
      -- Insert the percentage into the table
    table.insert(counts, 1, ppuCycleCount / vblankTime)
  else
    -- Missed a frame, count it as 100%
    table.insert(counts, 1, 1)
    lagFrames = lagFrames + 1
  end
  
  total = 0
  for k, value in pairs(counts) do
    -- Round to a integer between 0 and height
    valueHeight = math.floor((value * height) + 0.5)
    -- Keep track of totals to use in the average calculation
    total = total + value
    -- Pick a good color
    if (valueHeight >= height)
    then
      color = 0x00FF0000
    else
      color = chartColors[math.floor(value * #chartColors) + 1]
    end
    -- Draw the bar
    if (k ~= 1)
    then
      emu.drawRectangle(256 - ((k - 1) * width), 0, width, valueHeight, color, true)
    end
  end
  -- Draw the average and Lag frame counter
  if (total)
  then
    emu.drawRectangle(8, 8, 64, 24, 0x44222222, true, 1)
    emu.drawRectangle(8, 8, 64, 24, 0x44222222, false, 1)
    emu.drawString(10, 10, "Avg: " .. math.floor(total / #counts * 100) .. "%", 0xFFFFFF, 0xFF000000)
    emu.drawString(10, 22, "Lag: " .. lagFrames, 0xFFFFFF, 0xFF000000)
  end
  -- Remove the old records
  if (#counts > numberOfRecords)
  then
    table.remove(counts, numberOfRecords + 1)
  end
  -- Reset the variables
  ppuCycleCount = nil
  nmiStartedCycle = nil
end
emu.addMemoryCallback(ppuScrollCallback, emu.callbackType.write, 0x2005)
emu.addEventCallback(nmiCallback, emu.eventType.nmi)
emu.addEventCallback(frameCallback, emu.eventType.startFrame)
