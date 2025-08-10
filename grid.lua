-- Name: grid
-- Author: Johnybot

function drawSafeArea()
  emu.drawLine(0, 16 * 1 , 256, 16 *  1, 0xDDFFFFFF)
  emu.drawLine(0, 16 * 2 , 256, 16 *  2, 0xDDFFFFFF)
  emu.drawLine(0, 16 * 3 , 256, 16 *  3, 0xDDFFFFFF)
  emu.drawLine(0, 16 * 4 , 256, 16 *  4, 0xDDFFFFFF)
  emu.drawLine(0, 16 * 5 , 256, 16 *  5, 0xDDFFFFFF)
  emu.drawLine(0, 16 * 6 , 256, 16 *  6, 0xDDFFFFFF)
  emu.drawLine(0, 16 * 7 , 256, 16 *  7, 0xDDFFFFFF)
  emu.drawLine(0, 16 * 8 , 256, 16 *  8, 0xDDFFFFFF)
  emu.drawLine(0, 16 * 9 , 256, 16 *  9, 0xDDFFFFFF)
  emu.drawLine(0, 16 * 10, 256, 16 * 10, 0xDDFFFFFF)
  emu.drawLine(0, 16 * 11, 256, 16 * 11, 0xDDFFFFFF)
  emu.drawLine(0, 16 * 12, 256, 16 * 12, 0xDDFFFFFF)
  emu.drawLine(0, 16 * 13, 256, 16 * 13, 0xDDFFFFFF)
  emu.drawLine(0, 16 * 14, 256, 16 * 14, 0xDDFFFFFF)
  
  emu.drawLine(16 *  1, 0 , 16 *  1, 240, 0xDDFFFFFF)
  emu.drawLine(16 *  2, 0 , 16 *  2, 240, 0xDDFFFFFF)
  emu.drawLine(16 *  3, 0 , 16 *  3, 240, 0xDDFFFFFF)
  emu.drawLine(16 *  4, 0 , 16 *  4, 240, 0xDDFFFFFF)
  emu.drawLine(16 *  5, 0 , 16 *  5, 240, 0xDDFFFFFF)
  emu.drawLine(16 *  6, 0 , 16 *  6, 240, 0xDDFFFFFF)
  emu.drawLine(16 *  7, 0 , 16 *  7, 240, 0xDDFFFFFF)
  emu.drawLine(16 *  8, 0 , 16 *  8, 240, 0xDDFFFFFF)
  emu.drawLine(16 *  9, 0 , 16 *  9, 240, 0xDDFFFFFF)
  emu.drawLine(16 * 10, 0 , 16 * 10, 240, 0xDDFFFFFF)
  emu.drawLine(16 * 11, 0 , 16 * 11, 240, 0xDDFFFFFF)
  emu.drawLine(16 * 12, 0 , 16 * 12, 240, 0xDDFFFFFF)
  emu.drawLine(16 * 13, 0 , 16 * 13, 240, 0xDDFFFFFF)
  emu.drawLine(16 * 14, 0 , 16 * 14, 240, 0xDDFFFFFF)
  emu.drawLine(16 * 15, 0 , 16 * 15, 240, 0xDDFFFFFF)
end

emu.addEventCallback(drawSafeArea, emu.eventType.endFrame);
emu.displayMessage("Script", "grid")
