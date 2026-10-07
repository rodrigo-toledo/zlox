const std = @import("std");
const Chunk = @import("chunk.zig").Chunk;
const OpCode = @import("chunk.zig").OpCode;

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
