-- test/test_universal.lua
local jit = require('jit')
local ffi = require('ffi')

print("=== LuaJIT Test ===")
print("LuaJIT version: " .. jit.version)
print("Architecture: " .. jit.arch)
print("OS: " .. jit.os)

-- Test basic Lua functionality
print("\n=== Testing Lua Functionality ===")
local function factorial(n)
    if n <= 1 then return 1 end
    return n * factorial(n - 1)
end

local result = factorial(10)
print("factorial(10) = " .. result)
assert(result == 3628800, "Factorial test failed!")

-- Test table operations
local t = {1, 2, 3, 4, 5}
local sum = 0
for _, v in ipairs(t) do
    sum = sum + v
end
print("sum(1..5) = " .. sum)
assert(sum == 15, "Table test failed!")

-- Test FFI
print("\n=== Testing FFI ===")
ffi.cdef[[
    int printf(const char *fmt, ...);
]]
ffi.C.printf("FFI printf test: %s\n", "SUCCESS")

-- Test string operations
print("\n=== Testing String Operations ===")
local s = "Hello, LuaJIT!"
print("String test: " .. s:upper())

-- Test JIT library functions
print("\n=== Testing JIT Library ===")
for i=1,10 do
    local x = i * 2
end

print("\n=== All Tests Passed! ===")
print("Architecture confirmed: " .. jit.arch)
