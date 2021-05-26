return function()
  local tables = require(script.Parent.tables)
  local assign = tables.assign
  local augment = tables.augment

  describe("assign", function()
    describe("errors", function()
      it("should error when #args == 0", function()
        expect(function()
          assign()
        end).to.throw("Invalid argument")
      end)
      it("should error when args[1] ~= table", function()
        expect(function()
          assign(false)
        end).to.throw("Invalid argument")
      end)
    end)
    describe("success", function()
      describe("function return value", function()
        it("should return args[1] when args == {}", function()
          local tblA = {}
          expect(
            assign(tblA)
          ).to.equal(tblA)
        end)
        it("should return args[1] when args == {...}, {...}", function()
          local tblA = { valA1 = 1 }
          local tblB = { valB1 = 2 }
          local result = assign(tblA, tblB)
          expect(result).to.equal(tblA)
        end)
        it("should return args[1] when args == {...}, {...}, {...}", function()
          local tblA = { valA1 = 1 }
          local tblB = { valB1 = 2 }
          local tblC = { valC1 = 3 }
          local result = assign(tblA, tblB)
          expect(result).to.equal(tblA)
        end)
        it("should return args[1] with all args[1] properties", function()
          local tblA = { A = 1, B = 2, C = 3 }
          local result = assign(tblA)
          expect(result.A).to.equal(1)
          expect(result.B).to.equal(2)
          expect(result.C).to.equal(3)
        end)
        it("should return args[1] including new properties from args[2]", function()
          local tblA = { A = 1 }
          local tblB = { B = 2, C = 3, D = 4 }
          local result = assign(tblA, tblB)
          expect(result.A).to.equal(1)
          expect(result.B).to.equal(2)
          expect(result.C).to.equal(3)
          expect(result.D).to.equal(4)
        end)
        it("should return args[1] properties when args[2] == {}", function()
          local tblA = { A = 1 }
          local tblB = {}
          local result = assign(tblA, tblB)
          expect(result.A).to.equal(1)
        end)
        it("should return args[1] including overwritten properties from args[2]", function()
          local tblA = { valA1 = 1 }
          local tblB = { valA1 = 2 }
          local result = assign(tblA, tblB)
          expect(result.valA1).to.equal(2)
        end)
        it("should return args[1] including new properties from args[3]", function()
          local tblA = { valA1 = 1 }
          local tblB = { valB1 = 2 }
          local tblC = { valC1 = 3 }
          local result = assign(tblA, tblB, tblC)
          expect(result.valC1).to.equal(3)
        end)
        it("should return args[1] including overwritten properties from args[3]", function()
          local tblA = { valA1 = 1 }
          local tblB = { valB1 = 2 }
          local tblC = { valB1 = 3, valC1 = 3 }
          local result = assign(tblA, tblB, tblC)
          expect(result.valB1).to.equal(3)
          expect(result.valC1).to.equal(3)
        end)
        it("should ignore args ~= {...}", function()
          local tblA = { valA1 = 1 }
          local tblB = { valB1 = 2 }
          local result = assign(tblA, nil, 5, tblB)
          expect(result.valB1).to.equal(2)
        end)
        it("should not affect #args[1]", function()
          local tblA = { 1, 2, 3, 4 }
          local tblB = { valB1 = 2 }
          local result = assign(tblA, tblB)
          expect(#result).to.equal(4)
        end)
      end)
    end)
  end)
  describe("augment", function()
    describe("errors", function()
      it("should error when #args == 0", function()
        expect(function()
          augment()
        end).to.throw("Invalid argument")
      end)
      it("should error when args[1] ~= table", function()
        expect(function()
          augment(false)
        end).to.throw("Invalid argument")
      end)
    end)
    describe("success", function()
      describe("function return value", function()
        it("should return args[1] when args == {}", function()
          local tblA = {}
          expect(
            augment(tblA)
          ).to.equal(tblA)
        end)
        it("should return args when args = {...}, {...}", function()
          local tblA = { valA1 = 1 }
          local tblB = { valB1 = 2 }
          local result = augment(tblA, tblB)
          expect(result).to.equal(tblA)
        end)
        it("should return args when args = {...}, {...}, {...}", function()
          local tblA = { valA1 = 1 }
          local tblB = { valB1 = 2 }
          local tblC = { valC1 = 3 }
          local result = augment(tblA, tblB)
          expect(result).to.equal(tblA)
        end)
        it("should return args[1] with all args[1] properties", function()
          local tblA = { A = 1, B = 2, C = 3 }
          local result = augment(tblA)
          expect(result.A).to.equal(1)
          expect(result.B).to.equal(2)
          expect(result.C).to.equal(3)
        end)
        it("should return args[1] including new properties from args[2]", function()
          local tblA = { A = 1 }
          local tblB = { B = 2, C = 3, D = 4 }
          local result = augment(tblA, tblB)
          expect(result.A).to.equal(1)
          expect(result.B).to.equal(2)
          expect(result.C).to.equal(3)
          expect(result.D).to.equal(4)
        end)
        it("should return args[1] including properties not overwritten from args[2]", function()
          local tblA = { valA1 = 1 }
          local tblB = { valA1 = 2 }
          local result = augment(tblA, tblB)
          expect(result.valA1).to.equal(1)
        end)
        it("should return args[1] including new properties from args[3]", function()
          local tblA = { valA1 = 1 }
          local tblB = { valB1 = 2 }
          local tblC = { valC1 = 3 }
          local result = augment(tblA, tblB, tblC)
          expect(result.valC1).to.equal(3)
        end)
        it("should return args[1] including properties not overwritten from args[3]", function()
          local tblA = { valA1 = 1 }
          local tblB = { valB1 = 2 }
          local tblC = { valB1 = 3, valC1 = 3 }
          local result = augment(tblA, tblB, tblC)
          expect(result.valB1).to.equal(2)
          expect(result.valC1).to.equal(3)
        end)
        it("should ignore args ~= {...}", function()
          local tblA = { valA1 = 1 }
          local tblB = { valB1 = 2 }
          local result = augment(tblA, nil, 5, tblB)
          expect(result.valB1).to.equal(2)
        end)
        it("should not affect #args[1]", function()
          local tblA = { 1, 2, 3, 4 }
          local tblB = { valB1 = 2 }
          local result = augment(tblA, tblB)
          expect(#result).to.equal(4)
        end)
      end)
    end)
  end)
end