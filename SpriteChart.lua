-- Name: Sprite Chart
-- Author: Johnybot
-- Based on: Sprite Box from upsilandre

local consoleType = emu.getState()["consoleType"]
if consoleType ~= "Nes" then
  emu.displayMessage("Script", "This script only works on the NES.")
  return
end

spritesOnLine = {}
overflowColors = {
  0x88000088,
  0x880000FF,
  0x880088FF,
  0x8800FF88,
  0x8800FF00,
  0x8888FF00,
  0x88FF8800,
  0x88FF0000,
  0x00FF0000
}

function Main()
  for scanline = 0,254 do
    spritesOnLine[scanline] = 0
  end

  if emu.getState()["ppu.control.largeSprites"] then
    height = 16
  else
    height = 8
  end

  -- Collect scanline data
  for oamAddr = 0, 252, 4 do
    spriteY = emu.read(oamAddr, emu.memType.nesSpriteRam) + 1
    spriteX = emu.read(oamAddr + 3, emu.memType.nesSpriteRam)
    if spriteY < 240 then
      for i = 0, (height - 1 ) do
        spritesOnLine[spriteY + i] = spritesOnLine[spriteY + i] + 1
        emu.drawRectangle(spriteX, spriteY + i, 8, 1, overflowColors[math.min(spritesOnLine[spriteY + i], 9) - 0], true)
      end

      emu.drawRectangle(spriteX, spriteY, 8, 8, 0x88888888, false)
    end
  end
  -- Draw chart background
  emu.drawRectangle(0, 0, 9, 240, 0x22000000, true)
  emu.drawLine(0, 0, 0, 240, 0xCCFFFFFF, 1)
  emu.drawLine(2, 0, 2, 240, 0xCCFFFFFF, 1)
  emu.drawLine(4, 0, 4, 240, 0xCCFFFFFF, 1)
  emu.drawLine(6, 0, 6, 240, 0xCCFFFFFF, 1)
  emu.drawLine(8, 0, 8, 240, 0x88FFFFFF, 1)

  -- Draw Sprite Chart
  for scanline = 0,239 do
    overflow = spritesOnLine[scanline]
    if overflow > 0 then
      emu.drawLine(0, scanline, overflow, scanline, overflowColors[math.min(overflow, 9) - 0], 1)
  end
  end
end

emu.addEventCallback(Main, emu.eventType.startFrame)
emu.displayMessage("Script", "Sprite Count Checker")
