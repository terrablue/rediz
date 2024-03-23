const std = @import("std");
const Builder = std.build.Builder;

pub fn build(b: *Builder) void {
    const target = b.standardTargetOptions(.{});

    const hdr = b.dependency("hdr_histogram", .{
        .target = target,
    });

    const rediz = b.addExecutable(.{
        .name = "rediz",
        .target = target,
        .root_source_file = .{ .path = "helper.zig" },
    });
    rediz.installLibraryHeaders(hdr.artifact("hdr_histogram"));
    rediz.linkLibrary(hdr.artifact("hdr_histogram"));

    b.installArtifact(rediz);
    rediz.linkLibC();
    rediz.addCSourceFiles(&.{
        "src/threads_mngr.c",
        "src/server.c",
    }, &.{
        "-std=c99",
        "-pedantic",
        "-Wall",
        "-W",
        "-Wno-missing-field-initializers",
    });
}
