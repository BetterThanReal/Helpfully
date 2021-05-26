return function()
  local paths = require(script.Parent.paths)
  local findByPath = paths.findByPath
  local findChildByPath = paths.findChildByPath
  local separatedPath = paths.separatedPath

  describe("findByPath", function()
    describe("errors", function()
      it("should error when args[1] ~= string", function()
        expect(function()
          findByPath(false, "")
        end).to.throw("Invalid argument")
      end)
      it("should error when args[1][1] ~= ':'", function()
        expect(function()
          findByPath("invalid", "")
        end).to.throw("Invalid argument")
      end)
    end)
    describe("success", function()
      describe("function return value", function()
        it("should return nil when #args == 0", function()
          expect(
            findByPath()
          ).to.equal(nil)
        end)
        it("should return nil, 'invalid' when args = ':invalid', '.'", function()
          local instance, subpath = findByPath(":invalid", ".")
          expect(
            instance
          ).to.equal(nil)
          expect(
            subpath
          ).to.equal("invalid")
        end)
        it("should return ReplicatedStorage when args = ':ReplicatedStorage', '.'", function()
          local instance, subpath = findByPath(":ReplicatedStorage", ".")
          expect(
            instance
          ).to.equal(game.ReplicatedStorage)
          expect(
            subpath
          ).to.equal(nil)
        end)
        it("should return ReplicatedStorage when args = game, '%:ReplicatedStorage', '.'", function()
          local instance, subpath = findChildByPath(
            game, "%:ReplicatedStorage", ".")
          expect(
            instance
          ).to.equal(game.ReplicatedStorage)
          expect(
            subpath
          ).to.equal(nil)
        end)
        it("should return ReplicatedStorage.Scripts when args = ':ReplicatedStorage.Scripts', '.'", function()
          local instance, subpath = findByPath(
            ":ReplicatedStorage.Scripts", ".")
          expect(
            instance
          ).to.equal(game.ReplicatedStorage.Scripts)
          expect(
            subpath
          ).to.equal(nil)
        end)
        it("should return ReplicatedStorage.Scripts when args = ':ReplicatedStorage%Scripts', '%'", function()
          local instance, subpath = findByPath(
            ":ReplicatedStorage%Scripts", "%")
          expect(
            instance
          ).to.equal(game.ReplicatedStorage.Scripts)
          expect(
            subpath
          ).to.equal(nil)
        end)
        it("should return nil, 'ReplicatedStorage.Scripts' when args = ':ReplicatedStorage%.Scripts', '.'", function()
          local instance, subpath = findByPath(
            ":ReplicatedStorage%.Scripts", ".")
          expect(
            instance
          ).to.equal(nil)
          expect(
            subpath
          ).to.equal("ReplicatedStorage.Scripts")
        end)
        it("should return nil, 'Invalid' when args = ':ReplicatedStorage.Invalid', '.'", function()
          local instance, subpath = findByPath(
            ":ReplicatedStorage.Invalid", ".")
          expect(
            instance
          ).to.equal(nil)
          expect(
            subpath
          ).to.equal("Invalid")
        end)
      end)
    end)
  end)
  describe("findChildByPath", function()
    describe("errors", function()
      it("should error when #args == 0", function()
        expect(function()
          findChildByPath()
        end).to.throw("Invalid argument")
      end)
      it("should error when args[1] ~= Instance", function()
        expect(function()
          findChildByPath(false)
        end).to.throw("Invalid argument")
      end)
      it("should error when args[2] ~= string", function()
        expect(function()
          findByPath(game, false)
        end).to.throw("Invalid argument")
      end)
    end)
    describe("success", function()
      describe("function return value", function()
        it("should return ReplicatedStorage when args = game, ':ReplicatedStorage', '.'", function()
          local instance, subpath = findChildByPath(
            game, ":ReplicatedStorage", ".")
          expect(
            instance
          ).to.equal(game.ReplicatedStorage)
          expect(
            subpath
          ).to.equal(nil)
        end)
        it("should return ReplicatedStorage when args = game, '%:ReplicatedStorage', '.'", function()
          local instance, subpath = findChildByPath(
            game, "%:ReplicatedStorage", ".")
          expect(
            instance
          ).to.equal(game.ReplicatedStorage)
          expect(
            subpath
          ).to.equal(nil)
        end)
        it("should return ReplicatedStorage.Script when args = ReplicatedStorage, 'Scripts', '.'", function()
          local instance, subpath = findChildByPath(
            game.ReplicatedStorage, "Scripts", ".")
          expect(
            instance
          ).to.equal(game.ReplicatedStorage.Scripts)
          expect(
            subpath
          ).to.equal(nil)
        end)
        it("should return ReplicatedStorage.Script.Helpfully when args = ReplicatedStorage, 'Scripts.Helpfully', '.'", function()
          local instance, subpath = findChildByPath(
            game.ReplicatedStorage, "Scripts.Helpfully", ".")
          expect(
            instance
          ).to.equal(game.ReplicatedStorage.Scripts.Helpfully)
          expect(
            subpath
          ).to.equal(nil)
        end)
        it("should return nil, 'Invalid' when args = ReplicatedStorage, 'Scripts.Invalid', '.'", function()
          local instance, subpath = findChildByPath(
            game.ReplicatedStorage, "Scripts.Invalid", ".")
          expect(
            instance
          ).to.equal(nil)
          expect(
            subpath
          ).to.equal("Invalid")
        end)
      end)
    end)
  end)
  describe("separatedPath", function()
    describe("errors", function()
      it("should error when args[1] ~= string", function()
        expect(function()
          separatedPath(false, "")
        end).to.throw("Invalid argument")
      end)
      it("should error when args[2] ~= string or nil", function()
        expect(function()
          separatedPath("", false)
        end).to.throw("Invalid argument")
      end)
      it("should error when #args[2] < 1", function()
        expect(function()
          separatedPath("", "")
        end).to.throw("Invalid argument")
      end)
      it("should error when #args[2] > 1", function()
        expect(function()
          separatedPath("", "invalid")
        end).to.throw("Invalid argument")
      end)
      it("should error when args[1] contains \\b", function()
        expect(function()
          separatedPath("[\\b]", "")
        end).to.throw("Invalid argument")
      end)
      it("should error when args[2] contains \\b", function()
        expect(function()
          separatedPath("", "[\\b]")
        end).to.throw("Invalid argument")
      end)
    end)
    describe("success", function()
      describe("function return value", function()
        it("should return {} when #args == 0", function()
          local table = separatedPath()
          expect(
            typeof(table)
          ).to.equal("table")
          expect(
            #table
          ).to.equal(0)
        end)
        it("should return 'test' when args = 'test', ':'", function()
          expect(
            table.concat(separatedPath("test", ":"), ",")
          ).to.equal("test")
        end)
        it("should return ['a'] when args = 'a:', ':'", function()
          expect(
            table.concat(separatedPath("a:", ":"), ",")
          ).to.equal("a")
        end)
        it("should return ['a'] when args = ':a', ':'", function()
          expect(
            table.concat(separatedPath(":a", ":"), ",")
          ).to.equal("a")
        end)
        it("should return ['a'] when args = ':a:', ':'", function()
          expect(
            table.concat(separatedPath(":a:", ":"), ",")
          ).to.equal("a")
        end)
        it("should return ['a','b'] when args = 'a:b', ':'", function()
          expect(
            table.concat(separatedPath("a:b", ":"), ",")
          ).to.equal("a,b")
        end)
        it("should return ['a','b'] when args = ':a:b:', ':'", function()
          expect(
            table.concat(separatedPath(":a:b:", ":"), ",")
          ).to.equal("a,b")
        end)
        it("should return ['a','b','c'] when args = 'a:b:c', ':'", function()
          expect(
            table.concat(separatedPath("a:b:c", ":"), ",")
          ).to.equal("a,b,c")
        end)
        it("should return ['a:b'] when args = 'a%:b', ':'", function()
          expect(
            table.concat(separatedPath("a%:b", ":"), ",")
          ).to.equal("a:b")
        end)
        it("should return ['a:b','b'] when args = 'a%:b:b', ':'", function()
          expect(
            table.concat(separatedPath("a%:b:b", ":"), ",")
          ).to.equal("a:b,b")
        end)
        it("should return ['a','b','c'] when args = 'a%b%c', '%'", function()
          expect(
            table.concat(separatedPath("a%b%c", "%"), ",")
          ).to.equal("a,b,c")
        end)
      end)
    end)
  end)
end