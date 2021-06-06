return function()
  local testState = { instances = {} }

  describe("Helpfully", function()
    beforeAll(function()
      testState.instances.scripts = game:GetService("ReplicatedStorage")
        :FindFirstChild("Scripts", false)

      testState.instances.Helpfully = testState.instances.scripts
        :FindFirstChild("Helpfully", false)

      testState.Helpfully = require(testState.instances.Helpfully)
    end)

    describe ("test setup", function()
      it("should find ReplicatedStorage.Scripts", function()
        expect(testState.instances.scripts).never.to.equal(nil)
      end)

      it("should find Helpfully", function()
        expect(testState.instances.Helpfully).never.to.equal(nil)

        expect(testState.instances.Helpfully.ClassName).to.equal(
          'ModuleScript')
      end)

      it("should be able to require Helpfully", function()
        expect(type(testState.Helpfully)).to.equal('table')
      end)
    end)

    describe("require", function()
      it("should have debug module", function()
        expect(testState.Helpfully.debug).to.equal(
          require(testState.instances.Helpfully
            :FindFirstChild("debug", false)))
      end)

      it("should have functions module", function()
        expect(testState.Helpfully.functions).to.equal(
          require(testState.instances.Helpfully
            :FindFirstChild("functions", false)))
      end)

      it("should have Logger module", function()
        expect(testState.Helpfully.Logger).to.equal(
          require(testState.instances.Helpfully
            :FindFirstChild("Logger", false)))
      end)

      it("should have paths module", function()
        expect(testState.Helpfully.paths).to.equal(
          require(testState.instances.Helpfully
            :FindFirstChild("paths", false)))
      end)

      it("should have tables module", function()
        expect(testState.Helpfully.tables).to.equal(
          require(testState.instances.Helpfully
            :FindFirstChild("tables", false)))
      end)
    end)
  end)
end
