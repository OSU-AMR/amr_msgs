#updated task costs - published out my task manager threads
builtin_interfaces/Time stamp

int32 num_tasks #number of tasks being updated
int8 num_amrs #number of amrs present

#tasks to update -- index of the task as list in cost_matrices.yaml
int16[] start_index
int16[] end_index

#energy cost data
float32[] energy_cost 

#time cost data
float32[] time_cost

#cost arrays will be laid out in the following pattern
#   TASK(not stored in array)   Robot Type 0 Cost        Robot 1 Type Cost        ...     Robot N  TypeCost
#   #1                          index 0                  index 1                          index N - 1
#   #2                          index N                  index N + 1                      index 2N - 1
#   ...                         ...                      ...                              ...
#   #M                          index (M-1) * N          index (M-1) * N                  index (M * N) - 1