const rl = @import("raylib");

pub fn main() !void {
    rl.initWindow(600, 100, "Language Stat");
    defer rl.closeWindow();
    rl.setTargetFPS(60);

    var langs: [5]LanguageData = undefined;
    fetchLangData(&langs);

    const barWidth = 500;
    const barHeight = 20;

    while (!rl.windowShouldClose()) {
        rl.beginDrawing();
        defer rl.endDrawing();
        rl.clearBackground(rl.Color.black);

        const x: f32 = 50.0;
        const y: f32 = 20.0;
        var totalWidth: f32 = 0;

        for (0..5) |i| {
            const width: f32 = langs[i].percentage / 100.0 * barWidth;
            rl.drawRectangle(@intFromFloat(x + totalWidth), @intFromFloat(y), @intFromFloat(width), barHeight, langs[i].color);
            totalWidth += width;
        }
        var legendX: f32 = 50.0;
        const legendY = 60.0;

        for (0..5) |i| {
            rl.drawRectangle(@intFromFloat(legendX), @intFromFloat(legendY), 10, 10, langs[i].color);
            const text = rl.textFormat("%s %2.1f", .{
                @as([*c]const u8, @ptrCast(langs[i].name.ptr)),
                langs[i].percentage,
            });
            rl.drawText(text, @as(i32, @intFromFloat(legendX)) + 20, legendY - 2, 10, rl.Color.ray_white);
            legendX += 100;
        }
    }
}

fn fetchLangData(lang: *[5]LanguageData) void {
    lang[0] = .{ .name = "Rust", .percentage = 82.0, .color = rl.Color.gold };

    lang[1] = .{ .name = "Java", .percentage = 7.1, .color = rl.Color.maroon };
    lang[2] = .{ .name = "C", .percentage = 4.9, .color = rl.Color.blue };
    lang[3] = .{ .name = "Zig", .percentage = 4.1, .color = rl.Color.purple };
    lang[4] = .{ .name = "Python", .percentage = 0.9, .color = rl.Color.dark_blue };
}

const LanguageData = struct {
    name: []const u8,
    percentage: f32,
    color: rl.Color,
};
