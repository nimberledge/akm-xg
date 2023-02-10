include("../data-utils/Utils.jl")
import PrettyPrint
import JSON

function usage()
    println("Usage: julia <optionss> Utils.jl <data directory> <output filename>")
end

"Trim down the shot data to only the parameters we're interested in for now."
function trim_shot_data(events)
    retval = []
    for event in events
        tdict = Dict()
        tdict["location"] = event["location"]
        tdict["body_part"] = event["shot"]["body_part"]["name"]
        tdict["outcome"] = event["shot"]["outcome"]["name"]
        push!(retval, tdict)
    end
    retval
end

"Write out the trimmed shot dataset to a file."
function write_shot_dataset(filename, shots)
    json_str = JSON.json(shots)
    open(filename, "w+") do out_file
        write(out_file, json_str)
    end
    return true
end

function main()
    if length(ARGS) < 2
        usage()
        return nothing
    end
    data_directory = ARGS[1]
    output_filename = ARGS[2]
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
        println("Successfully wrote to: $(output_filename)")
    end
end


if abspath(PROGRAM_FILE) == @__FILE__
    main()
end