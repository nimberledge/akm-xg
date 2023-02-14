include("GeometryConstants.jl")

using Plots

function rectangle(w, h, x, y)
    return Plots.Shape(x .+ [0, w, w, 0], y .+ [0, 0, h, h])
end

"Draw a default football pitch based on Statsbomb coordinates.
By default, this function will output a plot with dimensions (240, 160)px.
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
    plot!(p, rectangle(GOAL_SIZE, -GOAL_HEIGHT, (MAX_Y - GOAL_SIZE) / 2, 0), linecolor=line_col, fillcolor=border_col)
    plot!(p, rectangle(GOAL_SIZE, +GOAL_HEIGHT, (MAX_Y - GOAL_SIZE) / 2, MAX_X), linecolor=line_col, fillcolor=border_col)

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

"Draw half a football pitch based on Statsbomb coordinates.
This plot will have corner points [(0, 0), (60, 0), (60, 80), (0, 80)]
which correspond to global points [(60, 0), (120, 0), (120, 80), (60, 80)]
By default, this function will output a plot with dimensions (120, 160)px.
For increased resolution, use the scale parameter which maintains aspect ratio and scales up the plot."
function get_half_pitch(; scale=1, title="", titlefont=nothing,
    border_col="white", grass_col="green3", line_col="black")

    if !isnothing(titlefont)
        p = plot([MIN_Y, MAX_Y, MAX_Y, MIN_Y, MIN_Y], [MIN_X, MIN_X, MAX_X_HALF_PITCH, MAX_X_HALF_PITCH, MIN_X], legend=false,
            title=title, size=(scale * 160, scale * 120), linecolor=border_col, axis=([], false), titlefont=titlefont)
    else
        p = plot([MIN_Y, MAX_Y, MAX_Y, MIN_Y, MIN_Y], [MIN_X, MIN_X, MAX_X / 2, MAX_X / 2, MIN_X], legend=false,
            title=title, size=(scale * 160, scale * 120), linecolor=border_col, axis=([], false))
    end

    # Field rectangle
    plot!(p, rectangle(MAX_Y, MAX_X / 2, 0, 0), opacity=1, fillcolor=grass_col)

    # Plot halfway line
    plot!(p, [0, MAX_Y], [0, 0], linecolor=line_col)

    # Plot goal
    plot!(p, rectangle(GOAL_SIZE, +GOAL_HEIGHT, (MAX_Y - GOAL_SIZE) / 2, MAX_X_HALF_PITCH), linecolor=line_col, fillcolor=border_col)

    # Plot 18-yard box
    plot!(p, rectangle(BOX_WIDTH_18YRD, -BOX_HEIGHT_18YRD,
            (MAX_Y - GOAL_SIZE) / 2 - BOX_HEIGHT_18YRD, MAX_X_HALF_PITCH), linecolor=line_col, fillcolor=grass_col)
    
    # Plot 6-yard box
    plot!(p, rectangle(BOX_WIDTH_6YRD, -BOX_HEIGHT_6YRD,
            (MAX_Y - GOAL_SIZE) / 2 - BOX_HEIGHT_6YRD, MAX_X_HALF_PITCH), linecolor=line_col, fillcolor=grass_col)

    # Plot the penalty spot
    scatter!(p, [MAX_Y / 2], [MAX_X_HALF_PITCH - D_RADIUS], markercolor=line_col)

    # Plot the D
    pts = Plots.partialcircle(7π / 6, 11π / 6, scale * DEFAULT_CIRCLE_PTS, D_RADIUS)
    x, y = Plots.unzip(pts)
    x = x .+ MAX_Y / 2
    y = y .+ (MAX_X_HALF_PITCH - D_RADIUS)
    plot!(p, x, y, linecolor=line_col)

    # Plot half of the centre circle (kind of unnecessary)
    pts = Plots.partialcircle(0, π, DEFAULT_CIRCLE_PTS, CENTRE_CIRCLE_RADIUS)
    x, y = Plots.unzip(pts)
    x .+= MAX_Y / 2
    plot!(p, x, y, linecolor=line_col)
    p
end

"Plot a single location on the pitch plot. Use half_pitch=true (on by default) to plot shots
on the relevant half-field."
function plot_location!(p :: Plots.Plot, location; half_pitch=true, markercolor="blue1")
    if half_pitch
        # Only make a copy if we have to adjust the coordinates
        tloc = copy(location)
        tloc[1] = location[1] - MAX_X_HALF_PITCH
    else
        tloc = location
    end
    scatter!(p, [tloc[2]], [tloc[1]], markercolor=markercolor)
end

"Plot a list of locations in dimensions [nshots, 2], where locations is a Matrix."
function plot_locations!(p :: Plots.Plot, locations; half_pitch=true, markercolor="blue1")
    if half_pitch
        # Only make a copy if we have to adjust the coordinates
        tloc = copy(locations)
        tloc[:, 1] = tloc[:, 1] .- MAX_X_HALF_PITCH
    else
        tloc = locations
    end
    scatter!(p, tloc[:, 2], tloc[:, 1], markercolor=markercolor)
end


function test_plot_location_hp()
    p = get_half_pitch(scale=5)
    plot_location!(p, [100, 37.5])
    plot_location!(p, [91.2, 42.5])
    plot_location!(p, [110, 65.61])
    plot_location!(p, [108, 40])
    display(p)
    true
end

function test_plot_locations_hp()
    # This really only tests if my functions compile, needs white box testing
    # to ensure it is working as expected. Does however serve as an example 
    # of the syntax used to call the functions
    p = get_half_pitch(scale=5, grass_col="white")
    n_locs = 4
    locations = zeros(Float32, n_locs, 2)
    locations[1, :] = [100, 37.5]
    locations[2, :] = [91.2, 42.5]
    locations[3, :] = [110, 65.61]
    locations[4, :] = [108, 40]
    plot_locations!(p, locations)
    display(p)
    true
end

function test_plot_location()
    p = get_default_pitch(scale=5)
    plot_location!(p, [100, 37.5], half_pitch=false)
    plot_location!(p, [91.2, 42.5], half_pitch=false)
    plot_location!(p, [110, 65.61], half_pitch=false)
    plot_location!(p, [108, 40], half_pitch=false)
    display(p)
    true
end

function test_plot_locations()
    p = get_default_pitch(scale=5, grass_col="white")
    n_locs = 4
    locations = zeros(Float32, n_locs, 2)
    locations[1, :] = [100, 37.5]
    locations[2, :] = [91.2, 42.5]
    locations[3, :] = [110, 65.61]
    locations[4, :] = [108, 40]
    plot_locations!(p, locations, half_pitch=false)
    display(p)
    true
end


function main()
    flag = true
    # flag = flag && test_plot_location()
    flag = flag && test_plot_locations()
    if flag
        println("All tests passed")
    else
        println("Some tests failed")
    end
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end