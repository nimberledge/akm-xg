include!("../data-utils/Utils.jl")

using Plots

function rectangle(w, h, x, y)
    return Plots.Shape(x .+ [0, w, w, 0], y .+ [0, 0, h, h])
end

"Draw a default football pitch based on Statsbomb coordinates. This is defined by 
1. Field rectangle drawn from [0, 0], [0, 80], [120, 80], [120, 0] (yards)
2. Goal size of 8 yards

TODO: Rewrite things here because this thing swaps x and y (why did I do this??)"
function get_default_pitch(; scale=3, min_y=0, min_x=0, max_y=80, max_x=120, title="", titlefont=nothing,
    border_col="white", grass_col="green3", line_col="black")

    if !isnothing(titlefont)
        p = plot([min_y, max_y, max_y, min_y, min_y], [min_x, min_x, max_x, max_x, min_x], legend=false,
            title=title, size=(scale * 160, scale * 240), linecolor=border_col, axis=([], false), titlefont=titlefont)
    else
        p = plot([min_y, max_y, max_y, min_y, min_y], [min_x, min_x, max_x, max_x, min_x], legend=false,
            title=title, size=(scale * 160, scale * 240), linecolor=border_col, axis=([], false))
    end

    # Field rectangle
    plot!(p, rectangle(max_y, max_x, 0, 0), opacity=1, fillcolor=grass_col)
    # Plot halfway line
    plot!(p, [0, max_y], [max_x / 2, max_x / 2], linecolor=line_col)

    # Plot goals
    plot!(p, rectangle(8, -3, (max_y - goal_size) / 2, 0), linecolor=line_col, fillcolor=border_col)
    plot!(p, rectangle(8, +3, (max_y - goal_size) / 2, max_x), linecolor=line_col, fillcolor=border_col)

    # Plot 18-yard box
    plot!(p, rectangle(44, 18, (max_y - goal_size) / 2 - 18, 0), linecolor=line_col, fillcolor=grass_col)
    plot!(p, rectangle(44, -18, (max_y - goal_size) / 2 - 18, max_x), linecolor=line_col, fillcolor=grass_col)

    # Plot the 6-yard box
    plot!(p, rectangle(20, 6, (max_y - goal_size) / 2 - 6, 0), linecolor=line_col, fillcolor=grass_col)
    plot!(p, rectangle(20, -6, (max_y - goal_size) / 2 - 6, max_x), linecolor=line_col, fillcolor=grass_col)

    # Plot penalty spots
    scatter!(p, [max_y / 2, max_y / 2], [12, max_x - 12], markercolor=line_col)

    # Plot the Ds
    pts = Plots.partialcircle(π / 6, 5π / 6, 250, 12)
    x, y = Plots.unzip(pts)
    x = x .+ max_y / 2
    y = y .+ 12
    plot!(p, x, y, linecolor=line_col)

    pts = Plots.partialcircle(7π / 6, 11π / 6, 250, 12)
    x, y = Plots.unzip(pts)
    x = x .+ max_y / 2
    y = y .+ (max_x - 12)
    plot!(p, x, y, linecolor=line_col)

    # Plot center circle
    pts = Plots.partialcircle(0, 2π, 250, 10)
    x, y = Plots.unzip(pts)
    x .+= max_y / 2
    y .+= max_x / 2
    plot!(p, x, y, linecolor=line_col)
    p
end

function main()
    p = get_default_pitch()
    display(p)
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end