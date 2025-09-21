
// Comet Trail Shader for Ghostty
// This shader creates a trail that fades from the new cursor position
// to the previous cursor position.

// Easing function to make the fade effect non-linear and smoother.
float ease(float x) {
    // An exponential ease-out function.
    return 1.0 - pow(1.0 - x, 5.0);
}

// Function to calculate the signed distance from a point `p` to a line segment `a` -> `b`.
// This is used to determine if a pixel is part of the trail.
// Based on an article by Inigo Quilez.
float sdf_segment(in vec2 p, in vec2 a, in vec2 b) {
    vec2 pa = p - a, ba = b - a;
    float h = clamp(dot(pa, ba) / dot(ba, ba), 0.0, 1.0);
    return length(pa - ba * h);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    // Default to the existing terminal content.
    #if !defined(WEB)
      fragColor = texture(iChannel0, fragCoord.xy / iResolution.xy);
    #endif

    // --- Configuration ---
    // The base color of the trail. Uses Ghostty's cursor color uniform.
    const vec4 TRAIL_COLOR = g_cursor_color;
    // The duration of the trail effect in seconds.
    const float DURATION = 0.5;
    // The thickness of the trail in pixels.
    const float THICKNESS = 2.0;

    // --- Calculations ---

    // Calculate the time elapsed since the cursor last moved.
    // `progress` goes from 0.0 to 1.0 over the `DURATION`.
    float progress = clamp((iTime - iTimeCursorChange) / DURATION, 0.0, 1.0);

    // If the animation is finished, do nothing.
    if (progress >= 1.0) {
        return;
    }

    // Apply the easing function to the progress for a smoother animation.
    float easedProgress = ease(progress);

    // Get the cursor positions and size.
    vec2 current_pos = iCurrentCursor.xy;
    vec2 previous_pos = iPreviousCursor.xy;
    vec2 cursor_size = iCurrentCursor.zw;

    // Center the cursor positions.
    current_pos += cursor_size / 2.0;
    previous_pos += cursor_size / 2.0;

    // Calculate the distance from the current pixel (fragment) to the line
    // segment that forms the trail.
    float trail_dist = sdf_segment(fragCoord, previous_pos, current_pos);

    // The trail should start at the previous cursor position and end at the current one.
    // We can use the eased progress to "shorten" the trail over time.
    vec2 trail_start = mix(previous_pos, current_pos, easedProgress);

    // Recalculate the distance to the animated trail segment.
    float animated_trail_dist = sdf_segment(fragCoord, trail_start, current_pos);

    // --- Fading Effect (The "Comet" part) ---

    // Calculate the total length of the trail.
    float total_length = length(current_pos - previous_pos);

    // Calculate how far the current pixel is along the trail from the new cursor position.
    // This will be used to create the fading effect.
    float distance_from_head = length(fragCoord - current_pos);

    // Calculate the alpha (opacity) of the trail.
    // It's strongest near the current cursor and fades out towards the previous position.
    float alpha = 1.0 - clamp(distance_from_head / (total_length + 0.001), 0.0, 1.0);
    alpha *= (1.0 - easedProgress); // Fade out the entire trail over time.

    // --- Drawing ---

    // Create the trail color with the calculated alpha.
    vec4 trail_color = vec4(TRAIL_COLOR.rgb, TRAIL_COLOR.a * alpha);

    // Use smoothstep for anti-aliasing the edges of the trail.
    float trail_aa = 1.0 - smoothstep(THICKNESS - 1.0, THICKNESS + 1.0, animated_trail_dist);

    // Mix the trail color with the original fragment color.
    fragColor = mix(fragColor, trail_color, trail_aa);
}
