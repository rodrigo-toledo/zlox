const std = @import("std");
const Allocator = std.mem.Allocator;
const ArrayList = std.ArrayList;

pub const OpCode = enum(u8) {
    OP_RETURN,
};

pub const Chunk = struct {
    list: ArrayList(u8),

    pub fn init(chunk: *Chunk) void {
        chunk.list = .empty;
    }

    pub fn write(chunk: *Chunk, allocator: Allocator, byte: OpCode) !void {
        try chunk.list.append(allocator, @backingInt(byte));
    }

    pub fn free(chunk: *Chunk, allocator: Allocator) void {
        chunk.list.deinit(allocator);
    }
};
