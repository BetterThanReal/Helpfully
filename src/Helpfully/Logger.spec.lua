return function()
  local Logger = require(script.Parent.Logger)

  describe("()", function()
    describe("errors", function()
      it("should error when args[1] ~= table or nil", function()
        expect(function()
          Logger(false)
        end).to.throw("Invalid argument")
      end)
      it("should error when 'level' property of args[1] ~= number, string or nil", function()
        expect(function()
          Logger({ level = false })
        end).to.throw("Invalid property")
      end)
      it("should error when 'name' property of args[1] ~= string or nil", function()
        expect(function()
          Logger({ name = false })
        end).to.throw("Invalid property")
      end)
      it("should error when 'onLogFn' property of args[1] ~= function or nil", function()
        expect(function()
          Logger({ onLogFn = false })
        end).to.throw("Invalid property")
      end)
    end)
    describe("success", function()
      describe("function return value", function()
        local logger = Logger()
        it("should return function 'critical'", function()
          expect(
            typeof(logger.critical)
          ).to.equal("function")
        end)
        it("should return function 'debug'", function()
          expect(
            typeof(logger.debug)
          ).to.equal("function")
        end)
        it("should return function 'error'", function()
          expect(
            typeof(logger.error)
          ).to.equal("function")
        end)
        it("should return function 'fatal'", function()
          expect(
            typeof(logger.fatal)
          ).to.equal("function")
        end)
        it("should return function 'info'", function()
          expect(
            typeof(logger.info)
          ).to.equal("function")
        end)
        it("should return function 'verbose'", function()
          expect(
            typeof(logger.verbose)
          ).to.equal("function")
        end)
        it("should return function 'warn'", function()
          expect(
            typeof(logger.warn)
          ).to.equal("function")
        end)
        it("should return table 'LOG_LEVEL'", function()
          expect(
            typeof(logger.LOG_LEVEL)
          ).to.equal("table")
        end)
        it("should return a callable table", function()
          expect(
            typeof(logger())
          ).to.equal("table")
        end)
      end)
      describe("function side effects", function()
        it("should invoke onLogFn", function()
          local isCalled = false

          local logger = Logger({
            level = "info",
            onLogFn = function() isCalled = true; return 5 end })

          expect(
            logger.info()
          ).to.equal(5)
          expect(
            isCalled
          ).to.equal(true)
        end)
        it("should invoke onLogFn when log level is adequate", function()
          local isCalled = false

          local logger = Logger({
            level = "info",
            onLogFn = function() isCalled = true; return 5 end })

          expect(
            logger.info()
          ).to.equal(5)
          expect(
            isCalled
          ).to.equal(true)
        end)
        it("should not invoke onLogFn when log level is inadequate", function()
          local isCalled = false

          local logger = Logger({
            level = "info",
            onLogFn = function() isCalled = true; return 5 end })

          expect(
            logger.verbose()
          ).to.equal(nil)
          expect(
            isCalled
          ).to.equal(false)
        end)
        it("should report name appropriately", function()
          local logger = Logger({
            level = "info",
            name = "testLogger",
            onLogFn = function(logLevel, name, msg) return name end })

          expect(
            string.find(logger.info(), "testLogger")
          ).never.to.equal(nil)
        end)
        it("should report log level label appropriately", function()
          local logger = Logger({
            level = "info",
            onLogFn = function(logLevel) return logLevel end })

          expect(
            string.find(logger.info(), "INFO")
          ).never.to.equal(logger.LOG_LEVEL.INFO)
        end)
        it("should report log message appropriately", function()
          local logger = Logger({
            level = "info",
            onLogFn = function(logLevel, prefix, msg) return msg end })

          expect(
            logger.info("testLogger")
          ).to.equal("testLogger")
        end)
      end)
    end)
  end)
end