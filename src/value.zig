const std = @import("std");
const Allocator = std.mem.Allocator;
const ArrayList = std.ArrayList;

pub const Value = f64;
pub const ValueArray = struct {
    list: ArrayList(Value),

    pub fn init(valueArray: *ValueArray) void {
        valueArray.list = .empty;
    }

    pub fn write(valueArray: *ValueArray, allocator: Allocator, value: Value) !void {
        try valueArray.list.append(allocator, value);
    }

    pub fn free(valueArray: *ValueArray, allocator: Allocator) void {
        valueArray.list.deinit(allocator);
    }
};

pub fn printValue(value: Value) void {
    std.debug.print("{d}", .{value});
}
