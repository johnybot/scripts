-- Name: BgUpdate
-- Author: Johnybot

local consoleType = emu.getState()["consoleType"]
if consoleType ~= "Nes" then
  emu.displayMessage("Script", "This script only works on the NES.")
  return
end

xScroll = 0
yScroll = 0
nametable = 0
tileUpdates = {}
attrUpdates = {}

function ppuScrollCallback(address, value)
  w = emu.getState()["ppu.writeToggle"]
  if (w)
  then
    yScroll = value
  else
    xScroll = value
  end
end

function ppuControlCallback(address, value)
  nametable = value & 0x3
end

nametableToX = {0, 256, 0, 256}
nametableToY = {0, 0, 240, 240}

function writeCallback(address, value)
  ppuAddr = emu.getState()["ppu.videoRamAddr"]
  if ((0x2000 > ppuAddr) or (ppuAddr >= 0x3000))
  then
    return
  end
  old = emu.read(ppuAddr ,emu.memType.nesPpuMemory, false)
  modifiedAddr = ppuAddr & 0x03FF
  if ((0x0000 <= modifiedAddr) and (modifiedAddr < 0x03C0))
  then
    x = (modifiedAddr % 32) * 8
    y = (modifiedAddr >> 5) * 8
    
    table.insert(tileUpdates, {x, y})
        return
    else
    x = ((ppuAddr - 0x23C0) % 8) * 32
    y = ((ppuAddr - 0x23C0) >> 3) * 32
    
    table.insert(attrUpdates, {x, y})
        return
    end
end

function eventCallback()
  for k, v in pairs(attrUpdates) do
      emu.drawRectangle(
      (v[1] - nametableToX[nametable + 1] - xScroll) % 256,
      (v[2] - nametableToY[nametable + 1] - yScroll) % 240,
      32, 32, 0x88FFFF00, true, 1)
    emu.drawRectangle(
          (v[1] - nametableToX[nametable + 1] - xScroll) % 256,
          (v[2] - nametableToY[nametable + 1] - yScroll) % 240,
          32, 32, 0x88FFFF00, false, 1)
  end
  attrUpdates = {}
  for k, v in pairs(tileUpdates) do
      emu.drawRectangle(
      (v[1] - nametableToX[nametable + 1] - xScroll) % 256,
      (v[2] - nametableToY[nametable + 1] - yScroll) % 240,
      8, 8, 0x88FF0000, true, 1)
    emu.drawRectangle(
          (v[1] - nametableToX[nametable + 1] - xScroll) % 256,
          (v[2] - nametableToY[nametable + 1] - yScroll) % 240,
          8, 8, 0x88FF0000, false, 1)
  end
  tileUpdates = {}
end

emu.addMemoryCallback(writeCallback, emu.callbackType.write, 0x2007)
emu.addMemoryCallback(ppuScrollCallback, emu.callbackType.write, 0x2005)
emu.addMemoryCallback(ppuControlCallback, emu.callbackType.write, 0x2000)
emu.addEventCallback(eventCallback, emu.eventType.startFrame)
emu.displayMessage("Script", "Sprite Count Checker")
