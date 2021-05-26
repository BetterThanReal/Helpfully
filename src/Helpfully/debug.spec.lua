return function()
  local debug = require(script.Parent.debug)
  local getRefLabel = debug.getRefLabel
  local trimErrMsgLineNum = debug.trimErrMsgLineNum

  describe("getRefLabel", function()
    describe("success", function()
      describe("function return value", function()
        it("should return 'nil' when #args == 0", function()
          expect(
            getRefLabel()
          ).to.equal("nil")
        end)
        it("should return 'nil' when args[1] == nil", function()
          expect(
            getRefLabel(nil)
          ).to.equal("nil")
        end)
        it("should return 'false' when args[1] == false", function()
          expect(
            getRefLabel(false)
          ).to.equal("false")
        end)
        it("should return '<function>' when args[1] == function() end", function()
          expect(
            getRefLabel(function() end)
          ).to.equal("<function>")
        end)
        it("should return '5' when args[1] == 5", function()
          expect(
            getRefLabel(5)
          ).to.equal("5")
        end)
        it("should return '<Part> \"Part\"' when args[1] == Instance.new('Part')", function()
          expect(
            getRefLabel(Instance.new("Part"))
          ).to.equal("<Part> \"Part\"")
        end)
        it("should return '<Folder> \"Scripts\"' when args[1] == game.ReplicatedStorage.Scripts", function()
          expect(
            getRefLabel(game.ReplicatedStorage.Scripts)
          ).to.equal("<Folder> \"Scripts\"")
        end)
        it("should return '\"string\"' when args[1] == \"string\"", function()
          expect(
            getRefLabel("string")
          ).to.equal("\"string\"")
        end)
        it("should return '<table>' when args[1] == {}", function()
          expect(
            getRefLabel({})
          ).to.equal("<table>")
        end)
      end)
    end)
  end)
  describe("trimErrMsgLineNum", function()
    describe("success", function()
      describe("function return value", function()
        it("should return nil when #args == 0", function()
          expect(
            trimErrMsgLineNum()
          ).to.equal(nil)
        end)
        it("should return args[1] when args[1] ~= string", function()
          expect(
            trimErrMsgLineNum(false)
          ).to.equal(false)
        end)
        it("should return args[1] does not have line number", function()
          expect(
            trimErrMsgLineNum("don't modify me")
          ).to.equal("don't modify me")
        end)
        it("should return args[1] without line number", function()
          expect(
            trimErrMsgLineNum("stdin:1: don't modify me")
          ).to.equal("don't modify me")
        end)
      end)
    end)
  end)
end