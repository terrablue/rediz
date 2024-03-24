const std = @import("std");
const Builder = std.build.Builder;

pub fn build(b: *Builder) void {
    const target = b.standardTargetOptions(.{});

    const hdr = b.dependency("hdr_histogram", .{
        .target = target,
    });
    const hirediz = b.dependency("hirediz", .{
        .target = target,
    });
    const fpconv = b.dependency("fpconv", .{
        .target = target,
    });

    const rediz = b.addExecutable(.{
        .name = "rediz",
        .target = target,
        .root_source_file = .{ .path = "helper.zig" },
    });
    rediz.installLibraryHeaders(hdr.artifact("hdr_histogram"));
    rediz.installLibraryHeaders(hirediz.artifact("hirediz"));
    rediz.installLibraryHeaders(fpconv.artifact("fpconv"));
    rediz.linkLibrary(hdr.artifact("hdr_histogram"));
    rediz.linkLibrary(hirediz.artifact("hirediz"));
    rediz.linkLibrary(fpconv.artifact("fpconv"));

    b.installArtifact(rediz);
    rediz.linkLibC();
    rediz.addCSourceFiles(&.{
        "src/acl.c",
        "src/ae.c",
        "src/aof.c",
        "src/cluster.c",
        "src/cluster_legacy.c",
        "src/config.c",
        "src/db.c",
        "src/defrag.c",
        "src/evict.c",
        "src/memtest.c",
        "src/module.c",
        "src/sentinel.c",
        "src/server.c",
        "src/syscheck.c",
        "src/rdb.c",
        "src/threads_mngr.c",
    }, &.{
        "-std=c99",
        "-pedantic",
        "-Wall",
        "-W",
        "-Wno-missing-field-initializers",
    });
}
