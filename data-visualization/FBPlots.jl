include("GeometryConstants.jl")

using Plots

function rectangle(w, h, x, y)
    return Plots.Shape(x .+ [0, w, w, 0], y .+ [0, 0, h, h])
end

"Draw a default football pitch based on Statsbomb coordinates.
By default, this function will output a plot with dimensions (160, 240)px.
For increased resolution, use the scale parameter which maintains aspect ratio and scales up the plot."
function get_default_pitch(; scale=1, title="", titlefont=nothing,
    border_col="white", grass_col="green3", line_col="black")

    if !isnothing(titlefont)
        p = plot([MIN_Y, MAX_Y, MAX_Y, MIN_Y, MIN_Y], [MIN_X, MIN_X, MAX_X, MAX_X, MIN_X], legend=false,
            title=title, size=(scale * 160, scale * 240), linecolor=border_col, axis=([], false), titlefont=titlefont)
    else
        p = plot([MIN_Y, MAX_Y, MAX_Y, MIN_Y, MIN_Y], [MIN_X, MIN_X, MAX_X, MAX_X, MIN_X], legend=false,
            title=title, size=(scale * 160, scale * 240), linecolor=border_col, axis=([], false))
    end

    # Field rectangle
    plot!(p, rectangle(MAX_Y, MAX_X, 0, 0), opacity=1, fillcolor=grass_col)
    # Plot halfway line
    plot!(p, [0, MAX_Y], [MAX_X / 2, MAX_X / 2], linecolor=line_col)

    # Plot goals
    plot!(p, rectangle(8, -3, (MAX_Y - GOAL_SIZE) / 2, 0), linecolor=line_col, fillcolor=border_col)
    plot!(p, rectangle(8, +3, (MAX_Y - GOAL_SIZE) / 2, MAX_X), linecolor=line_col, fillcolor=border_col)

    # Plot 18-yard box
    plot!(p, rectangle(BOX_WIDTH_18YRD, +BOX_HEIGHT_18YRD,
            (MAX_Y - GOAL_SIZE) / 2 - BOX_HEIGHT_18YRD, 0), linecolor=line_col, fillcolor=grass_col)
    plot!(p, rectangle(BOX_WIDTH_18YRD, -BOX_HEIGHT_18YRD,
            (MAX_Y - GOAL_SIZE) / 2 - BOX_HEIGHT_18YRD, MAX_X), linecolor=line_col, fillcolor=grass_col)

    # Plot the 6-yard box
    plot!(p, rectangle(BOX_WIDTH_6YRD, +BOX_HEIGHT_6YRD,
            (MAX_Y - GOAL_SIZE) / 2 - BOX_HEIGHT_6YRD, 0), linecolor=line_col, fillcolor=grass_col)
    plot!(p, rectangle(BOX_WIDTH_6YRD, -BOX_HEIGHT_6YRD,
            (MAX_Y - GOAL_SIZE) / 2 - BOX_HEIGHT_6YRD, MAX_X), linecolor=line_col, fillcolor=grass_col)

    # Plot penalty spots
    scatter!(p, [MAX_Y / 2, MAX_Y / 2], [D_RADIUS, MAX_X - D_RADIUS], markercolor=line_col)

    # Plot the Ds
    pts = Plots.partialcircle(π / 6, 5π / 6, scale * DEFAULT_CIRCLE_PTS, D_RADIUS)
    x, y = Plots.unzip(pts)
    x = x .+ MAX_Y / 2
    y = y .+ D_RADIUS
    plot!(p, x, y, linecolor=line_col)

    pts = Plots.partialcircle(7π / 6, 11π / 6, scale * DEFAULT_CIRCLE_PTS, D_RADIUS)
    x, y = Plots.unzip(pts)
    x = x .+ MAX_Y / 2
    y = y .+ (MAX_X - D_RADIUS)
    plot!(p, x, y, linecolor=line_col)

    # Plot center circle
    pts = Plots.partialcircle(0, 2π, DEFAULT_CIRCLE_PTS, CENTRE_CIRCLE_RADIUS)
    x, y = Plots.unzip(pts)
    x .+= MAX_Y / 2
    y .+= MAX_X / 2
    plot!(p, x, y, linecolor=line_col)
    p
end

function main()
    p = get_default_pitch(scale=5)
    display(p)
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end