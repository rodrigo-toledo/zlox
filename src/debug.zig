const std = @import("std");
const Chunk = @import("chunk.zig").Chunk;
const OpCode = @import("chunk.zig").OpCode;

const value = @import("value.zig");

pub fn disassembleChunk(chunk: Chunk, name: []const u8) void {
    std.debug.print("== {s} ==\n", .{name});

    var i: usize = 0;
    while (i < chunk.list.items.len) { //TODO: Check off by one

        i = disassembleInstruction(chunk, i);
    }
}
fn disassembleInstruction(chunk: Chunk, offset: usize) usize {
    std.debug.print("{d:0>4} ", .{offset});

    const instruction = chunk.list.items[offset];
    switch (instruction) {
        @backingInt(OpCode.OP_CONSTANT) => {
            return constantInstruction(@tagName(OpCode.OP_CONSTANT), chunk, offset);
        },
        @backingInt(OpCode.OP_RETURN) => {
            return simpleInstruction(@tagName(OpCode.OP_RETURN), offset);
        },
        else => {
            std.debug.print("Unknown opcode {d}\n", .{instruction});
            return offset + 1;
        },
    }
}

fn simpleInstruction(name: []const u8, offset: usize) usize {
    std.debug.print("{s}\n", .{name});
    return offset + 1;
}

fn constantInstruction(name: []const u8, chunk: Chunk, offset: usize) usize {
    const constant = chunk.list.items[offset + 1];
    std.debug.print("{s:<16} {d:>4} '", .{ name, constant });
    value.printValue(chunk.valueArray.list.items[constant]);
    std.debug.print("'\n", .{});
    return offset + 2;
}
