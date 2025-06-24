#updated task costs - published out my task manager threads
builtin_interfaces/Time stamp

int32 num_tasks #number of tasks being updates
int8 num_amrs #number of amrs present

#tasks to update
int8[] tasks

#energy cost data
float32[] energy_cost 

#time cost data
float32[] time_cost

#cost arrays will be laid out in the following pattern
#   TASK(not stored in array)   Robot 0 Cost        Robot 1 Cost        ...     Robot N Cost
#   #1                          index 0             index 1                     index N - 1
#   #2                          index N             index N + 1                 index 2N - 1
#   ...                         ...                 ...                         ...
#   #M                          index (M-1) * N     index (M-1) * N             index (M * N) - 1