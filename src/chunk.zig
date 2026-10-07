const std = @import("std");
const Allocator = std.mem.Allocator;
const ArrayList = std.ArrayList;
const Value = @import("value.zig").Value;
const ValueArray = @import("value.zig").ValueArray;

pub const OpCode = enum(u8) {
    OP_CONSTANT,
    OP_RETURN,
};

pub const Chunk = struct {
    list: ArrayList(u8),
    valueArray: ValueArray,

    pub fn init(chunk: *Chunk) void {
        chunk.list = .empty;
        chunk.valueArray.init();
    }

    pub fn write(chunk: *Chunk, allocator: Allocator, byte: u8) !void {
        try chunk.list.append(allocator, byte);
    }

    pub fn free(chunk: *Chunk, allocator: Allocator) void {
        chunk.list.deinit(allocator);
        chunk.valueArray.free(allocator);
    }

    pub fn addConstant(chunk: *Chunk, allocator: Allocator, value: Value) !u8 {
        try chunk.valueArray.write(allocator, value);
        return @intCast(chunk.valueArray.list.items.len - 1);
    }
};
