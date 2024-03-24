const std = @import("std");

pub fn build(b: *std.Build) void {
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
    const zua = b.dependency("zua", .{
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
    rediz.installLibraryHeaders(zua.artifact("zua"));
    rediz.linkLibrary(hdr.artifact("hdr_histogram"));
    rediz.linkLibrary(hirediz.artifact("hirediz"));
    rediz.linkLibrary(fpconv.artifact("fpconv"));
    rediz.linkLibrary(zua.artifact("zua"));

    b.installArtifact(rediz);
    rediz.linkLibC();
    rediz.addCSourceFiles(.{
        .files = &.{
            "src/acl.c",
            "src/adlist.c",
            "src/ae.c",
            "src/anet.c",
            "src/aof.c",
            "src/blocked.c",
            "src/bitops.c",
            "src/bio.c",
            "src/childinfo.c",
            "src/call_reply.c",
            "src/cluster.c",
            "src/cluster_legacy.c",
            "src/commands.c",
            "src/config.c",
            "src/connection.c",
            "src/crc16.c",
            "src/crc64.c",
            "src/crcspeed.c",
            "src/db.c",
            "src/debug.c",
            "src/defrag.c",
            "src/dict.c",
            "src/endianconv.c",
            "src/eval.c",
            "src/evict.c",
            "src/expire.c",
            "src/functions.c",
            "src/function_lua.c",
            "src/geo.c",
            "src/geohash.c",
            "src/geohash_helper.c",
            "src/hyperloglog.c",
            "src/intset.c",
            "src/kvstore.c",
            "src/lazyfree.c",
            "src/latency.c",
            "src/listpack.c",
            "src/localtime.c",
            "src/logreqres.c",
            "src/lolwut.c",
            "src/lolwut5.c",
            "src/lolwut6.c",
            "src/lzf_c.c",
            "src/lzf_d.c",
            "src/memtest.c",
            "src/module.c",
            "src/monotonic.c",
            "src/multi.c",
            "src/mt19937-64.c",
            "src/networking.c",
            "src/notify.c",
            "src/object.c",
            "src/pqsort.c",
            "src/pubsub.c",
            "src/rand.c",
            "src/rax.c",
            "src/rdb.c",
            "src/release.c",
            "src/redis-check-aof.c",
            "src/redis-check-rdb.c",
            "src/replication.c",
            "src/resp_parser.c",
            "src/rio.c",
            "src/quicklist.c",
            "src/script_lua.c",
            "src/script.c",
            "src/sds.c",
            "src/sentinel.c",
            "src/server.c",
            "src/setcpuaffinity.c",
            "src/setproctitle.c",
            "src/sha1.c",
            "src/sha256.c",
            "src/siphash.c",
            "src/slowlog.c",
            "src/socket.c",
            "src/sort.c",
            "src/sparkline.c",
            "src/strl.c",
            "src/syncio.c",
            "src/syscheck.c",
            "src/t_hash.c",
            "src/t_list.c",
            "src/t_set.c",
            "src/t_stream.c",
            "src/t_string.c",
            "src/t_zset.c",
            "src/threads_mngr.c",
            "src/timeout.c",
            "src/tls.c",
            "src/tracking.c",
            "src/unix.c",
            "src/util.c",
            "src/ziplist.c",
            "src/zipmap.c",
            "src/zmalloc.c",
        },
        .flags = &.{
            "-std=c99",
            "-pedantic",
            "-Wall",
            "-W",
            "-Wno-missing-field-initializers",
        },
    });
}
