import JSON
import PrettyPrint

statsbomb_events_data = "/data/open-data-master/data/events/"
goal_size = 8 # yards?
# TODO: add more information characterizing the size of the field here.

#
# Common configuration
#

#
# Utility
#

"Parse a JSON file in Statsbomb format, and extract all events of a given type."
function get_events_by_type(filename, event_type)
    body = read(abspath(filename), String)
    events = JSON.parse(body)

    retval = []
    for event in events
        if lowercase(event["type"]["name"]) == lowercase(event_type)
            push!(retval, event)
        end
    end
    retval
end

function test_events_by_type()
    data_file = "$(statsbomb_events_data)/9948.json"
    retval = get_events_by_type(data_file, "shot")
    @assert length(retval) == 25
    PrettyPrint.pprint(retval[1])
    retval = get_events_by_type(data_file, "pass")
    @assert length(retval) == 1044
    true
end

function main()
    flag = true
    flag = flag && test_events_by_type()
    if flag
        println("All tests passed.")
    else
        println("Failed at least one test.")
    end
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end