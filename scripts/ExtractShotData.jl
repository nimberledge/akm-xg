#!/usr/bin/env julia

include("../data-utils/Utils.jl")

import PrettyPrint
import JSON
import CSV
import DataFrames

output_filename_stem = "data/shot_data"

function usage()
    println("USAGE: julia <options> $(PROGRAM_FILE) <output_filename>")
end

"Trim down the shot data to only the parameters we're interested in for now."
function trim_shot_data(events)
    retval = []
    for event in events
        location = event["location"]
        body_part = event["shot"]["body_part"]["name"]
        outcome = event["shot"]["outcome"]["name"]
        type = event["shot"]["type"]["name"]

        if type != "Open Play"
            continue
        end

        tdict = Dict(
            "location" => location,
            "body_part" => body_part,
            "outcome" => outcome,
            "type" => type,
        )
        push!(retval, tdict)
    end
    retval
end

"Write the given shots vector to a file, where the format is determined by the file extension."
function write_shot_dataset(output_filename, shots)
    if endswith(output_filename, ".csv")
        return write_shot_dataset_csv(output_filename, shots)
    elseif endswith(output_filename, ".json") 
        return write_shot_dataset_json(output_filename, shots)
    else
        println("Unknown file extension: please use any of: JSON, CSV: $(output_filename)")
        return false
    end
end

"Write the given shots vector to a JSON file."
function write_shot_dataset_json(filename, shots)
    json_str = JSON.json(shots)
    open(filename, "w+") do out_file
        write(out_file, json_str)
    end
    return true
end

"Write the given shots vector to a CSV file."
function write_shot_dataset_csv(filename, shots)
    shots = [tdict for tdict in shots]
    shots_df = DataFrames.DataFrame(
        location_x = [tdict["location"][1] for tdict in shots],
        location_y = [tdict["location"][2] for tdict in shots],
        body_part = [tdict["body_part"] for tdict in shots],
        outcome = [tdict["outcome"] for tdict in shots],
        type = [tdict["type"] for tdict in shots],
    )
    CSV.write(filename, shots_df)
    return true
end

function main()
    if length(ARGS) != 1
        println("ERROR: Invalid usage: $(ARGS)")
        usage()
        return nothing
    end

    output_filename = ARGS[1]

    data_directory = statsbomb_events_data

    shots = []
    file_cnt = 0
    for (idx, entry) in enumerate(readdir(abspath(data_directory), join=true))
        if idx % 100 == 0
            println("Read $(idx) files...")
        end
        shot_data = get_events_by_type(entry, "Shot")
        min_shot_data = trim_shot_data(shot_data)
        append!(shots, min_shot_data)
        file_cnt += 1
    end

    println("Parsed $(file_cnt) files to find shot data for $(length(shots)) shots.")
    println("Writing to $(output_filename)")
    if write_shot_dataset(output_filename, shots)
        println("INFO: Successfully wrote to: $(output_filename)")
    else 
        println("ERROR: Failed to write output file. See above.")
    end
end


if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
